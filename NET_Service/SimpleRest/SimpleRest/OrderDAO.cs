using MySql.Data.MySqlClient;
using OrderRest.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OrderRest
{
    public class OrderDAO
    {
        //Little helper method to get the orders
        //To DO - Need to learn Connection Pooling or Entity Framework - this is really inefficient!
        public static List<Order> lookUpOrders()
        {
            var results = new List<Order>();
            try
            {
                MySqlConnection conn = new MySqlConnection(CloudConnectionHelper.connectionString());
                conn.Open();
                string stm = "SELECT * FROM orders";
                MySqlCommand cmd = new MySqlCommand(stm, conn);
                MySqlDataReader dataReader = cmd.ExecuteReader();
                while (dataReader.Read())
                {
                    Order newOrder = new Order { ID = dataReader.GetInt32(0), customerId = dataReader.GetInt32(1), quantity = dataReader.GetInt32(2) };
                    results.Add(newOrder);
                }
                conn.Close();
                dataReader.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.ToString());
            }
            return results;
        }
    }
}