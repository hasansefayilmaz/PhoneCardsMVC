using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneCardsMVC.Models
{
    public class AddContactViewModel
    {
        public Contact Contact { get; set; }
        public List<Group> Groups { get; set; }
        public List<Company> Companies { get; set; }
        public List<Department> Departments { get; set; }
        public List<ConsultantType> ConsultantTypes { get; set; }
        public List<Title> Titles { get; set; }

    }
}