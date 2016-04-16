# Simple-Data-Application

This is a simple Spring Boot application that shows working with a Database using Spring JDBC Template. It provides very simple REST end points to update/view database records.

Upon start up it will:
- Create a database table if it does not exist
- Insert some sample data

NOTE: It needs to be bound to a MySQL data service. The SQL has not been tested on Postgres and most likely will not work.

## Summary of Endpoints

Set Message:

http://simple-data-service.cfapps.io/set?message=Hello World

Get All Messages:

http://simple-data-service.cfapps.io/get

Delete All Messages:

http://simple-data-service.cfapps.io/deleteAll

Delete Single Message:

http://simple-data-service.cfapps.io/delete?id=1



## Deploying to PCF

Simply run 'cf push' from the root directory of the project (the manifest.yml file will be in this location). The cli will detect the manifest.yml file which contains all the meta data required to successfully push the application. A MySQL service called 'mysql-datasource' must exist in the space the application is pushed too.

## Endpoints

To test the application, hit the root path:

https://customer-service.cfapps.pez.pivotal.io/

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
