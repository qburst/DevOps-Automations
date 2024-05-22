def call(String imageName, String imageTag, String dockerRepoUrl) {
    sh "docker tag ${imageName}:${imageTag} ${dockerRepoUrl}:${imageTag}"
    sh "docker push ${dockerRepoUrl}:${imageTag}"
}