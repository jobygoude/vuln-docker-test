# Intentionally uses EOL Python 3.6 on Debian Buster — known HIGH/CRITICAL CVEs for testing
FROM python:3.6-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .


# Sécurité DevSecOps : Création d'un utilisateur applicatif non-root (principe du moindre privilège)
RUN groupadd -g 1001 appgroup && useradd -u 1001 -g appgroup -s /bin/sh -m appuser && chown -R appuser:appgroup /opt/app
USER 1001:1001
EXPOSE 8080
CMD ["python", "app.py"]
