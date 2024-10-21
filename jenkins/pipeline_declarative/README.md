
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
19. [Stage>When(Part2)-ChangeRequest](#Stage>When(Part2)-ChangeRequest)
20. [Stage>When(Part2)-ChangeSet](#Stage>When(Part2)-ChangeSet)
21. [Stage>When(Part3)-BeforeAgent](#Stage>When(Part3)-BeforeAgent)
22. [Stage>Parallel/FailFast](#Stage>Parallel/FailFast)
23. [Stage>Input](#Stage>Input)
24. [Stage>Post](#Stage>Post)
25. [Options>BuildDiscarder](#Options>BuildDiscarder)
26. [Options>DisableConcurrentBuilds](#Options>DisableConcurrentBuilds)
27. [Options>OverrideIndexTriggers](#Options>OverrideIndexTriggers)
28. [Options>SkipStagesAfterUnstable](#Options>SkipStagesAfterUnstable)
29. [Options>CheckoutToSubdirectory](#Options>CheckoutToSubdirectory)
30. [Options>NewContainerPerStage](#Options>NewContainerPerStage)
31. [Parameters](#Parameters)
32. [Pipeline-Triggers>Cron](#Pipeline-Triggers>Cron)
33. [Pipeline-Triggers>PollSCM](#Pipeline-Triggers>PollSCM)
34. [Pipeline-Triggers>Upstream](#Pipeline-Triggers>Upstream)
35. [Pipeline-Agent>Docker](#Pipeline-Agent>Docker)
36. [VARIABLES](#VARIABLES)













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

1.)
```
pipeline {
    agent any
    environment {
        ENV_VAR1 = 'JOHN'
    }
    stages {
        stage('PASS') {
            steps {
                script {
                    myVar="Hello from Stage 1"
                }
              }
            }
        stage('GET') {
            steps {
                script {
                    // Użycie zmiennej zdefiniowanej w poprzednim etapie
                    echo "The value of myVar is: ${myVar}"
                 }
                }
            }
        }
    }

```
2.)   
```
pipeline {
    agent any
    parameters {
        string(name: 'USER_NAME', defaultValue: 'Anonymous', description: 'Podaj swoje imię')
        booleanParam(name: 'DEPLOY', defaultValue: false, description: 'Czy wdrożyć?')
    }
    stages {
        stage('Use Parameters') {
            steps {
                script {
                    echo "Witaj ${params.USER_NAME}!"
                    if (params.DEPLOY) {
                        echo "Wdrażam aplikację..."
                    } else {
                        echo "Pomijam wdrażanie."
                    }
                }
            }
        }
    }
}
```

# Lockable Resources
JESLI CHCESZ ZABLOKOWAC JAKIS RESOURCE NP PLIK DLA INNYCH PIPELINE
PLUGIN >> LOCKABLE RESOURCES  

```
stage('read file lockable resources') {
            steps {
                 script {
                      lock(resource: 'shared-file') {
                                def fileContent = readFile '/var/jenkins_home/plik.txt'
                                echo "Zawartość pliku: ${fileContent}"
                          } 
                        }
                     }
            }
```



# Stage>Input


```
stage('Await Input') {
            steps {
                script {
                    // Przykład prostego pytania o potwierdzenie
                    def userInput = input(
                        message: 'Czy chcesz kontynuować?',
                        ok: 'Tak', // Przycisk potwierdzający
                        parameters: [
                            string(name: 'userName', defaultValue: 'kuba', description: 'Podaj swoje imię'),
                            booleanParam(name: 'confirm', defaultValue: true, description: 'Potwierdź')
                        ]
                    )
                    echo "Użytkownik wpisał: ${userInput}"
                }
            }
        }
```

# VARIABLES

BUILD_NUMBER  
BUILD_ID  
BUILD_URL  
JOB_NAME  
BUILD_TAG  
WORKSPACE  
GIT_COMMIT  
GIT_URL  
NODE_NAME  
JENKINS_HOME  
JENKINS_URL  
EXECUTOR_NUMBER  
NODE_LABELS  
STAGE_NAME  
BRANCH_NAME  
CHANGE_ID  
