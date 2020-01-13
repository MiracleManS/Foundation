using Foundation.Shared.Customer;
using Mediachase.BusinessFoundation.Data;
using Mediachase.Commerce.Customers;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Foundation.Commerce.Customer
{
    public class FoundationOrganization : IFoundationOrganization
    {
        private readonly Organization _organizationEntity;
        private IFoundationAddress _address;

        public FoundationOrganization(Organization organization) => _organizationEntity = organization;

        public Guid OrganizationId
        {
            get => _organizationEntity.PrimaryKeyId ?? Guid.Empty;
            set => _organizationEntity.PrimaryKeyId = (PrimaryKeyId?)value;
        }

        public string Name
        {
            get => _organizationEntity.Name;
            set => _organizationEntity.Name = value;
        }

        public IFoundationAddress Address => _address = _address ?? Addresses.FirstOrDefault();

        public List<IFoundationAddress> Addresses =>
            _organizationEntity.Addresses?.Any() == true
            ? _organizationEntity.Addresses.Select(address => new FoundationAddress(address) as IFoundationAddress).ToList()
            : new List<IFoundationAddress>();

        public List<IFoundationOrganization> SubOrganizations => _organizationEntity.ChildOrganizations
            .Select(childOrganization => new FoundationOrganization(childOrganization) as IFoundationOrganization)
            .ToList();

        public Guid ParentOrganizationId
        {
            get => _organizationEntity.ParentId ?? Guid.Empty;
            set => _organizationEntity.ParentId = (PrimaryKeyId?)value;
        }

        public IFoundationOrganization ParentOrganization { get; set; }

        public void SaveChanges() => _organizationEntity.SaveChanges();

        public static FoundationOrganization New() => new FoundationOrganization(Organization.CreateInstance());
    }
}