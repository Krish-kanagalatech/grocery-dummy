class Cart {
  String name;
  String id;
  String quantity;
  double price;
  int itemCountValue;
  String taxId;
  String imagePath;

  Cart({
    this.name,
    this.id,
    this.price,
    this.quantity,
    this.itemCountValue = 0,
    this.taxId,
    this.imagePath,
  });
}
