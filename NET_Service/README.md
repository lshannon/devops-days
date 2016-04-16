# .NET Sample

This is a simple Web API project that running in IIS. Upon start up it creates a database table (if it does not exist), puts sample data into it and then exposes those via a REST end point.

By default .NET REST endpoints return XML, however JSON can be obtained by setting the type in a request to 'text/json'.

## Deploying to PCF

The manifest.yml file contains the proper build pack and stack for pushing a .NET application to PCF. Run a 'cf push' from NET_Service/SimpleRest folder to deploy the application to PCF. It will take some time for the application to start.

For more information on running Windows on PCF:

https://docs.pivotal.io/pivotalcf/opsguide/deploying-diego.html

Trouble Shooting Steps:

https://docs.pivotal.io/pivotalcf/opsguide/troubleshooting-diego-windows.html

## End Points

To test the application run the following endpoint:

https://order-service.cfapps.pez.pivotal.io/api/Order

## Debugging Tips for .NET

To get access to Debugging statements in the PCF logs, set the following variable.

```shell
cf set-env order-service LOG_LEVEL debug
```
This will allow statements like the following to show up in the logs:

```java
Console.WriteLine("We are using the following to connect to the DB: " + actualConnection);
```
## Deployment Tips for .NET

Sometimes there will be a No Compatible Cell error upon push. If this happens just do the push again.

```shell

Using route order-service.cfapps.pez.pivotal.io
Uploading order-service...
Uploading app files from: C:\Users\Luke\Documents\Questrade-Development-Workshop\NET_Service\SimpleR
est\SimpleRest
Uploading 1.7M, 223 files
Done uploading
OK
Binding service mysql-svc to app order-service in org pivot-lshannon / space questrade as lshannon@p
ivotal.io...
OK

Stopping app order-service in org pivot-lshannon / space questrade as lshannon@pivotal.io...
OK

Starting app order-service in org pivot-lshannon / space questrade as lshannon@pivotal.io...

FAILED
NoCompatibleCell

TIP: use 'cf logs order-service --recent' for more information
```
