import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:grocerycustomerdemo/Models/category.dart';
import 'package:grocerycustomerdemo/Models/manufacture.dart';
import 'package:grocerycustomerdemo/Models/items.dart';
import 'package:grocerycustomerdemo/Models/slider.dart';
import 'package:grocerycustomerdemo/Models/tax.dart';
import 'package:grocerycustomerdemo/Models/subCategory.dart';
import 'package:grocerycustomerdemo/Models/cart.dart';
import 'package:grocerycustomerdemo/Models/products.dart';
import 'package:grocerycustomerdemo/Models/time.dart';
import 'package:grocerycustomerdemo/Models/coupon.dart';
import 'package:grocerycustomerdemo/Models/location.dart';
import 'package:grocerycustomerdemo/Models/orders.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<Category> category = [];
  List<SubCategory> subCategory = [];
  List<Manufacturer> manufacturer = [];
  List<Items> items = [];
  List<Products> products = [];
  List<Location> location = [];
  List<Orders> orders = [];
  List<Tax> tax = [];
  List<Cart> cart = [];
  List<Coupon> coupon = [];
  List<TimeSlots> timeSlots = [];
  List<CustomerAddress> customerAddress = [];
  List<Slider> slider = [];
  bool init = true;
  bool initLocation = true;
  bool initManufacturer = true;
  bool initsubCategory = true;
  bool initItems = true;
  bool initProduct = true;
  bool initTax = true;
  bool initOrders = true;
  bool initSlider = true;
  bool initCoupon = true;
  bool initTimeSlots = true;
  bool initCustomerAddress = true;
  bool loadedSlider = true;
  Future<void> fetchAndSetSlider() async {
    initSlider = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readHomeBanner.php')
        .then((value) {
      slider = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is in location page');
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        slider.add(
          Slider(
            masterHomeSliderId: decoded['body'][i]['master_home_slider_id'],
            masterHomeSliderTitle: decoded['body'][i]
                ['master_home_slider_title'],
            masterHomeSliderImage: decoded['body'][i]
                ['master_home_slider_image'],
            masterHomeSliderCategoryId: decoded['body'][i]
                ['master_home_slider_category_id'],
            masterCategoryName: decoded['body'][i]['master_category_name'],
          ),
        );
      }
      loadedSlider = false;
      notifyListeners();
    });
  }

  Future<void> fetchAndSetTimeSlots() async {
    initTimeSlots = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readDeliverySlots.php')
        .then((value) {
      timeSlots = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is in location page');
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        timeSlots.add(
          TimeSlots(
            businessSettingsId: decoded['body'][i]['business_settings_id'],
            businessDeliverySlots: decoded['body'][i]
                ['business_delivery_slots'],
            businessId: decoded['body'][i]['business_id'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetCoupon() async {
    initCoupon = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readCoupons.php')
        .then((value) {
      coupon = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is in location page');
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        coupon.add(
          Coupon(
            masterCouponId: decoded['body'][i]['master_coupon_id'],
            masterCouponName: decoded['body'][i]['master_coupon_name'],
            masterCouponDescription: decoded['body'][i]
                ['master_coupon_description'],
            masterCouponDiscountType: decoded['body'][i]
                ['master_coupon_discount_type'],
            masterCouponValue: decoded['body'][i]['master_coupon_value'],
            masterCouponMinCartValue: decoded['body'][i]
                ['master_coupon_min_cart_value'],
            masterCouponExpireDate: decoded['body'][i]
                ['master_coupon_expire_date'],
            masterCouponDelivery: decoded['body'][i]['master_coupon_delivery'],
            masterCouponMaxUsagePerUser: decoded['body'][i]
                ['master_coupon_max_usage_per_user'],
            masterCouponStatus: decoded['body'][i]['master_coupon_status'],
            masterCouponBusinessId: decoded['body'][i]
                ['master_coupon_business_id'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetOrders() async {
    initOrders = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readOrders.php')
        .then((value) {
      orders = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is in location page');
      print(decoded);
      if (decoded['message'] != 'No record found.') {
        print(decoded['body']);
        print(decoded['body'].length);
        for (int i = 0; i < decoded['body'].length; i++) {
          orders.add(
            Orders(
              masterOrderId: decoded['body'][i]['master_order_id'],
              masterOrderCustomerId: decoded['body'][i]
                  ['master_order_customer_id'],
              masterCustomerName: decoded['body'][i]['master_customer_name'],
              masterOrderProductId: decoded['body'][i]
                  ['master_order_product_id'],
              masterProductName: decoded['body'][i]['master_product_name'],
              masterOrderCartAmount: decoded['body'][i]
                  ['master_order_cart_amount'],
              masterOrderTaxId: decoded['body'][i]['master_order_tax_id'],
              masterTaxName: decoded['body'][i]['master_tax_name'],
              masterOrderDiscount: decoded['body'][i]['master_order_discount'],
              masterOrderNetAmount: decoded['body'][i]
                  ['master_order_net_amount'],
              masterOrderPaymentMode: decoded['body'][i]
                  ['master_order_payment_mode'],
              masterOrderDeliverySlotId: decoded['body'][i]
                  ['master_order_delivery_slot_id'],
              deliverySlotsStartTime: decoded['body'][i]
                  ['delivery_slots_start_time'],
              deliverySlotsStartTimeZone: decoded['body'][i]
                  ['delivery_slots_start_time_zone'],
              deliverySlotsEndTime: decoded['body'][i]
                  ['delivery_slots_end_time'],
              deliverySlotsEndTimeZone: decoded['body'][i]
                  ['delivery_slots_end_time_zone'],
              masterOrderStatus: decoded['body'][i]['master_order_status'],
              masterOrderBusinessId: decoded['body'][i]
                  ['master_order_business_id'],
            ),
          );
        }
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetLocation() async {
    initLocation = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readCustomers.php')
        .then((value) {
      location = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is in location page');
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        location.add(
          Location(
            masterCustomerAddressline1: decoded['body'][i]
                ['master_customer_addressline1'],
            masterCustomerAddressline2: decoded['body'][i]
                ['master_customer_addressline2'],
            masterCustomerArea: decoded['body'][i]['master_customer_area'],
            masterCustomerBusinessId: decoded['body'][i]
                ['master_customer_business_id'],
            masterCustomerCity: decoded['body'][i]['master_customer_city'],
            masterCustomerId: decoded['body'][i]['master_customer_id'],
            masterCustomerLandmark: decoded['body'][i]
                ['master_customer_landmark'],
            masterCustomerLatitude: decoded['body'][i]
                ['master_customer_latitude'],
            masterCustomerLongitude: decoded['body'][i]
                ['master_customer_longitude'],
            masterCustomerName: decoded['body'][i]['master_customer_name'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetCategories() async {
    init = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readCategories.php')
        .then((value) {
      category = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        if (decoded['body'][i]['master_category_business_id'] == '100001')
          category.add(Category(
              categoryId: decoded['body'][i]['master_category_id'],
              categoryName: decoded['body'][i]['master_category_name'],
              categoryBusinessId: decoded['body'][i]
                  ['master_category_business_id'],
              categoryIcon: decoded['body'][i]['master_category_icon'],
              categoryImage: decoded['body'][i]['master_category_image'],
              categoryStatus: decoded['body'][i]['master_category_status']));
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetManufacturer() async {
    initManufacturer = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readManufacturers.php')
        .then((value) {
      manufacturer = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        manufacturer.add(
          Manufacturer(
            manufacturerBusinessId: decoded['body'][i]
                ['master_manufacturer_business_id'],
            manufacturerId: decoded['body'][i]['master_manufacturer_id'],
            manufacturerName: decoded['body'][i]['master_manufacturer_name'],
            manufacturerStatus: decoded['body'][i]
                ['master_manufacturer_status'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetSubCategory() async {
    initsubCategory = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readSubCategories.php')
        .then((value) {
      subCategory = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        subCategory.add(
          SubCategory(
            masterCategoryId: decoded['body'][i]['master_category_id'],
            masterCategoryName: decoded['body'][i]['master_category_name'],
            masterSubCategoryBusinessId: decoded['body'][i]
                ['master_subCategory_business_id'],
            masterSubCategoryIcon: decoded['body'][i]
                ['master_subCategory_icon'],
            masterSubCategoryStatus: decoded['body'][i]
                ['master_subCategory_status'],
            masterSubCategoryId: decoded['body'][i]['master_subCategory_id'],
            masterSubCategoryImage: decoded['body'][i]
                ['master_subCategory_image'],
            masterSubCategoryName: decoded['body'][i]
                ['master_subCategory_name'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetItems() async {
    initItems = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readProductDetails.php')
        .then((value) {
      items = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        items.add(
          Items(
            masterProductDetailsBusinessId: decoded['body'][i]
                ['master_product_details_business_id'],
            masterProductDetailsId: decoded['body'][i]
                ['master_product_details_id'],
            masterProductDetailsMrp: decoded['body'][i]
                ['master_product_details_mrp'],
            masterProductDetailsSalePrice: decoded['body'][i]
                ['master_product_details_sale_price'],
            masterProductDetailsUnitId: decoded['body'][i]
                ['master_product_details_unit_id'],
            masterProductId: decoded['body'][i]['master_product_id'],
            masterProductName: decoded['body'][i]['master_product_name'],
            masterProductStatus: decoded['body'][i]['master_product_status'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetProducts() async {
    initProduct = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readProducts.php')
        .then((value) {
      products = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print('this is the [roducts');
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        products.add(
          Products(
            masterCategoryId: decoded['body'][i]['master_category_id'],
            masterCategoryName: decoded['body'][i]['master_category_name'],
            masterProductBusinessId: decoded['body'][i]
                ['master_product_business_id'],
            masterProductDescription: decoded['body'][i]
                ['master_product_description'],
            masterProductId: decoded['body'][i]['master_product_id'],
            masterProductMaxOrderQty: decoded['body'][i]
                ['master_product_max_orderQty'],
            masterProductMinOrderQty: decoded['body'][i]
                ['master_product_min_orderQty'],
            masterProductName: decoded['body'][i]['master_product_name'],
            masterProductTaxId: decoded['body'][i]['master_product_tax_id'],
            masterSubCategoryId: decoded['body'][i]['master_subCategory_id'],
            masterSubCategoryName: decoded['body'][i]
                ['master_subCategory_name'],
            masterTaxName: decoded['body'][i]['master_tax_name'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> fetchAndSetTax() async {
    initTax = false;
    // notifyListeners();
    await http
        .get('http://groceryapp.kanagalatech.com/API/readTax.php')
        .then((value) {
      tax = [];
      print(value.body);
      var decoded = jsonDecode(value.body);
      print(decoded);
      print(decoded['body']);
      print(decoded['body'].length);
      for (int i = 0; i < decoded['body'].length; i++) {
        tax.add(
          Tax(
            masterTaxName: decoded['body'][i]['master_tax_name'],
            masterTaxBusinessId: decoded['body'][i]['master_tax_business_id'],
            masterTaxId: decoded['body'][i]['master_tax_id'],
            masterTaxPercentage: decoded['body'][i]['master_tax_percentage'],
            masterTaxStatus: decoded['body'][i]['master_tax_status'],
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<void> addCartInPage(
    String name,
    String id,
    String quantity,
    double price,
    int itemValue,
  ) async {
    bool found = false;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id && cart[i].quantity == quantity) {
        found = true;
        cart[i].itemCountValue += itemValue;
        cart[i].price = 0;
        cart[i].price = itemValue * price;
        break;
      }
    }
    if (found == false) {
      cart.insert(
          0,
          Cart(
            id: id,
            name: name,
            quantity: quantity,
            price: itemValue * price,
            itemCountValue: itemValue,
          ));
    }
    notifyListeners();
  }

  Future<void> addCart(
    String name,
    String id,
    String quantity,
    double price,
  ) async {
    bool found = false;
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id && cart[i].quantity == quantity) {
        found = true;
        cart[i].itemCountValue += 1;
        cart[i].price += price;
        break;
      }
    }
    if (found == false) {
      cart.insert(
          0,
          Cart(
            id: id,
            name: name,
            quantity: quantity,
            price: price,
            itemCountValue: 1,
          ));
    }
    notifyListeners();
  }

  Future<void> removeCart(
    String id,
    double amount,
    String quantity,
  ) async {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].id == id && cart[i].quantity == quantity) {
        if (cart[i].itemCountValue > 1) {
          cart[i].itemCountValue -= 1;
          cart[i].price -= amount;
        } else {
          print('removed');
          cart.removeAt(i);
          break;
        }
      }
    }
    notifyListeners();
  }

  Future<void> removeFromCart(int i) async {
    double price = cart[i].price;
    double singlePrice = price / cart[i].itemCountValue;
    cart[i].price = cart[i].price - singlePrice;
    cart[i].itemCountValue -= 1;
    if (cart[i].itemCountValue == 0) {
      cart.removeAt(i);
    }
    notifyListeners();
  }

  Future<void> addFromCart(int i) async {
    double price = cart[i].price;
    double singlePrice = price / cart[i].itemCountValue;
    print('this is final values');
    print(cart[i].price);
    print(cart[i].itemCountValue);
    print(singlePrice);
    cart[i].price += singlePrice;
    cart[i].itemCountValue += 1;
    notifyListeners();
  }

  Future<void> sendVerification(String number) async {
    Map<String, dynamic> messageData = {
      'master_customer_name': 'akshay',
      'master_customer_email': 'akshay@gmail.com',
      'master_customer_mobile': '9623283777',
      'master_customer_business_id': '2',
    };
    final headers = {
      'content-type': 'application/json',
    };
    try {
      // var response = await http.post(
      //   'http://groceryapp.kanagalatech.com/API/createUser.php?master_customer_name=akshay&master_customer_email=akshay@gmail.com&master_customer_mobile=8291847232&master_customer_business_id=2',
      //   body: json.encode(messageData),
      //   encoding: Encoding.getByName('utf-8'),
      //   headers: headers,
      // );
      // print(response.statusCode);
    } catch (error) {
      print(error);
    }
  }

  void callNotifiers() {
    notifyListeners();
  }
}
