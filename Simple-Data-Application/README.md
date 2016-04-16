# Questrade PCF Developers Workshop

Luke

## Building Out The Service

The project for this lab is in the customer-service folder.

1.  Fork the https://github.com/lshannonPivotal/Qestrade repository, and clone it to your local machine.

1.  Open the Spring Tool Suite (STS).  Off the menu, select "File"->"Import".  Expand the "Maven" folder, and select "Existing Maven Projects".  Browse to "Questrade-Development-Workshop/Spring_Service/customer-service" directory, check the box, and import the project.  Note there are corresponding "solution" directories you can import to view in case you get stuck.

1.  In the main application code, make this a Spring Boot application by adding the @SpringBootApplication annotation.  Hint: Look for a source code file with a `public static void main(String[] args)` method.

2.  Open the CustomerServiceController.java source file and enable this class to be accessible through a REST interface by adding the @RestController annotation just before the class declaration.

3.  In the same file, find the `getCustomers()` method, and annotate it to be called with a relative URL path of `/` by adding a @RequestMapping annotation.

4.  Open the /src/main/resources/application.yml file and examine the contents.  Note we have requested that the database repository schema be created by setting the `spring.jpa.generate-ddl` property to true.  Also note we have currently disabled basic authentication.

5.  Open the pom.xml file, and note that the `spring-cloud-services-starter-parent` has been included as the parent project.  By specifying the version here, appropriate versions of other dependencies specified below will be selected automatically.

1.  Open the manifest.yml file, and examine the contents.  This file provides Cloud Foundry instructions on how to deploy your application.  Note that one service has been specified, the `mysql-svc`.  This will be the backing store for the customer repository.

1.  Build the project.  Open a command prompt window and navigate to the customer-service directory.  Enter `mvn clean package`, and look for a SUCCESS message at the end.

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
