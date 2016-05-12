using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace OrderRest
{
    /**
     * TODO: There needs to be a better way to work with a DB, I took 
     * this route because the Entity Framework approach did not work 
     * on Pez, even though it worked fine locally. But even outside
     * of the Entity Framework, .NET itself might have some better
     * ways to work with a Database.
     * 
     * TOD: Figure out how logging works in C#
     * 
     * */
    public class DataBaseHelper
    {
        private static MySqlConnection conn = null;
        private static MySqlDataReader dataReader = null;
        private static MySqlCommand cmd = null;
        private static Boolean alreadyIntialized;
        private static String CREATE_TABLE = "create table if not exists orders(id int, customerId int, quantity int);";
        private static String COUNT_ROWS = "select count(*) from orders";
        private static String INSERT_ROWS = "insert into orders (id, customerId, quantity) values (@id,@customerId,@quantity)";

        /**
         * On PEZ there is no way to connect to the DB through any remote DB management tools.
         * Everything needs to be intialized via the code.
         * */
        public static void checkForFirstStartUp() {
            if (!alreadyIntialized)
            {
                createTableIfNotThere(false);
                //check if rows are empty
                if (checkForEmptyRows(true))
                {
                    //insert sample data
                    insertSomeStarterData(true);
                }
            }
        }

        /**
        * This method will create the Table if its not in the DB
        * */
        private static void createTableIfNotThere(Boolean closeWhenDone)
        {
            Console.WriteLine("Checking If Table Is Created");
            try
            {
                obtainDBConnection();
                cmd.CommandText = CREATE_TABLE;
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.ToString());
            }
            finally
            {
                if (closeWhenDone)
                cleanUpDBConnection();
            }
            alreadyIntialized = true;
            Console.WriteLine("Done Checking For The Table");
        }

        /**
        * This method will check if data needs to be inserted
        * */
        private static Boolean checkForEmptyRows(Boolean closeWhenDone)
        {
            Console.WriteLine("Start Counting Rows");
            int count = -1;
            try
            {
                obtainDBConnection();
                cmd.CommandText = COUNT_ROWS;
                //Create a data reader and Execute the command
                dataReader = cmd.ExecuteReader();
                while (dataReader.Read())
                {
                    count = dataReader.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.ToString());
            }
            finally
            {
                if (closeWhenDone)
                cleanUpDBConnection();
            }
            Console.WriteLine("Row count is {0}", count);
            return count <= 0;
        }

        //Insert Some Sample Data
        public static void insertSomeStarterData(Boolean closeWhenDone)
        {
            Console.WriteLine("Start Inserting Data");
            try
            {
                obtainDBConnection();
                for (int i = 1; i < 5; i++)
                {
                    cmd = conn.CreateCommand();
                    cmd.CommandText = INSERT_ROWS;
                    cmd.Parameters.AddWithValue("@id", i);
                    cmd.Parameters.AddWithValue("@customerId", i);
                    cmd.Parameters.AddWithValue("@quantity", i);
                    Console.WriteLine("Inserted Row {0}", i);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine("Error: {0}", ex.ToString());
            }
            finally
            {
                if (closeWhenDone)
                cleanUpDBConnection();
            }
            Console.WriteLine("Done Inserting Data");
        }

        //Open the DB and any other resources
        private static void obtainDBConnection()
        {
            Console.WriteLine("Openning Connection");
            if (conn == null)
            {
                conn = new MySqlConnection(CloudConnectionHelper.connectionString());
                conn.Open();
            }
            if (cmd == null)
            {
                cmd = conn.CreateCommand();
            }
            Console.WriteLine("Connection Open");
        }

        //Close the DB and any other resources
        private static void cleanUpDBConnection()
        {
            Console.WriteLine("Closing Connection and Data Reader");
            if (conn != null)
            {
                conn.Close();
                conn = null;
            }
            if (cmd != null)
            {
                cmd = null;
            }
            if (dataReader != null)
            {
                dataReader.Close();
                dataReader = null;
            }
            Console.WriteLine("Connection and Data Reader Closed");
        }
    }
}