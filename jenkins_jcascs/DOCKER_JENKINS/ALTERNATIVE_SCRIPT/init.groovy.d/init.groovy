import groovy.json.JsonSlurper
import jenkins.model.*
import hudson.model.*
import javaposse.jobdsl.plugin.ExecuteDslScripts

def repoUrl = 'https://raw.githubusercontent.com/jkb91jkb91/my_tutorials/main/terraform/projekt_bartek/jenkins_jobs/create_stack.json'

// Pobierz plik JSON z repozytorium
def pipelineJson = new URL(repoUrl).text
def jobName = 'CreateStackJob'
def jobDslScript = """
pipelineJob('${jobName}') {
    definition {
        cps {
            script(\"\"\"
${pipelineJson}
\"\"\")
            sandbox()
        }
    }
}
"""

// Tworzenie zadania w Jenkinsie za pomocą Job DSL
def jenkinsInstance = Jenkins.getInstance()
def seedJob = jenkinsInstance.getItem('seedJob')
if (seedJob == null) {
    seedJob = jenkinsInstance.createProject(FreeStyleProject, 'seedJob')
}
seedJob.getBuildersList().clear()
seedJob.getBuildersList().add(new ExecuteDslScripts(
    new ExecuteDslScripts.ScriptLocation('true', '', jobDslScript),
    true, 
    new javaposse.jobdsl.plugin.RemovedJobAction(javaposse.jobdsl.plugin.RemovedJobAction.IGNORE), 
    new javaposse.jobdsl.plugin.RemovedViewAction(javaposse.jobdsl.plugin.RemovedViewAction.IGNORE)
))
seedJob.save()
println("Seed Job utworzony z konfiguracją: ${jobName}")
seedJob.scheduleBuild2(0)
