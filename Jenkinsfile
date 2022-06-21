#!/usr/bin/env groovy
def appName = "java-maven-sample"
def project="okd-test"
def mavenHome

node {
    stage('Checkout') { 
        git credentialsId: 'bory222', url: 'https://github.com/222bory/java-maven-sample.git'
    }
    
    stage('Source Build JAR') {
        mavenHome = tool 'maven'
        sh "'${mavenHome}/bin/mvn' -Dmaven.test.skip=true clean package "
        stash name:"jar", includes:"target/helloworld-1.0-SNAPSHOT.jar"
    }
    
    stage('Deploy Template and Build Image') {
        def status = sh(returnStdout: true, script: "oc process -f .openshift/template.yaml -p NAME=${appName} NAMESPACE=${project} | oc apply -f - ")
        echo "${status}"
        unstash name:"jar"
        def status2 = sh(returnStdout: true, script: "oc start-build ${appName} --from-file=target/helloworld-1.0-SNAPSHOT.jar -n ${project}")
        echo "${status2}"
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
