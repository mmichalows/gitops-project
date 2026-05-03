from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
    version = os.environ.get("APP_VERSION", "1.0.0")
    return f"<h1>Witaj w swiecie GitOps!</h1><p>Wersja aplikacji: {version}</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
