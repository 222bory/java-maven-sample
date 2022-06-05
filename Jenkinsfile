
def applicationName = "java-maven-sample"

node {
    
  stage 'Checkout'
  checkout 'https://github.com/222bory/java-maven-sample.git'

  stage 'Build and Test'
  // Build using a plain docker container, not our local Dockerfile
  def mvnContainer = docker.image('maven:3-jdk-8-alpine')
  mvnContainer.inside('-v /m2repo:/m2repo') {
      // Set up a shared Maven repo so we don't need to download all dependencies on every build.
      writeFile file: 'settings.xml',
         text: '<settings><localRepository>/m2repo</localRepository></settings>'
      
      // Build with maven settings.xml file that specs the local Maven repo.
      sh 'mvn -B -s settings.xml package'
   }
        
  stage 'Package Docker image'
  // Build final releasable image using our Dockerfile and the docker.build cmd
  // This container only contains the packaged jar, not the source or interim build steps
  def img = docker.build('java-maven-sample:latest', '.')
    
  stage name: 'Push Image', concurrency: 1
  // All the tests passed. We can now retag and push the 'latest' image
  docker.withRegistry('https://nexus.doyouevenco.de', 'nexus-admin') {
     img.push('latest')
  }
    
   //Now we deploy
  stage 'Deploy'

}

