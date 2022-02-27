pipeline {
  agent {
    docker{
    image 'gradle'
  }
  }

  stages {

    stage('Build') {
      steps {
        sh 'gradle build'
        sh 'gradle javadoc'
        archiveArtifacts 'build/test-results/test/*'
        archiveArtifacts 'build/libs/*'
      }

      post {
        failure {
          mail(subject: 'TPjenkins Build Failed', body: 'Hello, the build has failed!', from: 'gm_sahraoui@esi.dz', to: 'gm_sahraoui@esi.dz')
        }
      }
    }

    stage('Mail Notification') {
      steps {
        mail(subject: 'TPjenkins Build Successful', body: 'Hello, the build is successful, cheers', from: 'gm_sahraoui@esi.dz', to: 'gm_sahraoui@esi.dz')
      }
    }

    stage('Code Analysis') {
      parallel {
        stage('Code Analysis') {
          steps {
            withSonarQubeEnv('SonarEnv'){
            sh 'gradle sonarqube'
            }
            waitForQualityGate true
          }
        }

        stage('Test Reporting') {
          steps {
            cucumber '**/*.json'
          }
        }

      }
    }

    stage('Deployement') {
      steps {
        sh 'gradle publish'
      }
    }

    stage('Slack Notification') {
      steps {
        slackSend(message: 'Hello, the build is successful, cheers', color: 'good')
      }
    }
  }
}
