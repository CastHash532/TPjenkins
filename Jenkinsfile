pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        tool 'gradle'
        withGradle() {
          sh 'gradle build'
        }

      }
    }

  }
}