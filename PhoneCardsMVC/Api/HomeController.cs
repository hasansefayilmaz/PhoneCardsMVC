using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Http;
using PhoneCardsMVC.Models;

namespace PhoneCardsMVC.Api
{
    public class HomeController : ApiController
    {

        PhoneCardsDBEntities Db = new PhoneCardsDBEntities();


        //[ResponseType(typeof(Contact))]
        //[System.Web.Http.Route("api/Home/{id}")]
        [HttpGet]
        public IHttpActionResult Next3Record(byte each)
        {
            List<Contact> contacts = new List<Contact>();

            var result = Db.Contact.Where(x=> x.IsActive).OrderBy(q => q.Name).Skip(each * 3).Take(3).ToList();

            foreach (var item in result)
            {
                Contact con = new Contact();
                con.Id = item.Id;
                con.Name = item.Name;
                con.Surname = item.Surname;
                con.GroupName = item.Group.Name;
                con.TitleName = item.Title.Name;

                contacts.Add(item);
            }
            

            if (contacts != null)
            {
                return Content(HttpStatusCode.OK, contacts);
            }


            return Content(HttpStatusCode.NotFound, 0);
        }

    }
}
