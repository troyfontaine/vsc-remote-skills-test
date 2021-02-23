# Building Images

## Overview

The configuration stored in this directory is intended to build testing Amazon Machine Images for the use of creating test scenarios to gauge the familiary of a candidate with certain applications/configuration and problem scenarios.

### How To Build

To build your testing images, you can use Lefthook:  

```bash
lefthook run packer-build
```

### Modifying the base AMI

To find the owner ID of one of the free AMI images, you will first need the ID of the AMI.  From there, you can use the following command (and simply replace the image-ids value for that of the AMI you want to base off of instead) to determine the owner ID that is required for the AMI search.  

    aws ec2 describe-images --image-ids "ami-0928f4202481dfdf6" | jq -r '.Images[] | "\(.OwnerId)\t\(.Name)"'
