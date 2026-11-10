
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

ESTUDIANTE = os.environ.get(
    "ESTUDIANTE_NOMBRE",
    "Sebastián Mesa Meneses"
)

class DMZHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path == "/":
            contenido = f"""
            <!DOCTYPE html>
            <html lang="es">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Servidor DMZ - Laboratorio</title>
                <style>
                    body {{
                        background: #101820;
                        color: #ffffff;
                        font-family: Arial, sans-serif;
                        text-align: center;
                        padding: 60px 20px;
                    }}
                    .contenedor {{
                        max-width: 700px;
                        margin: auto;
                        padding: 35px;
                        background: #1d2b36;
                        border-radius: 15px;
                    }}
                    h1 {{ color: #00d084; }}
                    .estado {{ color: #00d084; font-weight: bold; }}
                </style>
            </head>
            <body>
                <div class="contenedor">
                    <h1>Servidor DMZ activo</h1>
                    <h2>Laboratorio de Ciberseguridad</h2>
                    <p><strong>Estudiante:</strong> {ESTUDIANTE}</p>
                    <p class="estado">Estado: Servidor funcionando correctamente</p>
                    <p>Este servidor forma parte de un entorno de pruebas
                    controlado con fines educativos.</p>
                </div>
            </body>
            </html>
            """
            self.send_response(200)
            self.send_header("Content-type", "text/html; charset=utf-8")
            self.end_headers()
            self.wfile.write(contenido.encode("utf-8"))

        elif self.path == "/admin":
            self.respuesta("Ruta administrativa de demostración", 200)

        elif self.path == "/login":
            self.respuesta("Página de inicio de sesión de laboratorio", 200)

        elif self.path == "/secret":
            self.respuesta("Recurso de prueba del laboratorio", 200)

        elif self.path == "/backup.zip":
            self.respuesta("Archivo de respaldo simulado", 200)

        else:
            self.respuesta("Recurso no encontrado", 404)

    def respuesta(self, mensaje, codigo):
        self.send_response(codigo)
        self.send_header("Content-type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(mensaje.encode("utf-8"))

    def log_message(self, formato, *args):
        print(f"[DMZ] {self.address_string()} - {formato % args}")

puerto = int(os.environ.get("PORT", 10000))

servidor = HTTPServer(("0.0.0.0", puerto), DMZHandler)

print(f"Servidor DMZ iniciado en el puerto {puerto}")
print(f"Estudiante: {ESTUDIANTE}")

servidor.serve_forever()
