
#!/bin/sh

set -eu

TARGET="${TARGET_DMZ:-https://servidor-web-dmz-smesa.onrender.com}"

echo "========================================"
echo " MODULO 01 - SIMULACION CONTROLADA DoS"
echo "========================================"
echo "Objetivo: $TARGET"
echo "Solicitudes programadas: 10"
echo "Ritmo: una solicitud por segundo"
echo ""

for i in $(seq 1 10); do
    echo "[DoS] Solicitud $i de 10"

    curl --max-time 15 -s -o /dev/null \
        -w "Código HTTP: %{http_code} | Tiempo: %{time_total}s\n" \
        "$TARGET" || echo "No fue posible completar la solicitud"

    sleep 1
done

echo ""
echo "[DoS] Simulación finalizada."
echo "[DoS] El servidor objetivo no debe haber sido saturado."

echo "[INFO] Iniciando servicio de consulta de logs..."
python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0
