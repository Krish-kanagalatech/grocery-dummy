class Products {
  String masterProductId;
  String masterCategoryId;
  String masterCategoryName;
  String masterSubCategoryId;
  String masterSubCategoryName;
  String masterProductName;
  String masterProductDescription;
  String masterProductMinOrderQty;
  String masterProductMaxOrderQty;
  String masterProductTaxId;
  String masterTaxName;
  String masterProductBusinessId;

  Products(
      {this.masterProductId,
      this.masterCategoryId,
      this.masterCategoryName,
      this.masterSubCategoryId,
      this.masterSubCategoryName,
      this.masterProductName,
      this.masterProductDescription,
      this.masterProductMinOrderQty,
      this.masterProductMaxOrderQty,
      this.masterProductTaxId,
      this.masterTaxName,
      this.masterProductBusinessId});
}
