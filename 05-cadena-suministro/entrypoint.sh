
#!/bin/sh

set -eu

echo "========================================"
echo " MODULO 05 - CADENA DE SUMINISTRO"
echo "========================================"

echo "[INFO] Iniciando aplicacion de laboratorio..."
sleep 1

echo "[ALERTA] Se detecto una dependencia simulada con comportamiento inesperado."
echo "[ANALISIS] El componente intento ejecutar una accion no autorizada."
echo "[SEGURIDAD] No se ejecutaron acciones externas ni se modificaron archivos."

echo ""
echo "[INFO] Simulacion de cadena de suministro finalizada."
echo "[INFO] Iniciando servicio de estado..."

mkdir -p /tmp/empty

python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0 --directory /tmp/empty
