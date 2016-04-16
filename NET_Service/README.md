# .NET Sample

This is a simple Web API project that running in IIS. Upon start up it creates a database table (if it does not exist), puts sample data into it and then exposes those via a REST end point.

By default .NET REST endpoints return XML, however JSON can be obtained by setting the type in a request to 'text/json'.

## Deploying to PCF

The manifest.yml file contains the proper build pack and stack for pushing a .NET application to PCF. Run a 'cf push' from NET_Service/SimpleRest folder to deploy the application to PCF. It will take some time for the application to start.

For more information on running Windows on PCF:

https://docs.pivotal.io/pivotalcf/opsguide/deploying-diego.html

Trouble Shooting Steps:

https://docs.pivotal.io/pivotalcf/opsguide/troubleshooting-diego-windows.html

## Deployment Notes - Data Source binding

The application uses a custom C# code to detect if VCAP_SERViCES is available in runtime. If this is the case, it gets credentials from this service to create the Database connection. Otherwise it will use a local connection.

For VCAPS_SERVICES to have this value the data services needs to be bound to the application. The manifest.yml file takes care of this.

```java

 public class CloudConnectionHelper
    {
        //Look up connection from either vCaps sevice or local
        public static string connectionString()
        {
            //if running outside PCF this will be NULL
            if (Environment.GetEnvironmentVariable("VCAP_SERVICES") != null)
            {
                Dictionary<string, object> vcapServices = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(
                    Environment.GetEnvironmentVariable("VCAP_SERVICES"));

                if (vcapServices != null)
                {
                    // this is the dumb way - this is the smart way https://github.com/dmikusa-pivotal/cf-ex-phpmyadmin/blob/master/htdocs/config.inc.php
                    var credentials = ((Newtonsoft.Json.Linq.JArray)vcapServices["p-mysql"]).First()["credentials"];
                    if (credentials != null)
                    {
                        MySqlConnectionStringBuilder conn_string = new MySqlConnectionStringBuilder();
                        conn_string.Server = (String)credentials["hostname"];
                        conn_string.Port = (uint)Int32.Parse((String)credentials["port"]);
                        conn_string.UserID = (String)credentials["username"];
                        conn_string.Password = (String)credentials["password"];
                        conn_string.Database = (String)credentials["name"];
                        //Note that the DB is not listed. This is supplied by the service
                        Console.WriteLine("We are using the following to connect to the DB: " + conn_string.ToString());
                        return conn_string.ToString();

                    }
                }
            }
            //this is the local connection
            return "Server=localhost;Uid=root;Pwd=password;Database=orderdb";
        }
    }
}

```

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
