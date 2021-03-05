+++
title = "Scenario"
description = "Nginx Misconfiguration Test"
date = "2021-02-28"
aliases = ["Home", "Scenario"]
+++
"An Intern was tasked with getting a proof-of-concept (POC) instance configured for our new web app.  Unfortunately, they came down sick, the task fell off everyone's radar with the holidays and then the priority for this effort suddenly was increased after an accidental leak to the press about this new web app.

You need to investigate why the website on the testing server isn't responding and figure out what is left to get the default website working so that the developers can toss the concept app on it prior to containerization."

## Success Criteria

- When:
  - the interviewer can reach https://example.com without a 404 or 50X error
  - the interviewer can see the default nginx page
  - The page will load successfully after a server reboot without intervention from the candidate

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
3. You will need to connect to https://example.com:8443/login, the interviewer should provide you with the password
4. Once at the Code Server console, you will need to open the terminal by pressing CTRL+` (CTRL + Backtick)
5. Using the terminal, leverage the built-in tools within the Ubuntu distribution to determine what is wrong with Nginx

To Open a file, you can either use an included editor such as Vim, Nano or use `code <filename>`
