# Simple-Data-Application

This is a simple Spring Boot application that shows working with a Database using Spring JDBC Template. It provides very simple REST end points to update/view database records.

NOTE: It needs to be bound to a MySQL data service. The SQL has not been tested on Postgres and most likely will not work.

## Summary of Endpoints

Set Message:

http://simple-data-service.cfapps.io/set?message=Hello World

Get All Messages:

http://simple-data-service.cfapps.io/get

Delete All Messages:

Delete Single Message:



## Deploying to PCF

Now let's go ahead and deploy the application to PCF.

1.  First, let's make sure we are targeting the correct CF instance.  From the command prompt, enter `cf login -a https://api.run.pez.pivotal.io`.  Enter your email address for the user, and your password.  Select `pivot-lshannon` as the org, and the space that has been assigned to you.

1.  From the same directory you ran the build, enter `cf push`.  Wait until you see that your application has started and shows as running.

## Principle and Practice Verification

Log into the Apps Manager in your browser, at https://apps.run.pez.pivotal.io.  Select the correct org and space and observe your app is running.  Click on the URL and you should observe a JSON formatted result of a list of customers as shown below.

```
{
"id": 1,
"firstName": "Dan",
"lastName": "Buchko"
},
{
"id": 2,
"firstName": "Luke",
"lastName": "Shannon"
},
{
"id": 3,
"firstName": "David 'Maniac'",
"lastName": "Barry"
},
{
"id": 4,
"firstName": "Louis",
"lastName": "Lo"
}
]```
