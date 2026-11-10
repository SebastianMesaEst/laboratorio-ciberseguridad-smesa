
#!/bin/sh

set -eu

TARGET="${TARGET_DMZ:-https://servidor-web-dmz-smesa.onrender.com}"

echo "========================================"
echo " MODULO 03 - ENUMERACION DE RUTAS WEB"
echo "========================================"
echo "Objetivo autorizado: $TARGET"
echo ""

RUTAS="
/admin
/config.php
/login
/secret
/backup.zip
/index.html
"

for RUTA in $RUTAS; do
    echo "[ENUMERACION] Probando ruta: $RUTA"

    CODIGO=$(curl -L -s -o /dev/null \
        --max-time 15 \
        -w "%{http_code}" \
        "$TARGET$RUTA" || echo "ERROR")

    echo "[RESULTADO] $RUTA -> HTTP $CODIGO"
    sleep 1
done

echo ""
echo "[ENUMERACION] Proceso finalizado."
echo "[INFO] Iniciando servicio de estado..."

mkdir -p /tmp/empty

python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0 --directory /tmp/empty
