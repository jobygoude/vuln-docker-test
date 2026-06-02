# Intentionally uses EOL Python 3.6 on Debian Buster — known HIGH/CRITICAL CVEs for testing
FROM python:3.6-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8080
CMD ["python", "app.py"]
