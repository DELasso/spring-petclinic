#!groovy

pipeline {
  agent none
  stages {
    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.9.6-eclipse-temurin-17'
        }
      }
      steps {
        sh 'mvn clean install'
        sh 'ls -l target/'
        stash includes: 'target/*.jar', name: 'built-jar'
      }
    }
    stage('Docker Build') {
      agent any
      steps {
        unstash 'built-jar'
        sh 'ls -l target/'
        sh 'mkdir -p target'
        sh 'mv *.jar target/ || true'
        sh 'ls -l target/'
        sh 'docker build -t lassovb/spring-petclinic:latest .'
      }
    }
    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh 'echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
          sh 'docker push lassovb/spring-petclinic:latest'
        }
      }
    }
  }
}