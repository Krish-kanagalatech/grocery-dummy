class Orders {
  String masterOrderId;
  String masterOrderCustomerId;
  String masterCustomerName;
  String masterOrderProductId;
  String masterProductName;
  String masterOrderCartAmount;
  String masterOrderTaxId;
  String masterTaxName;
  String masterOrderDiscount;
  String masterOrderNetAmount;
  String masterOrderPaymentMode;
  String masterOrderDeliverySlotId;
  String deliverySlotsStartTime;
  String deliverySlotsStartTimeZone;
  String deliverySlotsEndTime;
  String deliverySlotsEndTimeZone;
  String masterOrderStatus;
  String masterOrderBusinessId;

  Orders(
      {this.masterOrderId,
      this.masterOrderCustomerId,
      this.masterCustomerName,
      this.masterOrderProductId,
      this.masterProductName,
      this.masterOrderCartAmount,
      this.masterOrderTaxId,
      this.masterTaxName,
      this.masterOrderDiscount,
      this.masterOrderNetAmount,
      this.masterOrderPaymentMode,
      this.masterOrderDeliverySlotId,
      this.deliverySlotsStartTime,
      this.deliverySlotsStartTimeZone,
      this.deliverySlotsEndTime,
      this.deliverySlotsEndTimeZone,
      this.masterOrderStatus,
      this.masterOrderBusinessId});
}
