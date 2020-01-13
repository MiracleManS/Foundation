using Foundation.Shared.Customer;
using Mediachase.BusinessFoundation.Data;
using Mediachase.BusinessFoundation.Data.Business;
using Mediachase.Commerce.Customers;
using System;

namespace Foundation.Commerce.Customer
{
    public class FoundationAddress : IFoundationAddress
    {
        private readonly CustomerAddress _address;

        public FoundationAddress(CustomerAddress customerAddress) => _address = customerAddress;

        public Guid AddressId
        {
            get => _address.AddressId;
            set => _address.AddressId = (PrimaryKeyId)value;
        }

        public string Name
        {
            get => _address.Name;
            set => _address.Name = value;
        }

        public string Street
        {
            get => _address.Line1;
            set => _address.Line1 = value;
        }

        public string City
        {
            get => _address.City;
            set => _address.City = value;
        }

        public string PostalCode
        {
            get => _address.PostalCode;
            set => _address.PostalCode = value;
        }

        public string CountryCode
        {
            get => _address.CountryCode;
            set => _address.CountryCode = value;
        }

        public string CountryName
        {
            get => _address.CountryName;
            set => _address.CountryName = value;
        }

        public Guid OrganizationId
        {
            get => _address.OrganizationId ?? Guid.Empty;
            set => _address.OrganizationId = (PrimaryKeyId?)value;
        }

        public void SaveChanges() => BusinessManager.Update(_address);

        public void Delete() => _address.Delete();
    }
}