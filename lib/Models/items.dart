class Items {
  String masterProductDetailsId;
  String masterProductId;
  String masterProductName;
  String masterProductDetailsMrp;
  String masterProductDetailsSalePrice;
  String masterProductDetailsUnitId;
  String masterProductDetailsBusinessId;
  String masterProductStatus;
  int itemCount;
  String selectedKg;

  Items({
    this.masterProductDetailsId,
    this.masterProductId,
    this.masterProductName,
    this.masterProductDetailsMrp,
    this.masterProductDetailsSalePrice,
    this.masterProductDetailsUnitId,
    this.masterProductDetailsBusinessId,
    this.masterProductStatus,
    this.itemCount = 0,
    this.selectedKg = '1 kg',
  });
}
