+++
title = "Scenario"
description = "Apache Misconfiguration Test"
date = "2021-03-04"
aliases = ["Home", "Scenario"]
+++
"So Joe who used to be in Help Desk got promoted and was told to set up this server for Bob in accounting (don't ask).  Anyways, Joe is still pretty green and decided he wanted to use Apache when we've standardized on Nginx.  So he was playing with this server and now the website doesn't load on it-and Bob is getting a bit upset...

You need to investigate why the apache default site isn't loading.  It could be because Nginx is installed...  But who knows?"

## Success Criteria

- When:
  - Apache is running and serving the website
  - the interviewer can reach https://example.com without a 404 or 50X error
  - the interviewer can see the default page
  - The page will load successfully after a server reboot without intervention from the candidate

## Environment Caveats

In order to provide a web-based terminal for the candidate, we're using a piece of software called [Caddy](https://caddyserver.com/).  You should not touch the Caddy configuration as part of this test!

It has been configured as follows:

- Caddy is listening on TCP 80 and TCP 443
- Caddy is serving this documentation page
- Caddy is serving the [code-server](https://github.com/cdr/code-server) UI on TCP 8443
- Caddy is configured to reverse-proxy Nginx as long as whatever it is proxying to is using TCP 8090

## How to Test

1. You're on it-you're reading the documentation
2. Share your screen with the Interviewer via your screen sharing software
3. You will need to open [this site](https://example.com:8443/login) in your browser and once open, the interviewer should provide you with the password
4. Once at the Code Server console, you will need to open the terminal by pressing CTRL+` (CTRL + Backtick)
5. Using the terminal, leverage the built-in tools within the Ubuntu distribution the VM is using to determine what is wrong with Nginx

To Open a file, you can either use an included editor such as Vim, Nano or use `code <filename>`

*OPTIONAL* Ask your interviewer if you can use Google for any questions that you have.
