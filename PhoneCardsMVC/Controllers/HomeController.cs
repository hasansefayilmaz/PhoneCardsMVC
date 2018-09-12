using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PhoneCardsMVC.Models;

namespace PhoneCardsMVC.Controllers
{
    public class HomeController : BaseController
    {
        private AddContactViewModel vm = new AddContactViewModel();

        public HomeController()
        {
            Db.Configuration.ProxyCreationEnabled = false;
            vm.ConsultantTypes = Db.ConsultantType.ToList();
            vm.Departments = Db.Department.ToList();
            vm.Groups = Db.Group.ToList();
            vm.Titles = Db.Title.ToList();
            vm.Companies = Db.Company.ToList();
        }

        // GET: Home
        public ActionResult ListContacts(string response)
        {
            ViewBag.Response = response;

            var model = new ListContactViewModel();
            List<Contact> contacts = new List<Contact>();


            var result = Db.Contact.Where(x=> x.IsActive).OrderBy(q => q.Name).Take(3).ToList();


            foreach (var item in result)
            {
                Contact con = new Contact();
                con.Id = item.Id;
                con.Name = item.Name;
                con.Surname = item.Surname;
                con.GroupName = item.Group.Name  ;
                con.TitleName =  item.TitleId != null ?  item.Title.Name : "";

                contacts.Add(con);
            }

            model.Contacts = contacts;

            return View(model);
        }


        public ActionResult AddContact()
        {
            ViewBag.GroupID = new SelectList(vm.Groups, "Id", "Name");
            ViewBag.TitleID = new SelectList(vm.Titles, "Id", "Name");
            ViewBag.CompanyID = new SelectList(vm.Companies, "Id", "Name");
            ViewBag.DepartmentID = new SelectList(vm.Departments, "Id", "Name");
            ViewBag.ConsultantTypeID = new SelectList(vm.ConsultantTypes, "Id", "Name");

            //ViewBag.Groups = vm.Groups;
            //ViewBag.Titles= vm.Titles;
            //ViewBag.Companies = vm.Companies;
            //ViewBag.Departments = vm.Departments;
            //ViewBag.ConsultantTypes = vm.ConsultantTypes;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddContact(Contact contact)
        {
            if (!ModelState.IsValid)
            {

                ModelState.AddModelError("Hata", "Lütfen Zorunlu Alanları Doldurunuz");

                ViewBag.GroupId = new SelectList(vm.Groups, "Id", "Name", contact.GroupId);
                ViewBag.TitleId = new SelectList(vm.Titles, "Id", "Name", contact.TitleId);
                ViewBag.CompanyId = new SelectList(vm.Companies, "Id", "Name", contact.CompanyId);
                ViewBag.DepartmentId = new SelectList(vm.Departments, "Id", "Name", contact.DepartmentId);
                ViewBag.ConsultantTypeId = new SelectList(vm.ConsultantTypes, "Id", "Name", contact.ConsultantTypeId);

                ViewBag.Response = "Kayıt olşturulamaladı. Lütfen kontrol ediniz !";


                return View();

            }
            contact.IsActive = true;
            Db.Contact.Add(contact);
            Db.SaveChanges();


            return RedirectToAction("ListContacts", new { response = "Kaydınız başarıyla oluşturulmuştur.." });

        }


        public ActionResult EditContact(int id)
        {
            var contact = Db.Contact.FirstOrDefault(q => q.Id == id);


            ViewBag.GroupId = new SelectList(vm.Groups, "Id", "Name", contact.GroupId);
            ViewBag.TitleId = new SelectList(vm.Titles, "Id", "Name", contact.TitleId);
            ViewBag.CompanyId = new SelectList(vm.Companies, "Id", "Name", contact.CompanyId);
            ViewBag.DepartmentId = new SelectList(vm.Departments, "Id", "Name", contact.DepartmentId);
            ViewBag.ConsultantTypeId = new SelectList(vm.ConsultantTypes, "Id", "Name", contact.ConsultantTypeId);

            return View(contact);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditContact(Contact contact)
        {
            if (!ModelState.IsValid)
            {

                ModelState.AddModelError("Hata", "Lütfen Zorunlu Alanları Doldurunuz");

                ViewBag.GroupId = new SelectList(vm.Groups, "Id", "Name", contact.GroupId);
                ViewBag.TitleId = new SelectList(vm.Titles, "Id", "Name", contact.TitleId);
                ViewBag.CompanyId = new SelectList(vm.Companies, "Id", "Name", contact.CompanyId);
                ViewBag.DepartmentId = new SelectList(vm.Departments, "Id", "Name", contact.DepartmentId);
                ViewBag.ConsultantTypeId = new SelectList(vm.ConsultantTypes, "Id", "Name", contact.ConsultantTypeId);

                ViewBag.Response = "Kayıt güncellenemedi. Lütfen kontrol ediniz !";


                return View();

            }
            Db.Entry(contact).State = EntityState.Modified;
            Db.SaveChanges();


            return RedirectToAction("ListContacts", new { response = "Kaydınız başarıyla güncellenmiştir ." });

        }

        public ActionResult DetailContact(int id)
        {
            var contact = Db.Contact.FirstOrDefault(q => q.Id == id);

            Contact con = new Contact();
            con.Id = contact.Id;
            con.Name = contact.Name;
            con.Surname = contact.Surname;
            con.Phone = contact.Phone;
            con.GroupId = contact.GroupId;
            con.GroupName = contact.Group.Name;
            con.TitleName = contact.TitleId != null ? contact.Title.Name : "";
            con.CompanyName = contact.CompanyId != null ? contact.Company.Name : "";
            con.ConsultantTypeName = contact.ConsultantTypeId != null ? contact.ConsultantType.Name : "";
            con.DepartmentName = contact.DepartmentId != null ? contact.Department.Name : "";



            return View(con);
        }


        public ActionResult DeleteContact(int id)
        {
            Contact contact = Db.Contact.FirstOrDefault(q => q.Id == id);

            contact.IsActive = false;

            Db.Entry(contact).State = EntityState.Modified;
            Db.SaveChanges();

            return RedirectToAction("ListContacts", new { response = "Kaydınız başarıyla silinmiştir ." });
        }

        public JsonResult GetClientDepartments(int? CompanyId)
        {
            var departments = vm.Departments.Where(x => x.CompanyId == CompanyId).ToList();
            var viewDepartments = new List<Department>();
            foreach (var department in departments)
                viewDepartments.Add(new Department { Id = department.Id, Name = department.Name });
            return Json(viewDepartments, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetTitles(int? GroupId)
        {
            var viewTitles = new List<Title>();

            var titles = vm.Titles.Where(x => x.GroupId == GroupId).ToList();
            foreach (var title in titles)
                viewTitles.Add(new Title { Id = title.Id, Name = title.Name });

            return Json(viewTitles, JsonRequestBehavior.AllowGet);
        }

    }
}