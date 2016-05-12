using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace OrderRest.Controllers
{
     
    //Our simple Domain class
    public class Order
    {
        public int ID { get; set; }
        public long customerId { get; set; }
        public int quantity { get; set; }
    }

    //Controller - full of logic
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class OrderController : ApiController
    {
   
        // We are are going to intialize the tables here
        public IEnumerable<Order> Get()
        {
            //Check if this is a first start up and intialize
            DataBaseHelper.checkForFirstStartUp();
            return OrderDAO.lookUpOrders();
        }

        // GET api/values/5
        //TODO - update the DAO to handle this
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        //TODO - update the DAO to handle this
        public void Post([FromBody]Order value)
        {
        }

        // PUT api/values/5
        //TODO - update the DAO to handle this
        public void Put(int id, [FromBody]Order value)
        {
        }

        // DELETE api/values/5
        //TODO - update the DAO to handle this
        public void Delete(int id)
        {
        }
    }
}