# Javascript Service

This is a single html page that uses Javasript to call other services running on PCF. CORS will need to be abled on the running services to such a call to successfully return data.

# Deployment

Simply do a 'cf push' in the working directory. The manifest.yml file contains all the details required to push the application.
