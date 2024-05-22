# Jenkins Shared Library

This directory contains reusable Groovy scripts for Jenkins pipelines. These scripts can be used to perform common tasks such as checking out Git repositories, building code, building Docker images and pushing Docker images.

## Scripts

### 1. `checkoutGitRepo.groovy`
This script checks out a Git repository from a specified URL and branch.

#### Usage
```groovy
checkoutGitRepo(String repoUrl, String branch = 'main')
```
#### Parameters
`repoUrl`: The URL of the Git repository.
`branch`: The branch to checkout (default is main).

Example

```groovy
checkoutGitRepo('https://github.com/username/repo.git', 'main')
```

### 2. `buildCode.groovy`
This script is used to build code using a specified build command.

#### Usage
```groovy
buildCode(String buildCommand)
```
#### Parameters
`buildCommand`: The command to build the code (e.g., mvn clean install, npm install).

Example

```groovy
buildCode('mvn clean install')
```
### 3. `buildDockerImage.groovy`
This script builds a Docker image using a specified Dockerfile path, image name, and image tag.

#### Usage
```groovy
buildDockerImage(String dockerfilePath, String imageName, String imageTag)
```
#### Parameters
`dockerfilePath`: The path to the Dockerfile.
`imageName`: The name of the Docker image.
`imageTag`: The tag for the Docker image.

Example

```groovy
buildDockerImage('Dockerfile', 'sample', 'latest')
```

### 4. `pushDockerImage.groovy`
This script tags and pushes a Docker image to a specified Docker repository URL.

#### Usage
```groovy
pushDockerImage(String imageName, String imageTag, String dockerRepoUrl)
```
#### Parameters
`imageName`: The name of the Docker image.
`imageTag`: The tag of the Docker image.
`dockerRepoUrl`: The URL of the Docker repository.

Example

```groovy
pushDockerImage('sample', 'latest', 'username/repo')
```

##### Example Jenkins Pipeline
Here is an example of how to use these scripts in a Jenkins pipeline where I used a public repo which contains a Spring Boot based Java web application:

```groovy
@Library('my-shared-library') _

pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('Dockerhub_cred')
    }

    stages {
        stage('Checkout') {
            steps {
                checkoutGitRepo('https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git', 'main')
            }
        }
        stage('Build') {
            steps {
                dir('java-maven-sonar-argocd-helm-k8s/spring-boot-app') {
                    buildCode('mvn clean install')
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('java-maven-sonar-argocd-helm-k8s/spring-boot-app') {
                    buildDockerImage('Dockerfile', 'sample', 'latest')
                }
            }
        }
  
        stage('Push Docker Image') {
            steps {
                sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                   pushDockerImage('sample', 'latest', 'rithin730/sample')
            }
        }
    }
}
```

### Common Issues
#### Docker Permission Denied
If you encounter a permission denied error while trying to connect to the Docker daemon, ensure that the Jenkins user has the appropriate permissions. You may need to add the Jenkins user to the docker group:

```sh
sudo usermod -aG docker jenkins
```

#### Docker Hub Authentication
If you receive a denied: requested access to the resource is denied error when pushing a Docker image, ensure that your Jenkins instance is properly authenticated with Docker Hub. This can be done by configuring Docker credentials in Jenkins:

Go to Jenkins Dashboard.
Navigate to Credentials > System > Global credentials.
Add new credentials with your Docker Hub username and password.
Use these credentials in your pipeline to login to Docker Hub before pushing the image:


