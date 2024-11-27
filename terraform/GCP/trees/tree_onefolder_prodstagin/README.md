




```
terraform/
├── main.tf                # Główna konfiguracja wywołująca moduły
├── variables.tf           # Definicje zmiennych dla środowisk
├── outputs.tf             # Wyjścia wspólne dla wszystkich środowisk
├── staging.tfvars         # Wartości zmiennych dla środowiska staging
├── production.tfvars      # Wartości zmiennych dla środowiska production
├── modules/               # Folder z modułami
│   ├── compute/           # Moduł zarządzający maszynami wirtualnymi
│   │   ├── main.tf        # Logika modułu (np. definicja instancji)
│   │   ├── variables.tf   # Zmienne wymagane przez moduł
│   │   ├── outputs.tf     # Wyjścia z modułu compute
│   ├── network/           # Moduł zarządzający siecią
│   │   ├── main.tf        # Logika modułu (np. VPC, subnety)
│   │   ├── variables.tf   # Zmienne wymagane przez moduł
│   │   ├── outputs.tf     # Wyjścia z modułu network
│   ├── storage/           # Moduł zarządzający dyskami i bucketami
│   │   ├── main.tf        # Logika modułu (np. dyski, Cloud Storage)
│   │   ├── variables.tf   # Zmienne wymagane przez moduł
│   │   ├── outputs.tf     # Wyjścia z modułu storage
```
