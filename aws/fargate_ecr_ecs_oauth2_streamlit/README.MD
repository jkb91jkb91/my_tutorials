# ECS Fargate Platform Starter

Production-ready szkielet do uruchamiania aplikacji kontenerowych w AWS z pomocą ECS + Fargate, HTTPS, CI/CD i monitoringiem.

## 🧠 Co to robi?

Ten projekt pozwala szybko uruchomić:
- Aplikację w kontenerze (Fargate)
- HTTPS przez ACM + ALB
- Podstawowe role IAM
- Infrastruktura jako kod – Terraform

✅ Idealne jako starter dla startupu / MVP / microservice

## 🗺️ Architektura

![Diagram](./diagram.png)

## ⚙️ Stack

- AWS ECS Fargate
- ALB + ACM
- Terraform (modułowe podejście)
- GitHub Actions (w wersji PRO)
- Prometheus (w wersji PRO)

## 🚀 Jak uruchomić

```bash
git clone ...
cd ecs-starter
terraform init
terraform apply


