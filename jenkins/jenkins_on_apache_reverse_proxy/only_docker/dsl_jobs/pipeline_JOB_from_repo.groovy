pipelineJob('A_Terraform_Infrastracture_create_pipeline') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/fanfanafankianki/JenkinsCreator.git')
                    }
                    branch('main')
                }
            }
            scriptPath('Terraform_stack_pipelines/A_terraform_stack_create.json')
        }
    }
}
