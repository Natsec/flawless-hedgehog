# Flawless Hedgehog
An interactive Apache server hardening script.
It is made to help securing an out-of-the-box Apache server without having to go deep inside the configuration files.
Because it is intended to add a first layer of security rapidly, it avoid making too complex changes.

## Features
You have control on every action applied to your configuration.
The script features the most common best practices that should be applied to a web server that is exposed to the Internet, as following.

#### Information leakage:
- Hide the Apache version on error pages
- Hide the Apache version in HTTP response headers
- Disable the Etag response header

#### Exploration:
- Disable directory listing

## Version of Apache tested
The script has been tested on the following versions of Apache:
- 2.blabla

## Disclaimer
Because it is intended to add a first layer of security rapidly, the script avoid making too complex changes that could interfer with upcomming modifications of your configuration, or system settings.
As it dont go deep in the hardening process, the script cant be trusted to make your server "flawless", although it should be enough for a first pass in the process of making your web server more secure.
