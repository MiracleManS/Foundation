using System;

namespace Foundation.Shared.Customer
{
    public interface IFoundationAddress
    {
        Guid AddressId { get; set; }
        string City { get; set; }
        string CountryCode { get; set; }
        string CountryName { get; set; }
        string Name { get; set; }
        Guid OrganizationId { get; set; }
        string PostalCode { get; set; }
        string Street { get; set; }

        void Delete();
        void SaveChanges();
    }
}