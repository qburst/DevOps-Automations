# Compute Engine Module
This module will create a simple compute engine. As a part of the module it will generate the following

- 1 Compute Engine with specified image .
- 2 Service account created for compute engine


## Inputs
**Important**
    All inputs :heavy_check_mark: must be configured.
    Any with :x: can be ignored, but can be configurd if you want.

| Name        | Description | Required | Type | Default |
| ----------- | ----------- | -------- | ---- | ------- |
| name | The name of the compute engine being created | :heavy_check_mark: | string | "" |
| machine_type | The machine type required | :heavy_check_mark:| string | "e2-medium" |
| zone | The zone where the engine will be created | :heavy_check_mark: | string | If it is not provided, the provider zone is used.|
| image | Image to be used for the engine | :heavy_check_mark: | string | "ubuntu-os-cloud/ubuntu-2004-lts" |
| network | VPC where compute engine needs to be created | :heavy_check_mark:| string | "" |



