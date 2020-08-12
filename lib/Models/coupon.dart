class Coupon {
  String masterCouponId;
  String masterCouponName;
  String masterCouponDescription;
  String masterCouponDiscountType;
  String masterCouponValue;
  String masterCouponMinCartValue;
  String masterCouponExpireDate;
  String masterCouponDelivery;
  String masterCouponMaxUsagePerUser;
  String masterCouponStatus;
  String masterCouponBusinessId;

  Coupon(
      {this.masterCouponId,
      this.masterCouponName,
      this.masterCouponDescription,
      this.masterCouponDiscountType,
      this.masterCouponValue,
      this.masterCouponMinCartValue,
      this.masterCouponExpireDate,
      this.masterCouponDelivery,
      this.masterCouponMaxUsagePerUser,
      this.masterCouponStatus,
      this.masterCouponBusinessId});
}
