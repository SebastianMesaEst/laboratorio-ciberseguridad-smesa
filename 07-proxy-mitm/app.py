
import os
import requests

from flask import Flask, Response

app = Flask(__name__)

TARGET_DMZ = os.environ.get(
    "TARGET_DMZ",
    "https://servidor-web-dmz-smesa.onrender.com"
)

@app.route("/")
def proxy():

    print("[MITM] Solicitud recibida por el proxy.")
    print(f"[MITM] Consultando servidor DMZ: {TARGET_DMZ}")

    try:
        respuesta = requests.get(
            TARGET_DMZ,
            timeout=40
        )

        print(f"[MITM] Respuesta original: HTTP {respuesta.status_code}")

        contenido = respuesta.text

        # Modificacion visible para la demostracion
        alerta = """
        <div style="
            background:#7f1d1d;
            color:white;
            padding:18px;
            margin:20px auto;
            max-width:700px;
            border-radius:10px;
            font-family:Arial,sans-serif;
            text-align:center;">
            <h2>ALERTA: INTERCEPTACION MITM</h2>
            <p>Esta respuesta fue modificada por el proxy
            como parte de una demostracion educativa.</p>
            <p>Origen: Servidor DMZ del laboratorio</p>
        </div>
        """

        contenido = contenido.replace(
            "<body>",
            "<body>" + alerta,
            1
        )

        print("[MITM] Contenido modificado correctamente.")

        return Response(
            contenido,
            status=respuesta.status_code,
            content_type="text/html; charset=utf-8"
        )

    except requests.RequestException as error:

        print(f"[MITM] Error de comunicacion: {error}")

        return Response(
            "No fue posible comunicarse con el servidor DMZ.",
            status=502,
            content_type="text/plain; charset=utf-8"
        )


@app.route("/health")
def health():
    return {"estado": "activo", "modulo": "Proxy MITM"}, 200


if __name__ == "__main__":

    puerto = int(os.environ.get("PORT", 10000))

    print("========================================")
    print(" MODULO 07 - PROXY MITM")
    print("========================================")
    print(f"Servidor DMZ objetivo: {TARGET_DMZ}")
    print(f"Proxy iniciado en puerto: {puerto}")

    app.run(
        host="0.0.0.0",
        port=puerto
    )
