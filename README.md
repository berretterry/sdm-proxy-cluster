# CS-Demo

### Intro

This is a multi-module project to install Proxy Clusters with a bridged worker into a private AWS network.

At this time the project is only for AWS.

Resources can be onboarded based on preference or need by commenting or uncommenting out the resource in the cs_demo_config.tf file.

### Resources available

- SSH and simple web server
- RDP Windows server
- RDS MySQL database
- EKS Cluster (still being built)

### Strong DM

Each of these resources will be onboarded into StrongDM. Users to attach roles to, and project name should be filled into the cs_demo_config.tf file.

### Items to populate into the cs_demo_config.tf file:

- [] project name
- [] AWS Region
- [] Tags
- [] Email address of Users to attach roles
