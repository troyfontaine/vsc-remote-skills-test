# vsc-remote-skills-test

## Overview

A terraform configuration that deploys an instance to AWS which runs [Code Server][code-server] and provides a means of performing remote testing with potential hiring candidates.

Intended as both a learning tool and a testing tool, this repository can be extended by your in-house engineers/developers to add your own set of customized testing AMI via Packer to provide different challenges to potential hires.

This was written to provide a hands-on testing of real-world scenarios without a ton of code modification and the scenarios included are more aimed at testing familiarity with how services are configured and operate on a standard Linux distribution in a server environment.

### DevOps Disclaimer

This is not advocacy for treating servers like pets, but a means of gauging how familiar an individual candidate is with typical server configuration concepts.

## Software Dependencies

- [AWS Vault][aws-vault] (Optional)
- [Lefthook][lefthook]
- [tfenv][tfenv]
- [Terraform][terraform]
- [Packer][packer]

## Other Dependencies

You will need:

- An AWS account
  - Full access to EC2
  - Full access to Route 53
- A domain name that you own
- A hosted zone in Route 53 which:
  - Uses your domain
  - Is public
  - Is in the same AWS account as the EC2 instance you're launching in
- A conferencing program that allows you to share your screen (for the Candidate to share their screen while working on the problems)
- Access to the public internet (to use [Ipify][ipify])

## Getting Started

The first step in getting the testing environment going is to specify your domain that you will use for the instance. To do this, create a file in the root of this directory called "domain.hcl" and place within it the key = value of `domain = "mydomain.com"`.  There is already a symlink to `domain.hcl` called `domain.tfvars`.  If you wish to configure a sub-domain, you can do so by adding a key = value of `sub_domain = "test."`.

Once that is done, you need to build your base AMI images for the tests.

```bash
lefthook run packer-build
```

Unfortunately, due to the necessity to access user input, terraform doesn't appear to work when executed via Lefthook.

```bash
terraform init
terraform plan --var-file="domain.tfvars"
```

```bash
terraform apply --var-file="domain.tfvars"
```

## Cleaning up

To clean up the Terraform build, simply run:  

```bash
terraform destroy --var-file="domain.tfvars"
```

## How To Connect

We're using a Visual Studio Code server application to perform the testing, so to start connect to https://DOMAIN-IN-domain.hcl-FILE:8443/login.  The password is located in the outputs from the Terraform execution as `code_server_password`, in addition to the URL.  Otherwise, the password is available in a non-encrypted format (for ease of use-do not leave the instance running between test uses!) as a tag (`code-server-password`) on the instance itself.

## How to Perform Testing

The testing performed using these tools is intended to be used in conjunction with a meeting application such as Microsoft Teams or Slack, where a user can share their screen.

Testing technical staff can monitor the instance by connecting via SSH to the instance and to provide additional support to the candidate.

## Known Issues

Due to the throwaway nature of this task and repository, the terraform state is handled locally, in addition, the private key for the instance and the password for the code-server are treated insecurely.

[aws-vault]: https://github.com/99designs/aws-vault
[code-server]: https://github.com/cdr/code-server
[lefthook]: https://github.com/Arkweid/lefthook
[tfenv]: https://github.com/tfutils/tfenv
[terraform]: https://www.terraform.io/
[packer]: https://www.packer.io/
[ipify]: https://ipify.org
