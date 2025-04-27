#!groovy

pipeline {
  agent none
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.9.6'
        }
      }
      steps {
        sh 'mvn clean install'
        stash includes: 'target/*.jar', name: 'built-jar'
      }
    }
    stage('Docker Build') {
      agent any
      steps {
        unstash 'built-jar'
        sh 'docker build -t shanem/spring-petclinic:latest .'
      }
    }
  }
}