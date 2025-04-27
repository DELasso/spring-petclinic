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
        sh 'docker build -t shanem/spring-petclinic:latest .'
      }
    }
    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'lassovb', passwordVariable: 'Davidlasso7@')]) {
          sh 'docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS'
          sh 'docker push shanem/spring-petclinic:latest'
        }
      }
    }
  }
}