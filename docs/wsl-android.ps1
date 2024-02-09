param (
    [int]$Port = $Port
)

# Etapa 1: Configurar port forwarding para o Metro Bundler
Write-Host "Configurando port forwarding para o Metro Bundler..."
iex "netsh interface portproxy delete v4tov4 listenport=8081 listenaddress=127.0.0.1" | Out-Null;
$WSL_CLIENT = bash.exe -c "ip addr show eth0 | grep 'inet '"
$WSL_CLIENT -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
$WSL_CLIENT = $matches[0];
iex "netsh interface portproxy add v4tov4 listenport=8081 listenaddress=127.0.0.1 connectport=8081 connectaddress=$WSL_CLIENT"
Write-Host "[OK] Port forwarding configurado com sucesso."

# Etapa 2: Parar o adb server
Write-Host "Parando o servidor adb"
adb kill-server
Write-Host "[OK] Servidor adb parado com sucesso"

Start-Sleep -Seconds 30

# Etapa 2: Iniciar o adb server e iniciar o emulador
Write-Host "Iniciando o adb server e emulador"
Start-Process -NoNewWindow -FilePath adb -ArgumentList "-a nodaemon server start -wipe-data"
Start-Process -NoNewWindow -FilePath emulator -ArgumentList "-avd emulator -no-snapshot"
Write-Host "[OK] Servidor adb e emulador inicializado com sucesso"

# Esperar um momento para o emulador iniciar completamente (pode adicionar mais tempo se necessário)
Start-Sleep -Seconds 45

# Etapa 3: Configurar redirecionamento de porta para o dispositivo Android
adb reverse tcp:8081 tcp:8081
Write-Host "[OK] Redirecionamento realizado com sucesso"

# Etapa 4: Configurar redirecionamento de porta para socat (WSL)
$WSL_HOST = bash.exe -c "ip route | grep '^default via ' | awk '{print $3}'"
$WSL_HOST = $WSL_HOST.Trim()
$SOCAT_CMD = "socat -d -d TCP-LISTEN:$Port,reuseaddr,fork TCP:$WSL_HOST:$Port"
Start-Process -NoNewWindow -FilePath wsl -ArgumentList "-e $SOCAT_CMD"
Write-Host "[OK] Socat realizado com sucesso"
