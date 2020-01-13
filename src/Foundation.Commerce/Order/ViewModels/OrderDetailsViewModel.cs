﻿using EPiServer.Commerce.Order;
using Foundation.Cms.ViewModels;
using Foundation.Commerce.Customer.ViewModels;
using Foundation.Commerce.Models.Pages;
using Foundation.Shared.Web.ViewModels;
using Mediachase.Commerce.Orders;
using System.Collections.Generic;

namespace Foundation.Commerce.Order.ViewModels
{
    public class OrderDetailsViewModel : ContentViewModel<OrderDetailsPage>
    {
        public ContactViewModel CurrentCustomer { get; set; }
        public IPurchaseOrder PurchaseOrder { get; set; }
        public IEnumerable<OrderDetailsItemViewModel> Items { get; set; }
        public AddressModel BillingAddress { get; set; }
        public IList<AddressModel> ShippingAddresses { get; set; }
        public string QuoteStatus { get; set; }
        public int OrderGroupId { get; set; }
        public IPayment BudgetPayment { get; set; }
        public string ErrorMessage { get; set; }

        public string OrderStatus
            =>
                !IsPaymentApproved
                    ? Constant.Order.PendingApproval
                    : QuoteStatus ?? PurchaseOrder.OrderStatus.ToString();

        public bool IsPaymentApproved
            =>
                BudgetPayment == null ||
                (BudgetPayment != null && BudgetPayment.TransactionType.Equals(TransactionType.Capture.ToString()));
        public bool IsOrganizationOrder => BudgetPayment != null || !string.IsNullOrEmpty(QuoteStatus);
    }
}