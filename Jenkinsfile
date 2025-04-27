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
        sh 'ls -l target/'
        stash includes: 'target/*.jar', name: 'built-jar'
      }
    }
    stage('Docker Build') {
      agent any
      steps {
        unstash 'built-jar'
        sh 'ls -l target/'
        // Asegurarse de que el directorio target/ existe
        sh 'mkdir -p target'
        sh 'mv *.jar target/ || true' // Mover cualquier JAR al directorio target/ si es necesario
        sh 'ls -l target/'
        sh 'docker build -t shanem/spring-petclinic:latest .'
      }
    }
  }
}