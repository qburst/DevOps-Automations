# Jenkins Shared Library

This directory contains reusable Groovy scripts for Jenkins pipelines. These scripts can be used to perform common tasks such as checking out Git repositories, building code, building Docker images and pushing Docker images.

## Script
`BuildDeployDocker.groovy`
This script performs the following tasks:

Checks out a Git repository.
Builds the code using a specified build command.
Builds a Docker image using a specified Dockerfile, image name, and image tag.
Pushes the Docker image to a specified Docker repositor

### Parameters
`repoUrl`: The URL of the Git repository.
`branch`: The branch to checkout (default is 'main').
`buildCommand`: The command to build the code (default is 'mvn clean install').
`dockerfile`: The path to the Dockerfile (default is 'Dockerfile').
`imageName`: The name of the Docker image.
`imageTag`: The tag for the Docker image (default is 'latest').
`dockerRepoUrl`: The URL of the Docker repository.
`dockerCredentialsId`: The ID of the Docker credentials in Jenkins.


##### Example Jenkins Pipeline
Here is an example of how to use these scripts in a Jenkins pipeline where I used a public repo which contains a Spring Boot based Java web application:

```groovy
@Library('my-shared-library') _

def config = [
    repoUrl: 'https://github.com/Rithin-QB/SpringBoot-Web-App.git',
    branch: 'main',
    buildCommand: 'mvn clean install',
    dockerfile: 'Dockerfile',
    imageName: 'sample',
    imageTag: 'latest',
    dockerRepoUrl: 'rithin730/sample',
    dockerCredentialsId: 'Dockerhub_cred'
]

BuildDeployDocker(config)
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


