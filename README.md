# DevOps Days Vancouver

Pivotal Cloud Foundry (PCF) is a platform that runs on top of an IAAS layer that simplifies developer and operator workflows enabling a true DevOps culture to emerge.

## Architecture

The following is the application that will be deployed. It is a polyglot architecture utilizing .NET, Spring (Java) and Javascript. All applications are running in PCF.

![alt text](architecture.png "Architecture")

## Environment and Prerequisites

This needs to run on an installation of Pivotal Cloud Foundry with Diego Windows installed:

https://docs.pivotal.io/pivotalcf/opsguide/deploying-diego.html

The CF CLI also needs to be installed on the development machine to push the applications from:

https://docs.cloudfoundry.org/cf-cli/install-go-cli.html

## Authentication

Run the following to authenticate (NOTE: for this demo a on-premise version of PCF is used that requires Okta token authentication).

```shell
➜  devops-days git:(master) ✗ ./demo_polyglot_1_authenticate.sh 
 _______    ______   ________        _______                                    
/       \  /      \ /        |      /       \                                   
$$$$$$$  |/$$$$$$  |$$$$$$$$/       $$$$$$$  |  ______   _____  ____    ______  
$$ |__$$ |$$ |  $$/ $$ |__          $$ |  $$ | /      \ /     \/    \  /      \ 
$$    $$/ $$ |      $$    |         $$ |  $$ |/$$$$$$  |$$$$$$ $$$$  |/$$$$$$  |
$$$$$$$/  $$ |   __ $$$$$/          $$ |  $$ |$$    $$ |$$ | $$ | $$ |$$ |  $$ |
$$ |      $$ \__/  |$$ |            $$ |__$$ |$$$$$$$$/ $$ | $$ | $$ |$$ \__$$ |
$$ |      $$    $$/ $$ |            $$    $$/ $$       |$$ | $$ | $$ |$$    $$/ 
$$/        $$$$$$/  $$/             $$$$$$$/   $$$$$$$/ $$/  $$/  $$/  $$$$$$/  
                                                                                
 
Running: https://api.run.pez.pivotal.io
This is running in an onpremise vSphere Cluster
 
Setting api endpoint to https://api.run.pez.pivotal.io...
OK

                   
API endpoint:   https://api.run.pez.pivotal.io (API version: 2.43.0)   
User:           lshannon@pivotal.io   
Org:            pivot-lshannon   
Space:          devops-days   
Running: cf login -sso
API endpoint: https://api.run.pez.pivotal.io

One Time Code ( Get one at https://login.run.pez.pivotal.io/passcode )> 

```

## Deployment

Run the following to deploy the stack.

```shell


```

## Blue Green Deployment
Run the following to update the Javascript version with a newer version of the application with 0 downtime.
NOTE: Using Easy Auto Refresh for Chrome the App Console UI and the UI of the application can be refreshed every second to see the actions of the Blue Green deployment in real time:

https://chrome.google.com/webstore/detail/easy-auto-refresh/aabcgdmkeabbnleenpncegpcngjpnjkc?hl=en

```shell

devops-days git:(master) ✗ ./demo_blue_green.sh                                                  
Pushing the 'New' Service
cf push javascript-service-new -p Javascript-UI-Service-Updated -n javascript-service-new -b staticfile_buildpack -m 256M
Creating app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Using route javascript-service-new.cfapps.pez.pivotal.io
Binding javascript-service-new.cfapps.pez.pivotal.io to javascript-service-new...
OK

Uploading javascript-service-new...
Uploading app files from: Javascript-UI-Service-Updated
Uploading 3.6K, 3 files
Done uploading               
OK

Starting app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
Downloading staticfile_buildpack...
Downloaded staticfile_buildpack
Creating container
Successfully created container
Downloading app package...
Downloaded app package (1.6K)
Staging...
-------> Buildpack version 1.2.2
Downloaded [file:///tmp/buildpacks/2420b40fe7ea294fdddd214aff4c2b00/dependencies/https___s3.amazonaws.com_pivotal-buildpacks_nginx_cflinuxfs2_nginx-1.8.0-linux-x64.tgz]
grep: Staticfile: No such file or directory
-----> Using root folder
-----> Copying project files into public/
-----> Setting up nginx
grep: Staticfile: No such file or directory
Exit status 0
Staging complete
Uploading droplet, build artifacts cache...
Uploading droplet...
Uploading build artifacts cache...
Uploaded build artifacts cache (131B)
Uploaded droplet (2.4M)
Uploading complete

1 of 1 instances running

App started


OK

App javascript-service-new was started using this command `sh boot.sh`

Showing health and status for app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

requested state: started
instances: 1/1
usage: 256M x 1 instances
urls: javascript-service-new.cfapps.pez.pivotal.io
last uploaded: Sat Apr 16 19:35:40 UTC 2016
stack: cflinuxfs2
buildpack: staticfile_buildpack

     state     since                    cpu    memory      disk      details   
#0   running   2016-04-16 12:36:15 PM   0.0%   0 of 256M   0 of 1G      

Testing the new service

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple UI Example</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
    <script src="https://code.jquery.com/jquery-2.2.2.min.js" integrity="sha256-36cp2Co+/62rEAAYHLmRCPIych47CvdM+uTBJwSzWjI=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


</head>

<body>


    <div class=".container-fluid">

        <div class="starter-template">
            <h1>Simple UI</h1>
            <h3>This Shows Combining JSON from a .NET service and Java service - running on PCF</h3>
            <h3>Hi Jim!</h3>
        </div>

        <h4>.NET Json</h4>
        <div id="order"></div>

        <h4>Spring Json</h4>
        <div id="customer"></div>

        <script type="text/javascript">
            $(document).ready(function () {
                var output = "";
                $.getJSON('https://order-service.cfapps.pez.pivotal.io/api/Order', function (data) {

                    $.each(data, function (index) {
                        output += "<div class='row'>";
                        output += "<div class='col-md-2'>Order ID: " + data[index].ID + "</div>";
                        output += "<div class='col-md-2'>customerId: " + data[index].customerId + "</div>";
                        output += "<div class='col-md-2'>quantity:" + data[index].quantity + "</div>";
                        output += "</div>";
                        }
                    )
                    document.getElementById("order").innerHTML = output;
                });
            })
        </script>

         <script type="text/javascript">
             $(document).ready(function () {
                 var output = "";
                 $.getJSON('https://customer-service.cfapps.pez.pivotal.io/', function (data) {

                     $.each(data, function (index) {
                         output += "<div class='row'>";
                         output += "<div class='col-md-2'>Customer ID: " + data[index].id + "</div>";
                         output += "<div class='col-md-2'>Last Name: " + data[index].lastName + "</div>";
                         output += "<div class='col-md-2'>First Name: " + data[index].firstName + "</div>";
                         output += "</div>";
                     }
                     )
                     document.getElementById("customer").innerHTML = output;
                 });
             })
        </script>




    </div>


</body>
</html>

Move Traffic to new application
cf map-route javascript-service-new cfapps.pez.pivotal.io -n javascript-service
Creating route javascript-service.cfapps.pez.pivotal.io for org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
Route javascript-service.cfapps.pez.pivotal.io already exists
Adding route javascript-service.cfapps.pez.pivotal.io to app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Scaling Up The New Application
cf scale javascript-service-new -i 2
Scaling app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Scale Down The Old Application
cf scale javascript-service -i 1
Scaling app javascript-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Unmap the Old Application
cf unmap-route javascript-service cfapps.pez.pivotal.io -n javascript-service
Removing route javascript-service.cfapps.pez.pivotal.io from app javascript-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Stop the old application
cf stop javascript-service
Stopping app javascript-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Rename the old service to a name that reflects it new status
cf rename javascript-service javascript-service-old
Renaming app javascript-service to javascript-service-old in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Remove the temp route
cf unmap-route javascript-service-new cfapps.pez.pivotal.io -n javascript-service-new
Removing route javascript-service-new.cfapps.pez.pivotal.io from app javascript-service-new in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK

Rename the app
cf rename javascript-service-new javascript-service
Renaming app javascript-service-new to javascript-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
➜  devops-days git:(master) ✗ 


```

## Clean Up

Run the following to delete all the application

```shell
devops-days git:(master) ✗ ./demo_polyglot_3_reset.sh 
 _______    ______   ________        _______                                    
/       \  /      \ /        |      /       \                                   
$$$$$$$  |/$$$$$$  |$$$$$$$$/       $$$$$$$  |  ______   _____  ____    ______  
$$ |__$$ |$$ |  $$/ $$ |__          $$ |  $$ | /      \ /     \/    \  /      \ 
$$    $$/ $$ |      $$    |         $$ |  $$ |/$$$$$$  |$$$$$$ $$$$  |/$$$$$$  |
$$$$$$$/  $$ |   __ $$$$$/          $$ |  $$ |$$    $$ |$$ | $$ | $$ |$$ |  $$ |
$$ |      $$ \__/  |$$ |            $$ |__$$ |$$$$$$$$/ $$ | $$ | $$ |$$ \__$$ |
$$ |      $$    $$/ $$ |            $$    $$/ $$       |$$ | $$ | $$ |$$    $$/ 
$$/        $$$$$$/  $$/             $$$$$$$/   $$$$$$$/ $$/  $$/  $$/  $$$$$$/  
                                                                                
 
Running: https://api.run.pez.pivotal.io
This is running in an onpremise vSphere Cluster
 
Deleting .NET Service
Deleting app order-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
Deleting Spring/Java Service
Deleting app customer-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
Deleting Javascript Service
Deleting app javascript-service in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
Deleting Old Javascript Service (artifact of Blue/Green deployment)
Deleting app javascript-service-old in org pivot-lshannon / space devops-days as lshannon@pivotal.io...
OK
➜  devops-days git:(master) ✗ 
```

## Comments and Questions
Contact luke.shannon@gmail for questions or comments.

Follow me on twitter @lukewshannon




