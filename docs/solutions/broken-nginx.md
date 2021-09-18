# Testing Overview

This test touches on a few areas of server configuration:

- SystemD
- Nginx
- Navigating the Linux terminal
- Using a text-based file editor

The goal of this test is to try to get an understanding of a candidate's understanding of basic tasks related to troubleshooting a web server using Nginx.

## Part 1 - Nginx is not Starting Automatically (SystemD)

The AMI for this test comes with the systemd unit file for Nginx "disabled", so it will not start the service on boot automatically.  This part of the test is to gauge a candidate's familiarity with systemd and how it is used to manage a service.  Depending on what system init applications a candidate has used, they may side-step this and try to use the older "upstart" commands such as `service`.  This can be difficult if a candidate does not regularly work with Linux-based systems or have experience performing system administration related tasks.  If the candidate gets well and truly stuck here, you can consider moving onto the next part or ending the test.  If a candidate has worked in an environment that has very long upgrade cycles, then they may only have experience with older init systems and this could block them while the remaining steps may still be completed.

## Part 2 - Nginx Fails to Start (Listening Port for Nginx)

The part looks to get an idea of a candidate's ability to parse the Nginx configuration files used by Nginx.  The configuration file has a common mistake where the port that the server is listening on does not match the port that the reverse proxy, specified in the scenario, has been set to use (meaning Nginx is trying to use port 80 at the same time as Caddy).  This will prevent Nginx from being able to start (and can break Caddy if the system is rebooted...  So that can throw a wrench in the testing).  The solution is that the Nginx configuration needs to be modified to listen on port 8090 instead of 80.  This also presents the candidate with a scenario where they have to modify a configuration file from a terminal-so ideally they will use a text editor such as nano or vim to perform this task.  If a candidate has a strong preference for another editor and they go to install it, that should not be penalized but acknowledged as they have spend time building familiarity with at least one of the available text editors on the platform.  They could also attempt to open the file in the code instance.  In the end though, if they find themselves stuck at this point, a good direction for questions with the candidate should be how often do they work with web servers and the terminal in their day to day work.  For a reviewer, it may indicate a candidate has spent more time deveoping vs. supporting the underlying infrastructure of applications and whether that is something that is acceptable for the role/position.

## Part 3 - Nginx Cannot Find the File Specified

Once the issue with the listener port is fixed, the next issue that will arise is that Nginx cannot access the root directory as specified in the configuration.  A comparison between the Nginx configuration file and the contents of `/web/html/` will indicate the path specified in the config file does not match the name of the directory.  This can fixed in one of two ways: 1) the candidate renames the `my-app-2` directory or 2) they modify the nginx configuration to use the path that does exist.  Either way, depending on how nervous they are, they may get stuck at this part.  If they have managed to complete the steps recognized as "Part 2", there should not be any technical reason they cannot complete this step unless they miss the small detail related naming issue.

## Overall

In order to troubleshoot the underlying issue, a candidate has to have some familiarity with the Linux terminal (bash in this case) and how to navigate and reconfigure applications on Ubuntu.  Ubuntu in this case is our stand-in for Debian-based distributions of Linux.
