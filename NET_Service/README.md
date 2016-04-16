# Questrade PCF Developers Workshop

## Building Out The .NET Application

*Disclaimer:* We are not a .NET oriented team, as a result this lab is not intended to show best practice for .NET development but rather how a .NET application can be deployed to Pivotal Cloud Foundry and intergrated with other applications.

## Deploying to PCF

```shell
cf push

Online Console:
https://login.run.pez.pivotal.io/login
```

## Principle and Practice Verification

## Debugging

To get access to Debugging statements in the PCF logs, set the following variable.

```shell
cf set-env order-service LOG_LEVEL debug
```
This will allow statements like the following to show up in the logs:

```java
Console.WriteLine("We are using the following to connect to the DB: " + actualConnection);
```
## Trouble Shooting

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
