+++
title = "Scenario"
description = "Nginx Misconfiguration Test"
date = "2021-02-28"
aliases = ["Home", "Scenario"]
+++
"An Intern was tasked with getting a proof-of-concept (POC) instance configured for our new web app.  Unfortunately, they came down sick, the task fell off everyone's radar with the holidays and then the priority for this effort suddenly was increased after an accidental leak to the press about this new web app.

You need to investigate why the website on the testing server isn't responding and figure out what is left to get the default website working so that the developers can toss the concept app on it prior to containerization."

## Current Situation

- The reverse proxy throws a 502 error
- Nginx isn't starting on reboot
- Nginx isn't running when started

## Success Criteria

- When:
  - Nginx is running and serving the website
  - the interviewer can reach https://example.com without a 404 or 50X error
  - the interviewer can see the default nginx page
  - If the server is restarted, that the page will load successfully after a server reboot without intervention from the candidate

## Environment Caveats

In order to provide a web-based terminal for the candidate, we're using a piece of software called [Caddy](https://caddyserver.com/).  You should not touch the Caddy configuration as part of this test!

It has been configured as follows:

- Caddy is listening on TCP 80 and TCP 443
- Caddy is serving this documentation page
- Caddy is serving the [code-server](https://github.com/cdr/code-server) UI on TCP 8443
- Caddy is configured to reverse-proxy Nginx as long as Nginx is using TCP 8090

## How to Test

1. Please explain what you're doing and why as you go through the test, that way the interviewer understands your approach
2. You're on it-you're reading the documentation
3. Share your screen with the Interviewer via your screen sharing software
4. You will need to open [this site](https://example.com:8443/login) in your browser and once open, the interviewer should provide you with the password
5. Once at the Code Server console, you will need to open the terminal by pressing CTRL+` (CTRL + Backtick)
6. Using the terminal on the remote host, leverage the built-in tools within the Ubuntu distribution the VM is using to determine what is wrong with Nginx

To Open a file, you can either use an included editor such as Vim, Nano or use `code <filename>`

*OPTIONAL* Ask your interviewer if you can use Google for any questions that you have.
