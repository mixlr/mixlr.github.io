def notifySlack(event) {
  if (env.CHANGE_URL) {
    suffix = "<${env.CHANGE_URL}|${env.JOB_NAME}>: (<${env.BUILD_URL}|#${env.BUILD_ID}>)"
  } else {
    suffix = "<${env.GIT_URL}|${env.JOB_NAME}> (<${env.BUILD_URL}|#${env.BUILD_ID}>)"
  }

  switch(event) {
    case "started":
      message = ":building_construction: Building ${suffix}"
      color = "#cccccc"
      break
    case "success":
      message = ":jenkins_success: Success ${suffix}"
      color = "good"
      break
    case "failure":
      message = ":jenkins: Failure ${suffix}"
      color = "danger"
      break
    case "aborted":
      message = ":jenkins: Aborted ${suffix}"
      color = "danger"
      break
    case "unstable":
      message = ":jenkins: Unstable ${suffix}"
      color = "danger"
      break
  }

  slackSend(message: message, channel: 'jenkins', color: color)
}

pipeline {
  agent {
    node { label 'docker' }
  }

  options {
    disableConcurrentBuilds()
    ansiColor('xterm')
  }

  environment {
    IMAGE_NAME = "mixlr/tech_blog"
    IMAGE_TAG  = "latest"
    IMAGE      = "${env.IMAGE_NAME}:${env.IMAGE_TAG}"
  }

  stages {
    stage('Clone') {
      steps {
        step([$class: 'WsCleanup'])
        checkout scm
      }
    }

    stage('Build') {
      steps {
        notifySlack('started')
        sh "docker build -t ${env.IMAGE} ."
        sh "docker run -v ${WORKSPACE}:/var/www/blog --rm ${env.IMAGE} jekyll clean"
        sh "docker run -v ${WORKSPACE}:/var/www/blog --rm ${env.IMAGE} jekyll build"
      }
    }

    stage('Test') {
      steps {
        sh "docker run --name selenium-chrome-standalone -d -p 4444:4444 -v /dev/shm:/dev/shm selenium/standalone-chrome:3.4.0"
        sh "docker run -v ${WORKSPACE}:/var/www/blog --rm ${env.IMAGE} rspec"
      }

      post {
        always {
          sh "docker kill selenium-chrome-standalone"
          sh "docker rm selenium-chrome-standalone"
        }
      }
    }

    stage('Check') {
      steps {
        sh "docker run -v ${WORKSPACE}:/var/www/blog --rm ${env.IMAGE} jekyll doctor"
      }
    }

    stage('Deploy') {
      when {
        expression { env.BRANCH_NAME ==~ /master/ }
      }

      steps {
        sh "docker push ${env.IMAGE}"
      }
    }
  }

  post {
    success { notifySlack('success') }
    failure { notifySlack('failure') }
    aborted { notifySlack('aborted') }
  }
}
