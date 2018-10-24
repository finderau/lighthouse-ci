#!groovy

@Library('jenkins-shared-libraries@master') _

properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '10']]]);

node {
    stage('Pre Cleanup') {
        deleteDir()
    }

    stage('Checkout Repositories') {
        checkout scm
        dir('ci-scripts-global') { // Checkout ci-scripts into a sub-folder for docker build steps
            git credentialsId: '44203af6-1a6e-48b8-b938-6a5abf08c142', url: 'https://github.com/finderau/ci-scripts', branch: 'master'
        }
    }

    stage('ECR Login') {
        sh 'ci-scripts-global/ecr-login.sh'
    }

    stage('Install') {
        sh 'ci-scripts/install.sh'
    }

    stage('Docker Build') {
        sh 'ci-scripts/build.sh'
    }

    stage('Docker Push') {
        sh 'ci-scripts-global/push.sh'
    }

    stage('Archive Artifacts') {
        sh 'tar -czf archive.tar.gz *'
        archiveArtifacts artifacts: 'archive.tar.gz', onlyIfSuccessful: true
    }

    stage('Build Downstream') {
        buildDownstream name: "plugins", branch: "${env.BRANCH_NAME}"
    }

    stage('Post Cleanup') {
        sh 'ci-scripts-global/clean.sh'
        deleteDir()
    }
}
