# Nginx Testing Scenario

## Scenario Description

"An Intern was tasked with getting a proof-of-concept (POC) instance configured for our new web app.  Unfortunately, they came down sick, the task fell off everyone's radar with the holidays and then the priority for this effort suddenly was increased after an accidental leak to the press about this new web app.

You need to investigate why the website on the testing server isn't responding and figure out what is left to get the default website working so that the developers can toss the concept app on it prior to containerization."

### Web App Requirements

Because this is a PoC, the team isn't worried about using HTTPS.  To be able to pass this back to the engineer in charge, you need to ensure the following requirements are met:

- The Nginx service is started
- The Nginx service runs on reboot
- The Default website is viewable from the web

## Testing Overview

This test touches on a few areas of server configuration:

- SystemD
- Nginx
- Navigating the Linux terminal
- Using a text-based file editor
