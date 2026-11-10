
#!/bin/sh

set -eu

HOST="${TARGET_HOST:-servidor-web-dmz-smesa.onrender.com}"

echo "========================================"
echo " MODULO 02 - ESCANEO DE PUERTOS"
echo "========================================"
echo "Objetivo autorizado: $HOST"
echo "Puertos que se comprobaran: 21 22 80 443 8080 3306"
echo ""

for PORT_SCAN in 21 22 80 443 8080 3306; do
    echo "[ESCANEO] Comprobando puerto $PORT_SCAN..."

    if nc -z -w 2 "$HOST" "$PORT_SCAN" 2>/dev/null; then
        echo "[RESULTADO] Puerto $PORT_SCAN: ABIERTO"
    else
        echo "[RESULTADO] Puerto $PORT_SCAN: CERRADO O SIN RESPUESTA"
    fi
done

echo ""
echo "[ESCANEO] Proceso finalizado."
echo "[INFO] Iniciando servicio de estado..."

mkdir -p /tmp/empty

python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0 --directory /tmp/empty
