using System;
using System.Collections.Generic;

namespace Foundation.Shared.Customer
{
    public interface IFoundationOrganization
    {
        IFoundationAddress Address { get; }
        List<IFoundationAddress> Addresses { get; }
        string Name { get; set; }
        Guid OrganizationId { get; set; }
        Guid ParentOrganizationId { get; set; }
        List<IFoundationOrganization> SubOrganizations { get; }
        void SaveChanges();
    }
}