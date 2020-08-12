import 'package:grocerycustomerdemo/Components/entry_field.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Models/location.dart';
import 'package:grocerycustomerdemo/Models/time.dart';
import 'package:grocerycustomerdemo/Pages/payment_method.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:provider/provider.dart';
import 'package:grocerycustomerdemo/Models/cart.dart';
import 'package:grocerycustomerdemo/Models/coupon.dart';
import 'package:intl/intl.dart';
import 'package:grocerycustomerdemo/Models/tax.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';

List<DropdownMenuItem<String>> listDrop = [];

void loadData() {
  listDrop = [];
  listDrop.add(DropdownMenuItem(
    child: Text('1 kg'),
    value: 'A',
  ));
  listDrop.add(DropdownMenuItem(
    child: Text('500 g'),
    value: 'B',
  ));
  listDrop.add(DropdownMenuItem(
    child: Text('250 g'),
    value: 'C',
  ));
}

class ViewCart extends StatefulWidget {
  @override
  _ViewCartState createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  String value = 'Set Location';
  double totalAmount = 0;
  double serviceFee = 0;
  double amoutToPay = 0;
  double discount = 0;
  int selectedRadio = 0;
  bool couponApplied = false;
  bool showDescription = false;
  bool orderAccept = true;
  String couponString = '';
  String descriptionDetails = '';

  changeRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<String> listOfLocation = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<Location> location = provider.location;
    print('this is location');
    print(location);
    List<String> listOfLocation = ['Set Location'];
    for (int i = 0; i < location.length; i++) {
      listOfLocation.insert(0, location[i].name + i.toString());
    }

    List<Cart> cart = provider.cart;
    List<Coupon> coupon = provider.coupon;
    List<TimeSlots> timeSlots = provider.timeSlots;
    totalAmount = 0;
    for (int i = 0; i < cart.length; i++) {
      totalAmount += cart[i].price;
      print(cart[i].taxId);
      print('this is tax id');
    }
    amoutToPay = totalAmount + serviceFee - discount;
    // loadData();
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Confirm Order', style: Theme.of(context).textTheme.bodyText1),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              for (int i = 0; i < cart.length; i++)
                Column(
                  children: <Widget>[
                    Container(
                      child: cartOrderItemListTile(
                        context,
                        cart[i].name,
                        cart[i].price.toString(),
                        cart[i].itemCountValue,
                        () => provider.removeFromCart(i),
                        () => provider.addFromCart(i),
                        cart[i].quantity,
                      ),
                    ),
                    if (i < cart.length - 1)
                      Divider(
                        color: kCardBackgroundColor,
                        thickness: 1.0,
                      ),
                  ],
                ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 6.7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: EntryField(
                  hint: 'Any instruction? E.g Carry package carefully',
                  border: InputBorder.none,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(6),
                    height: 2,
                    width: 2,
                    child: Image.asset(
                      'images/custom/ic_instruction.png',
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
              couponApplied
                  ? Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: EntryField(
                            hint: 'Enter coupon code',
                            border: InputBorder.none,
                            onChanged: (str) {
                              couponString = str;
                              setState(() {
                                couponApplied = false;
                              });
                            },
                            // suffixIcon: IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(
                            //     Icons.check_box,
                            //   ),
                            //   color: kMainColor,
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment(1, 0),
                            child: GestureDetector(
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      couponApplied ? kMainColor : kitemColor,
                                ),
                                margin: EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Text(
                                    couponApplied ? "VERIFIED" : "VERIFY",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: EntryField(
                            hint: 'Enter coupon code',
                            border: InputBorder.none,
                            onChanged: (str) {
                              couponString = str;
                            },
                            // suffixIcon: IconButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       FocusScope.of(context).unfocus();
                            //     });
                            //     for (int i = 0; i < coupon.length; i++) {
                            //       if (coupon[i]
                            //           .masterCouponName
                            //           .contains(couponString)) {
                            //         setState(() {
                            //           couponApplied = true;
                            //           if (amoutToPay >=
                            //               int.parse(coupon[i]
                            //                       .masterCouponMinCartValue)
                            //                   .toDouble()) {
                            //             discount = int.parse(
                            //                     coupon[i].masterCouponValue) +
                            //                 0.0;
                            //           } else {
                            //             showDescription = true;
                            //             descriptionDetails = coupon[i]
                            //                     .masterCouponDescription +
                            //                 ' min amount ' +
                            //                 coupon[i].masterCouponMinCartValue;
                            //           }
                            //         });
                            //         break;
                            //       }
                            //     }
                            //   },
                            //   icon: Icon(
                            //     Icons.check_box_outline_blank,
                            //   ),
                            //   color: kMainColor,
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment(1, 0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                });
                                for (int i = 0; i < coupon.length; i++) {
                                  if (coupon[i]
                                      .masterCouponName
                                      .contains(couponString)) {
                                    setState(() {
                                      couponApplied = true;
                                      if (amoutToPay >=
                                          int.parse(coupon[i]
                                                  .masterCouponMinCartValue)
                                              .toDouble()) {
                                        discount = int.parse(
                                                coupon[i].masterCouponValue) +
                                            0.0;
                                      } else {
                                        showDescription = true;
                                        descriptionDetails = coupon[i]
                                                .masterCouponDescription +
                                            ' min amount ' +
                                            coupon[i].masterCouponMinCartValue;
                                      }
                                    });
                                    break;
                                  }
                                }
                              },
                              child: Container(
                                // padding: EdgeInsets.all(8),
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      couponApplied ? kMainColor : kitemColor,
                                ),
                                margin: EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Text(
                                    couponApplied ? "VERIFIED" : "VERIFY",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              showDescription
                  ? Container(
                      child: Center(
                        child: Text(
                          descriptionDetails,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text("Select delivery slot",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kDisabledColor)),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (int i = 0; i < timeSlots.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: i,
                                groupValue: selectedRadio,
                                activeColor: kMainColor,
                                onChanged: (val) {
                                  print('Radio $val');
                                  changeRadio(val);
                                  int hour = DateTime.now().hour;
                                  int minute = DateTime.now().minute;
                                  print(hour);
                                  var compare = timeSlots[i]
                                      .businessDeliverySlots
                                      .split('-');
                                  if (compare[0].contains('p')) {
                                    print(compare[0]
                                        .substring(0, compare[0].indexOf('p')));
                                    int hourGot = int.parse(compare[0]
                                        .substring(0, compare[0].indexOf('p')));
                                    hourGot != 12 ? hourGot += 12 : null;
                                    if (hour < hourGot && minute < 45) {
                                      orderAccept = true;
                                      setState(() {});
                                    } else {
                                      orderAccept = false;
                                      setState(() {});
                                    }
                                  } else {
                                    print(compare[0]
                                        .substring(0, compare[0].indexOf('a')));
                                    int hourGot = int.parse(compare[0]
                                        .substring(0, compare[0].indexOf('a')));
                                    if (hour < hourGot && minute < 45) {
                                      orderAccept = true;
                                      setState(() {});
                                    } else {
                                      orderAccept = false;
                                      setState(() {});
                                    }
                                  }
                                },
                              ),
                              Container(
                                child: Text(
                                  timeSlots[i].businessDeliverySlots,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: kMainTextColor),
                                ),
                              )
                            ],
                          ),
                        // Row(
                        //   children: <Widget>[
                        //     Radio(
                        //       value: 2,
                        //       groupValue: selectedRadio,
                        //       activeColor: kMainColor,
                        //       onChanged: (val) {
                        //         print('Radio $val');
                        //         changeRadio(val);
                        //         int hour = DateTime.now().hour;
                        //         int minute = DateTime.now().minute;
                        //         print(hour);
                        //         if (hour < 16 && minute < 45) {
                        //           orderAccept = true;
                        //           setState(() {});
                        //         } else {
                        //           orderAccept = false;
                        //           setState(() {});
                        //         }
                        //       },
                        //     ),
                        //     Container(
                        //       child: Text(
                        //         '4:00 Pm - 5:00 Pm',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headline6
                        //             .copyWith(color: kMainTextColor),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: <Widget>[
                        //     Radio(
                        //       value: 3,
                        //       groupValue: selectedRadio,
                        //       activeColor: kMainColor,
                        //       onChanged: (val) {
                        //         print('Radio $val');
                        //         changeRadio(val);
                        //         int hour = DateTime.now().hour;
                        //         int minute = DateTime.now().minute;
                        //         print(hour);
                        //         if (hour < 18 && minute < 45) {
                        //           orderAccept = true;
                        //           setState(() {});
                        //         } else {
                        //           orderAccept = false;
                        //           setState(() {});
                        //         }
                        //       },
                        //     ),
                        //     Container(
                        //       child: Text(
                        //         '6:00 Pm - 7:00 Pm',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headline6
                        //             .copyWith(color: kMainTextColor),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              orderAccept
                  ? Container()
                  : Container(
                      child: Center(
                        child: Text(
                          'the time is over it will be delivered tomorrow',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 6.7,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text('PAYMENT INFO',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: kDisabledColor)),
                color: Colors.white,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sub Total',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '\u{20B9} $totalAmount',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Discount',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '\u{20B9} $discount',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Service Fee',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        '\u{20B9} $serviceFee',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Divider(
                color: kCardBackgroundColor,
                thickness: 1.0,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Amount to Pay',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\u{20B9} $amoutToPay',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
              ),
              Container(
                height: 132.0,
                color: kCardBackgroundColor,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Color(0xffc4c8c1),
                            size: 13.3,
                          ),
                          SizedBox(
                            width: 11.0,
                          ),
                          Text('Deliver To',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: kDisabledColor,
                                      fontWeight: FontWeight.bold)),
                          Text(
                              value.contains('Set Location') ? ' -' : ' $value',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: kMainColor,
                                      fontWeight: FontWeight.bold)),
                          Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                child: Text('CHANGE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                width: 100,
                                margin: EdgeInsets.only(left: 5),
                                child: DropdownButton(
                                  value: value,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: kMainColor,
                                  ),
                                  iconSize: 10.0,
                                  elevation: 16,
                                  style: inputTextStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      value = newValue;
                                    });
                                  },
                                  items: listOfLocation
                                      .map<DropdownMenuItem<String>>(
                                          (String address) {
                                    return DropdownMenuItem<String>(
                                      value: address,
                                      child: Text(
                                        address,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      // Text(
                      //     '1024, Central Residency Hemilton Park, New York, USA',
                      //     style: Theme.of(context).textTheme.caption.copyWith(
                      //         fontSize: 11.7, color: Color(0xffb7b7b7)))
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Container(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: 20.0, right: 20.0, top: 13.0, bottom: 13.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.stretch,
                //       children: <Widget>[
                //         Row(
                //           children: <Widget>[
                //             Icon(
                //               Icons.location_on,
                //               color: Color(0xffc4c8c1),
                //               size: 13.3,
                //             ),
                //             SizedBox(
                //               width: 11.0,
                //             ),
                //             Text('Deliver To',
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .caption
                //                     .copyWith(
                //                         color: kDisabledColor,
                //                         fontWeight: FontWeight.bold)),
                //             Text(
                //                 value.contains('Set Location')
                //                     ? ' -'
                //                     : ' $value',
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .caption
                //                     .copyWith(
                //                         color: kMainColor,
                //                         fontWeight: FontWeight.bold)),
                //             Spacer(),
                //             Row(
                //               children: [
                //                 GestureDetector(
                //                   child: Text('CHANGE',
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .caption
                //                           .copyWith(
                //                               color: kMainColor,
                //                               fontWeight: FontWeight.bold)),
                //                 ),
                //                 Container(
                //                   width: 100,
                //                   margin: EdgeInsets.only(left: 5),
                //                   child: DropdownButton(
                //                     value: value,
                //                     icon: Icon(
                //                       Icons.keyboard_arrow_down,
                //                       color: kMainColor,
                //                     ),
                //                     iconSize: 10.0,
                //                     elevation: 16,
                //                     style: inputTextStyle.copyWith(
                //                         fontWeight: FontWeight.bold),
                //                     underline: Container(
                //                       height: 0,
                //                     ),
                //                     onChanged: (String newValue) {
                //                       setState(() {
                //                         value = newValue;
                //                       });
                //                     },
                //                     items: listOfLocation
                //                         .map<DropdownMenuItem<String>>(
                //                             (String address) {
                //                       return DropdownMenuItem<String>(
                //                         value: address,
                //                         child: Text(
                //                           address,
                //                           overflow: TextOverflow.ellipsis,
                //                           style: TextStyle(fontSize: 13),
                //                         ),
                //                       );
                //                     }).toList(),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //         SizedBox(
                //           height: 13.0,
                //         ),
                //         // Text(
                //         //     '1024, Central Residency Hemilton Park, New York, USA',
                //         //     style: Theme.of(context).textTheme.caption.copyWith(
                //         //         fontSize: 11.7, color: Color(0xffb7b7b7)))
                //       ],
                //     ),
                //   ),
                // ),
                BottomBar(
                  text: "Pay \u{20B9} "
                      "$amoutToPay",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(amoutToPay),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cartOrderItemListTile(
    BuildContext context,
    String title,
    String price,
    int itemCount,
    Function onPressedMinus,
    Function onPressedPlus,
    String quantity,
  ) {
    String selected;
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 7.0, top: 13.3),
            child: ListTile(
              // contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              leading: Container(
                child: Image.asset(
                  'images/veg/Vegetables/onion.png',
                  height: 93.3,
                  width: 93.3,
                ),
              ),
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: kMainTextColor),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 14.2),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 30.0,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: kCardBackgroundColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 16.7,
                              ),
                              iconEnabledColor: Colors.green,
                              value: selected,
                              items: listDrop,
                              hint: Text(
                                quantity,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selected = value;
                                });
                              }),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 30.0,
                        //width: 76.7,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: kMainColor),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: onPressedMinus,
                              child: Icon(
                                Icons.remove,
                                color: kMainColor,
                                size: 20.0,
                                //size: 23.3,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(itemCount.toString(),
                                style: Theme.of(context).textTheme.caption),
                            SizedBox(width: 8.0),
                            InkWell(
                              onTap: onPressedPlus,
                              child: Icon(
                                Icons.add,
                                color: kMainColor,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ))
      ],
    );
  }
}
