def call(String dockerfilePath, String imageName, String imageTag) {
    sh "docker build -t ${imageName}:${imageTag} -f ${dockerfilePath} ."
}