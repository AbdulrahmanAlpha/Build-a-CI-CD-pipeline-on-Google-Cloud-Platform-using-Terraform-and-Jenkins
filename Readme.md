# CI/CD Pipeline Documentation

## Overview

This document provides a detailed overview of the CI/CD pipeline built using Terraform and Jenkins on Google Cloud Platform. The pipeline is designed to build and deploy a Java application to a Kubernetes cluster. The pipeline stages are defined in a Jenkinsfile and can be customized as needed.

## Architecture

The CI/CD pipeline consists of the following components:

- **Jenkins instance**: a virtual machine running Jenkins, which is used to execute the pipeline stages.
- **Build environment**: a virtual machine used to build the application.
- **Deployment environment**: a virtual machine used to deploy the application.
- **Kubernetes cluster**: a cluster of virtual machines running Kubernetes, which is used to host the application.

The Jenkins instance is created using Terraform and is configured to run the pipeline stages defined in the Jenkinsfile. The build environment and deployment environment are also created using Terraform and are configured with the necessary software and dependencies to build and deploy the application. The Kubernetes cluster is created separately and is used to host the application.

The pipeline stages are defined in a Jenkinsfile and can be customized as needed. The stages include:

1. **Checkout**: checks out the source code from the Git repository.
2. **Build**: compiles the source code and packages it into a JAR file.
3. **Deploy to Staging**: deploys the application to the staging environment in a Kubernetes cluster.
4. **Integration Tests**: runs automated integration tests against the staging environment.
5. **Deploy to Production**: deploys the application to the production environment in a Kubernetes cluster.

## Getting Started

To get started with the CI/CD pipeline, follow these steps:

1. Clone the Git repository that contains the application source code.
2. Install Terraform on your local machine.
3. Configure your Google Cloud Platform credentials and create a project.
4. Customize the Terraform variables in the `terraform.tfvars` file to match your environment. The following variables must be set:
   - `project_id`: the ID of the Google Cloud Platform project.
   - `region`: the region where the instances will be created.
   - `zone`: the zone where the instances will be created.
   - `instance_type`: the type of the virtual machine instances.
   - `jenkins_image`: the name of the image used to create the Jenkins instance.
   - `build_image`: the name of the image used to create the build environment.
   - `deploy_image`: the name of the image used to create the deployment environment.
   - `ssh_source_ip`: the IP address that is allowed to SSH into the instances.
   - `jenkins_folder`: the name of the folder where the Jenkins job will be created.
5. Run `terraform init`, `terraform plan`, and `terraform apply` to create the infrastructure. This will create the Jenkins instance, the build environment, and the deployment environment.
6. Access the Jenkins instance using its external IP address. You can find the external IP address in the output of the `terraform apply` command.
7. Create a new Jenkins job and paste the contents of the `Jenkinsfile` into the job configuration.
8. Customize the pipeline stages as needed. You may need to modify the environment variables, commands, or Kubernetes configuration files depending on your specific application.
9. Run the pipeline to build and deploy the application.

## Troubleshooting

If you encounter any issues with the CI/CD pipeline, try the following troubleshooting steps:

- Check the Jenkins logs for errors or warnings. You can access the Jenkins logs by SSHing into the Jenkins instance and running the command `sudo cat /var/log/jenkins/jenkins.log`.
- Check the build and deployment logs for errors or warnings. You can access the logs by SSHing into the build or deployment environment and running the command `sudo cat /var/log/syslog`.
- Check the Kubernetes logs for errors or warnings. You can access the logs by running the command `kubectl logs <pod-name>`.
- Verify that the necessary environment variables are set correctly. You can set environment variables in the Jenkinsfile using the `environment` section.
- Verify that the necessary dependencies are installed. You can install dependencies in the build or deployment environment using the `apt-get` or `yum` commands.
- Verify that the necessary permissions are set. You may need to grant permissions to the Jenkins user or the Kubernetes service account depending on your specific application.

## Conclusion

The CI/CD pipeline built using Terraform and Jenkins on Google Cloud Platform provides an automated and scalable solution for building and deploying Java applications to a Kubernetes cluster. The pipeline can be customized to match your specific needs and can be used to accelerate your software development lifecycle. By following the steps in this document, you can quickly set up and run your own CI/CD pipeline on Google Cloud Platform.