using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneCardsMVC.Models;

namespace PhoneCardsMVC.Controllers
{
    public class BaseController : Controller
    {

        public PhoneCardsDBEntities Db { get; set; }

        public BaseController()
        {
            Db = new PhoneCardsDBEntities();   
                
        }

    }
}