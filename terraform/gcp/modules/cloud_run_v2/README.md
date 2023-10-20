# Cloud Run v2 Module
This module will create a cloud run service for a public facing web applications or APIs using the provided docker 
image.As a part of the module it will generate the following:

- 1 cloud run sevice 
- An IAM policy to make the service public if required

    NOTE:

    - For cloud run service to be made public you need roles/iam.securityAdmin

## Inputs
**Important**
    All inputs :heavy_check_mark: must be configured.
    Any with :x: can be ignored, but can be configurd if you want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| service_name | The name of the service being created | :x: | string |"default-service" |
| img_url | URL of the Container image | :heavy_check_mark: | string | |
| vpc_connector | VPC Access connector name | :x: | string | |
| location | The region where the service will be created | :heavy_check_mark: | string | |
| make_public | A boolean flag to make the function public | :x: | bool | false |
| min_instance_count | Minimum number of serving instances that this resource should have. | :x: | number | 0 |
| max_instance_count | Maximum number of serving instances that this resource should have. | :x: | number | 1 |
| container_port | Port number the container listens on. This must be a valid TCP port number | :heavy_check_mark: | string | |
| container_env | A list of objects containing the environment vlaues for the container | :x: | list(object({})) | [] |

**container_env inputs**
    The container_env list contains objects, where each object represents an environment variable. Each object has the following inputs (please see examples folder for additional references):

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| key | The name of the environment value | :heavy_check_mark: | string | |
| value | The value of the environment variable | :heavy_check_mark: | string | |