import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:grocerycustomerdemo/Maps/UI/location_page.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:grocerycustomerdemo/Models/location.dart';

class Address {
  final String icon;
  final String addressType;
  final String address;

  Address(this.icon, this.addressType, this.address);
}

class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kCardBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          title: Text(
            'Saved Addresses',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        body: SavedAddresses());
  }
}

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  List<Address> listOfAddressTypes = [
    Address('images/address/ic_homeblk.png', 'Home', 'New York, America'),
    Address('images/address/ic_officeblk.png', 'Office', 'Paris, France'),
    Address('images/address/ic_otherblk.png', 'Other', 'New Delhi, India'),
  ];
  //AddressBloc _addressBloc;
  @override
  void initState() {
    super.initState();
//    _addressBloc = BlocProvider.of<AddressBloc>(context);
//    _addressBloc.add(FetchAddressesEvent());
  }

  @override
  Widget build(BuildContext context) {
    var categoryprovider = Provider.of<CategoryProvider>(context);
    List<Location> location = categoryprovider.location;
    listOfAddressTypes = [];
    // for (int i = 0; i < location.length; i++) {
    //   listOfAddressTypes.insert(
    //       0,
    //       Address(
    //         'images/address/ic_homeblk.png',
    //         location[0].name + i.toString(),
    //         location[0].masterCustomerAddressline1 +
    //             ', ' +
    //             location[0].masterCustomerAddressline2 +
    //             ', ' +
    //             location[0].masterCustomerArea +
    //             ', ' +
    //             location[0].masterCustomerCity,
    //       ));
    // }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'address will be displayed here',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        // Expanded(
        //     child: ListView.builder(
        //         itemCount: listOfAddressTypes.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Column(
        //             children: <Widget>[
        //               Divider(
        //                 height: 6.0,
        //                 color: kCardBackgroundColor,
        //               ),
        //               Container(
        //                 padding: EdgeInsets.symmetric(
        //                     vertical: 20.0, horizontal: 6.0),
        //                 color: Colors.white,
        //                 child: ListTile(
        //                   leading: CircleAvatar(
        //                     radius: 30,
        //                     backgroundColor: kCardBackgroundColor,
        //                     child: ImageIcon(
        //                       AssetImage(listOfAddressTypes[index].icon),
        //                       color: kMainColor,
        //                       size: 28,
        //                     ),
        //                   ),
        //                   title: Padding(
        //                     padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
        //                     child: Text(
        //                       listOfAddressTypes[index].addressType,
        //                       style: listTitleTextStyle,
        //                     ),
        //                   ),
        //                   subtitle: Padding(
        //                     padding: EdgeInsets.only(left: 8.0),
        //                     child: Text(
        //                       listOfAddressTypes[index].address,
        //                       style: Theme.of(context)
        //                           .textTheme
        //                           .caption
        //                           .copyWith(fontSize: 11.7),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           );
        //         })),
        BottomBar(
          color: Colors.white,
          text: '+ Add new',
          textColor: kMainColor,
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    backgroundColor: kCardBackgroundColor,
                    content: Text(
                      'You want to choose address',
                    ),
                    title: Container(
                      child: Text('Select the method'),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationPage(true)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 77,
                          height: 30,
                          child: Center(
                            child: Text(
                              "CURRENT LOCATION",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: kMainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                            ),
                          ),
                        ),
                        textTheme: ButtonTextTheme.accent,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationPage(false)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 77,
                          height: 30,
                          child: Center(
                            child: Text(
                              "ENTER ADDRESS",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: kMainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                            ),
                          ),
                        ),
                        textTheme: ButtonTextTheme.accent,
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }
}
