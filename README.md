# CS-Demo

### Intro

This is a multi-module project to install Proxy Clusters with a bridged worker into a private AWS network.

At this time the project is only for AWS.

Resources can be onboarded based on preference or need by filling out the [config.tf](./config.tf) file.

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

### Items to populate into the config.tf file:

- [ ] project name
- [ ] AWS Region
- [ ] Tags
- [ ] Email address of Users to attach roles
- [ ] Resources set to true or false

### Configuring the EKS cluster for Discovery and Privilege Escalation

There is a yaml file that has all of the roles and role bindings needed to get things to work called sdm-rbac.yaml

You can run through the steps on your own of connecting to the cluster, or you can run the shell script that is also provided setup-sdm-rbac.sh

If the shell script doesn't run you may have to use a chmod command

`chmod +x setup-sdm-rbac.sh`

Then you can run the script normally and it will update the cluster

`./setup-sdm-rbac.sh`
