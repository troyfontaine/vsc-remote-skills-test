# vsc-remote-skills-test

## Overview

A terraform configuration that deploys an instance to AWS which runs Visual Studio Code and provides a means of performing remote testing with potential hiring candidates.

Intended as both a learning tool and a testing tool, this repository can be extended by your in-house engineers/developers to add your own set of customized testing to provide different challenges to potential hires.

This is intended to provide hands-on testing of real-world scenarios without a ton of code modification, more aimed at familiarity with how services are configured and operate on a standard Linux distribution.

## Software Dependencies

- [AWS Vault][aws-vault](Optional)
- [Lefthook][lefthook]
- [tfenv][tfenv]
- [Terraform][terraform]
- [Packer][packer]

## Getting Started

The included AMIs built with this default repository consist of:

- Broken Nginx
- Broken Apache
- Broken Python Web App
- Broken Ruby Web App

### Broken Nginx

This scenario is intended to provide a candidate the opportunity to demonstrate their familiarity with Systemd, Nginx and a basic web application.  They must determine why the web application is not operational, drilling down into why a service works.  Once a candidate has been able to resolve the first few issues, they must then determine why the web application isn't appearing externally.

### Broken Apache

This scenario is intended to provide a candidate with the opportunity to demonstrate their familiarity with Systemd, Apache and a basic web application.  They must determine why the web application is not operational, drilling down into why a service works.  Once a candidate has been able to resolve the first few issues, they must then determine why the web application isn't appearing externally.

### Broken Python Web App

This scenario is intended to provide a candidate with the opportunity to demonstrate their familiarity with Python tooling.

### Broken Ruby Web App

This scenario is intended to provide a candidate with the opportunity to demonstrate their familiarity with Ruby tooling.

[aws-vault]: https://github.com/99designs/aws-vault
[lefthook]: https://github.com/Arkweid/lefthook
[tfenv]: https://github.com/tfutils/tfenv
[terraform]: https://www.terraform.io/
[packer]: https://www.packer.io/
