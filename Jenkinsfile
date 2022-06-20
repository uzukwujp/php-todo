pipeline {
    agent any

    stages {

        stage('Initial Cleanup') {
            steps {
            dir("${WORKSPACE}") {
              deleteDir()
            }
          }
        }

        stage ('Checkout Repo'){
            steps {
            git branch: 'main', url: 'https://github.com/uzukwujp/php-todo.git'
      }
        }

        stage ('Build and Push Docker Image') {
            steps {
                docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                    def buidImage = docker.build("uzukwujp/php-todo:${env.BRANCH_NAME}-${env.BUILD_NUMBER}")

                    #push the image to docker hub
                    buildImage.push()
                }
            }
        }

    }
}