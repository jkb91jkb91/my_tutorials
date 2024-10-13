FROM jenkins/inbound-agent


USER root

# Zaktualizuj pakiety i zainstaluj Dockera
RUN apt-get update && \
    apt-get install -y docker.io

# Opcjonalnie dodaj jenkins do grupy docker, aby Jenkins mógł używać Dockera
RUN usermod -aG docker jenkins

# Przywróć domyślnego użytkownika
USER jenkins
