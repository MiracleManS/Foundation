using EPiServer.Framework.DataAnnotations;
using EPiServer.Web.Mvc;
using Foundation.Commerce.Customer;
using Foundation.Commerce.Models.Blocks;
using Foundation.Commerce.Models.Catalog;
using Foundation.Commerce.ViewModels;
// todo: commerce decouple
//using Mediachase.Commerce.Customers;
using System.Web.Mvc;

namespace Foundation.Features.Blocks
{
    [TemplateDescriptor(Default = true)]
    public class ElevatedRoleBlockController : BlockController<ElevatedRoleBlock>
    {
        public override ActionResult Index(ElevatedRoleBlock currentBlock)
        {
            var viewModel = new ElevatedRoleBlockViewModel(currentBlock);
            // todo: commerce decouple
            //var currentContact = CustomerContext.Current.CurrentContact;
            //if (currentContact != null)
            //{
            //    var contact = new FoundationContact(currentContact);
            //    if (contact.ElevatedRole == ElevatedRoles.Reader.ToString())
            //    {
            //        viewModel.IsAccess = true;
            //    }
            //}
            return PartialView("~/Features/Blocks/Views/ElevatedRoleBlock.cshtml", viewModel);
        }
    }
}
