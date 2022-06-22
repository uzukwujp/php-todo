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

        stage ('Build Docker Image') {
            steps {
                script {

                       sh "docker build -t uzukwujp/php-todo:${env.BRANCH_NAME}-${env.BUILD_NUMBER} ."
                }
            }
        }

        stage ('Start Up Container') {
            steps {
                script {
                    sh "docker run -d --name todo-app -p 8000:8000 uzukwujp/php-todo:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                }
            }
        }


        stage ('Test Container') {
            steps {
                script {
                    sh  "curl -i http://3.236.225.2:8000"
                }
            }
        }

        stage ('Push Docker Image') {
            steps{
                script {
            sh "docker login -u ${env.username} -p ${env.password}"

            sh "docker push uzukwujp/php-todo:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
            }
          }
        }

        

        stage ('Clean Up') {
            steps {
                script {
                    sh " docker stop todo-app"
                    sh "docker rm todo-app"
                    sh "docker rmi uzukwujp/php-todo:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                }
            }
        }

        stage ('logout Docker') {
            steps {
                script {

                    sh "docker logout"

                }
            }
        }

    }
}