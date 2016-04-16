using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OrderRest
{
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