# Cloud Function v2 Module
This module will create a simple cloud function with an http trigger via Terraform. As a part of the module it will generate the following

- 1 cloud function v2.
- 1 cloud run sevice (cloud function v2 is powered by cloud run)
- A storage bucket in the specified location if a source bucket is not given
- A zip object inside the bucket, containing the source code 
- An IAM policy to make the function public if required

    NOTE:
    - There should be a "source" folder containing the source code for the cloud function in the same directory
    - For cloud function to be made public you need roles/iam.securityAdmin

## Inputs
**Important**
    All inputs :heavy_check_mark: must be configured.
    Any with :x: can be ignored, but can be configurd if you want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| function_name | The name of the function being created | :heavy_check_mark: | string | |
| description | A breif description of the function | :x: | string | |
| location | The region where the subnet will be created | :heavy_check_mark: | string | |
| source_bucket | A bucket to store the source code | :x: | string | |
| make_public | A boolean flag to make the function public | :x: | bool | false |
| config | An object containing the various configurations for the function | :heavy_check_mark: | object() | |

**config inputs**
    config is an object containing the various configurations for the function . It object has the following inputs (please see examples folder for additional references):

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| runtime | The runtime in which to run the function | :heavy_check_mark: | string | |
| entry_point | Name of the function that will be executed | :heavy_check_mark: | string | |
| max_instance_count | The limit on the maximum number of function instances that may coexist at a given time | :x: | number | 1 |
| available_memory | The amount of memory available for a function. | :x: | string | "256M" |
| timeout_seconds | The function execution timeout | :x: | number | 60 |

