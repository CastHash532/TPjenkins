pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        tool 'gradle'
        sh 'gradle build'
      }
    }

  }
}