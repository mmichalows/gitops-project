# Używamy lekkiego obrazu bazowego z Pythonem
FROM python:3.11-alpine

# Ustawiamy katalog roboczy wewnątrz kontenera
WORKDIR /app

# Kopiujemy pliki z zależnościami i instalujemy je
COPY requirements .
RUN pip install --no-cache-dir -r requirements

# Kopiujemy kod naszej aplikacji
COPY app.py .

# Informujemy, że aplikacja nasłuchuje na porcie 8080
EXPOSE 8080

# Komenda startowa
CMD ["python", "app.py"]
