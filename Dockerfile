Remplacer l'image de base par une version LTS activement maintenue et exécuter le conteneur avec un utilisateur non privilégié.

Diff suggéré :

- # Intentionally uses EOL Python 3.6 on Debian Buster — known HIGH/CRITICAL CVEs for testing
- FROM python:3.6-buster
+ # Utiliser une image officielle maintenue et minimale
+ FROM python:3.12-slim-bookworm

  WORKDIR /app

+ # Créer et utiliser un utilisateur non privilégié
+ RUN useradd --create-home --shell /bin/bash appuser
+
  COPY requirements.txt .
  RUN pip install --no-cache-dir -r requirements.txt

  COPY app.py .

+ USER appuser
+
  EXPOSE 8080
  CMD ["python", "app.py"]

Recommandations complémentaires :
- Épingler les dépendances de requirements.txt avec des versions exactes et vérifier les hachages (pip install --require-hashes).
- Ajouter un scan de vulnérabilités d'image (Trivy, Grype) et un rafraîchissement régulier de l'image de base.
- Utiliser une image distroless ou alpine maintenue si la compatibilité le permet.