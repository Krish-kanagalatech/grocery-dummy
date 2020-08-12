class Location {
  String masterCustomerId;
  String masterCustomerName;
  String masterCustomerLatitude;
  String masterCustomerLongitude;
  String masterCustomerAddressline1;
  String masterCustomerAddressline2;
  String masterCustomerLandmark;
  String masterCustomerArea;
  String masterCustomerCity;
  String masterCustomerBusinessId;
  String name;

  Location(
      {this.masterCustomerId,
      this.masterCustomerName,
      this.masterCustomerLatitude,
      this.masterCustomerLongitude,
      this.masterCustomerAddressline1,
      this.masterCustomerAddressline2,
      this.masterCustomerLandmark,
      this.masterCustomerArea,
      this.masterCustomerCity,
      this.masterCustomerBusinessId,
      this.name = ''});
}

class CustomerAddress {
  String customersAddressId;
  String masterCustomerId;
  String customersAddressTitle;

  CustomerAddress({
    this.customersAddressId,
    this.masterCustomerId,
    this.customersAddressTitle,
  });
}
