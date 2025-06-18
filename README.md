# CS-Demo

### Intro

This is a multi-module project to install Proxy Clusters with a bridged worker into a private AWS network.

At this time the project is only for AWS.

Resources can be onboarded based on preference or need by commenting or uncommenting out the resource in the cs_demo_config.tf file.

### Infrastructure

- There is a single VPC with 2 public subnets and 2 private subnets.
- 1 NLB is configured to direct traffic from incoming 443 to the Proxy Bridge. This also handles communication between the Proxy Worker and Bridge.
- 1 ECS cluster is created with 2 services and 2 tasks, one for the Proxy Bridge, and one for the Proxy Worker

- Secret's manager is used to store the SDM Secret Key for the Proxy Cluster. This can be refactored in the future to also store other secrets in the future.

### StrongDM

- An admin role with the project name prefix is added to each of the provided email addresses.
- A dynamic access rule is also created with a "workflow" tag that will be associated with access workflows.
- An auto approval workflow and access workflow are created for any of the resources onboarded with this module and the admin role associate with it.
- Every user added to the config file will be able to request access to any resource onboarded with this module.

### Resources available

- SSH and simple web server
- RDP Windows server
- RDS MySQL database
- EKS Cluster (still being built)

### Strong DM

Each of these resources will be onboarded into StrongDM. Users to attach roles to, and project name should be filled into the cs_demo_config.tf file.

### Items to populate into the cs_demo_config.tf file:

- [ ] project name
- [ ] AWS Region
- [ ] Tags
- [ ] Email address of Users to attach roles
