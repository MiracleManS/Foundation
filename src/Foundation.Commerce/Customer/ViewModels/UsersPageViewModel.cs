using Foundation.Cms.ViewModels;
using Foundation.Commerce.Models.Pages;
using Foundation.Shared.Customer;
using System.Collections.Generic;

namespace Foundation.Commerce.Customer.ViewModels
{
    public class UsersPageViewModel : ContentViewModel<UsersPage>
    {
        public List<FoundationContact> Users { get; set; }
        public FoundationContact Contact { get; set; }
        public List<IFoundationOrganization> Organizations { get; set; }
        public SubFoundationOrganizationModel SubOrganization { get; set; }
    }
}
