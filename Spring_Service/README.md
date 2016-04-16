# Spring Service

This is a Spring Boot Services that uses JPA to read and write to a database. It exposes its data via REST end points.

Upon start up the applications:
- creates a test database if it does not exist
- addes sample data

This applications requires a MySQL datasource available in the space called: mysql-svc-2

## Deploying to PCF

Simply run 'cf push' from the root directory of the project (the manifest.yml file will be in this location). The cli will detect the manifest.yml file which contains all the meta data required to successfully push the application. A MySQL service called 'mysql-svc-2' must exist in the space the application is pushed too.

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
