+++
title = "Scenario"
description = "Kubernetes Configuration Test"
date = "2021-02-28"
aliases = ["Home", "Scenario"]
+++
"Welcome to the party!  Management has requested that we look at using Kubernetes, so Joe tossed something called 'K-three-ess' on a VM.  Can you launch a website on it?"

## Current Situation

- Kubernetes is available via a tool called [k3s](https://k3s.io/)
- K3s' API Endpoint is public facing
- Kubeconfig is located at `/etc/rancher/k3s/k3s.yaml`

## Success Criteria

- When:
  - Using Nodeport, expose the site on 8090 (no need for a load balancer)
  - the interviewer can reach https://example.com without a 404 or 50X error
  - the interviewer can see the default nginx page
  - The page will load successfully after a server reboot without intervention from the candidate

## Bonus Points

- When:
  - Launch a pair of nginx containers that match so we have high availability

## Environment Caveats

In order to provide a web-based terminal for the candidate, we're using a piece of software called [Caddy](https://caddyserver.com/).  You should not touch the Caddy configuration as part of this test!

It has been configured as follows:

- Caddy is listening on TCP 80 and TCP 443
- Caddy is serving this documentation page
- Caddy is serving the [code-server](https://github.com/cdr/code-server) UI on TCP 8443
- Caddy is configured to reverse-proxy Nginx as long as Nginx is using TCP 8090

## How to Test

1. You're on it-you're reading the documentation
2. Share your screen with the Interviewer via your screen sharing software
3. You will need to open [this site](https://example.com:8443/login) in your browser and once open, the interviewer should provide you with the password
4. Once at the Code Server console, you will need to open the terminal by pressing CTRL+` (CTRL + Backtick)
5. Using the terminal, leverage the built-in tools within the Ubuntu distribution the VM is using to determine what is wrong with Nginx

To Open a file, you can either use an included editor such as Vim, Nano or use `code <filename>`

*OPTIONAL* Ask your interviewer if you can use Google for any questions that you have.
