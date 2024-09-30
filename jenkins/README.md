



1. [Get Output of Shell Script](#Get-Output-of-Shell-Script)
2. [Instalacja](#instalacja)
3. [Użycie](#użycie)
4. [Konfiguracja](#konfiguracja)
   - [Opcja 1](#opcja-1)
   - [Opcja 2](#opcja-2)
5. [FAQ](#faq)
6. [Kontakt](#kontakt)











#  Get Output of Shell Script
```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                script {
                    // Uruchomienie polecenia bashowego ls -al
                    def shellOutput = sh(script: "ls -al", returnStdout: true).trim()
                    echo "Output from shell command: ${shellOutput}"

                    // Uruchomienie polecenia bashowego z echo
                    sh "echo 'Hello from Bash'"
                }
            }
        }
    }
}

```
