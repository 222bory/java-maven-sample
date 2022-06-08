#!/usr/bin/env groovy
def appName = "java-maven-sample"
def project="okd-test"
def mavenHome

node {
    stage('Checkout') { 
        git credentialsId: 'bory222', url: 'https://github.com/222bory/java-maven-sample.git'
    }
    
    stage('Source Build and Test') {
        mavenHome = tool 'maven'
        sh "'${mavenHome}/bin/mvn' -Dmaven.test.skip=true clean install"
    }
    
    stage('Deploy Template') {
        def status = sh(returnStdout: true, script: "oc process -f .openshift/template.yaml -p NAME=${appName} NAMESPACE=${project} | oc apply -f - ")
        echo "${status}"
    }
    
    stage('Deploy Pod') {
        openshift.withCluster() {
            openshift.withProject("${project}") {
                def dc = openshift.selector('dc',"${appName}")
                dc.rollout().status()
            }
        }
    }
}
