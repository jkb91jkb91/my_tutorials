



1. [Get Output of Shell Script](#Get-Output-of-Shell-Script)
2. [Creating-Env-Variable](#Creating-Env-Variable)
3. [Triggering and passing params between jobs](#Triggering-and-passing-params-between-jobs)
4. [Lockable Resources](#Lockable-Resources)
5. [Agent](#Agent)
6. [Tools](#Tools)
7. [Stage>Steps>Script](#Stage>Steps>Script)
8. [Stage>Steps>Retry/Timeouts](#Stage>Steps>Retry/Timeouts)
9. [Stage>Options>Error/Retry](#Stage>Options>Error/Retry)
10. [Stage>Options>Timeout](#Stage>Options>Timeout)
11. [Stage>Options>Timestamps](#Stage>Options>Timestamps)
12. [Stage>Options>Timestamps-ALTERNATIVE](#Stage>Options>Timestamps-ALTERNATIVE)
13. [Stage>Options>SkipDefaultCheckout](#Stage>Options>SkipDefaultCheckout)
14. [Stage>Environment Credentials](#Stage>Environment-Credentials)
15. [Stage>When(Part1)](#Stage>When(Part1))
16. [Stage>When(Part2)-BRANCH](#Stage>When(Part2)-BRANCH)
17. [Stage>When(Part2)-BuildingTag&Tag](#Stage>When(Part2)-BuildingTag&Tag)
18. [Stage>When(Part2)-CHANGELOG](#Stage>When(Part2)-CHANGELOG)














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

# Creating Env Variable
environment section=global variable
script section=local variables
script section-witEnv section=local variable but lasting only in block
```
pipeline {
    agent any
    environment {
        ENV_VAR1 = 'JOHN'
        // Definiowanie zmiennych lokalnie w skrypcie za pomocą 'def' nie jest możliwe w declarative, więc korzystamy z kroku script.
    }
    stages {
        stage('Build') {
            steps {
                script {
                    def NOT_ENV_VAR1 = 'SMITH'

                    // Wywoływanie zmiennych środowiskowych
                    sh 'echo ENV_VAR1 : $ENV_VAR1'
                    echo "NOT_ENV_VAR1 : ${NOT_ENV_VAR1}"
                    sh "echo NOT_ENV_VAR1 : ${NOT_ENV_VAR1}"

                    // Ustawianie zmiennych środowiskowych za pomocą withEnv
                    withEnv(['ENV_VAR2=Groovy', 'MVN_VERSION=mvn --version']) {
                        sh 'echo ENV_VAR2 : $ENV_VAR2'
                        sh '$MVN_VERSION'
                        sh 'printenv'
                    }
                }
            }
        }
    }
}

```

# Triggering and passing params between jobs

```

```
