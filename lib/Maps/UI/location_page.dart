import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Components/custom_appbar.dart';
import 'package:grocerycustomerdemo/Components/entry_field.dart';
import 'package:grocerycustomerdemo/Maps/Components/address_type_button.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

TextEditingController _addressController = TextEditingController();

class LocationPage extends StatelessWidget {
  bool fromLocation;
  LocationPage(this.fromLocation);
  @override
  Widget build(BuildContext context) {
    return SetLocation(fromLocation);
  }
}

class SetLocation extends StatefulWidget {
  bool fromLocation;
  SetLocation(this.fromLocation);
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  bool isCard = false;
  Position position;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng london = LatLng(51.5, -0.09);
  static LatLng paris = LatLng(48.8566, 2.3522);
  static LatLng dublin = LatLng(53.3498, -6.2603);

  MapController mapController;
  double rotation = 0.0;
  String addressName = '';
  String houseNumber = '';
  String street = '';
  String area = '';
  String city = '';

  TextEditingController addressController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  _getLocation() async {
    print('on location');
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    print('this is status');
    print(geolocationStatus);
    print(geolocationStatus.value);
    // if (geolocationStatus.value != 2) {
    if (widget.fromLocation) {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      mapController.move(LatLng(latitude, longitude), 15);
      // mapController.fitBounds(
      //     LatLngBounds(LatLng(19.0760, 72.8777), LatLng(latitude, longitude)));
      // });
      // setState(() async {
      distanceInMeters = await Geolocator().distanceBetween(
        19.0760,
        72.8777,
        latitude,
        longitude,
      );
      // });
      List<Placemark> placemark =
          await Geolocator().placemarkFromCoordinates(latitude, longitude);
      areaController.text = placemark[0].locality;
      houseNoController.text = placemark[0].name;
      streetController.text = placemark[0].subLocality;
      cityController.text = placemark[0].administrativeArea;
      area = placemark[0].locality;
      houseNumber = placemark[0].name;
      street = placemark[0].subLocality;
      city = placemark[0].administrativeArea;
      setState(() {});
    }
    // }
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getLocation();
  }

  // @override
  // void initState(){
  //   _getLocation();
  //   super.initState();
  // }

  double latitude = 19.0760;
  double longitude = 72.8777;
  double distanceInMeters = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: CustomAppBar(
//              boxShadow: BoxShadow(
//                color: Colors.grey.shade600,
//                offset: Offset(0.0, 2.0),
//                blurRadius: 5.0,
//              ),
//              color: Colors.white,
            titleWidget: Text(
              'Set delivery location',
              style: TextStyle(fontSize: 16.7),
            ),
            onTap: null,
            hint: 'Enter location',
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.0), child: Container())),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                            center: LatLng(latitude, longitude),
                            zoom: 15.0,
                            onTap: (latlang) async {
                              if (widget.fromLocation) {
                                setState(() {
                                  latitude = latlang.latitude;
                                  longitude = latlang.longitude;
                                  mapController.move(
                                      LatLng(latitude, longitude), 15);
                                  // mapController.fitBounds(LatLngBounds(
                                  //     LatLng(19.0760, 72.8777),
                                  //     LatLng(latitude, longitude)));
                                });
                                // setState(() async {
                                distanceInMeters =
                                    await Geolocator().distanceBetween(
                                  19.0760,
                                  72.8777,
                                  latitude,
                                  longitude,
                                );
                                // });
                                List<Placemark> placemark = await Geolocator()
                                    .placemarkFromCoordinates(
                                        latitude, longitude);
                                areaController.text = placemark[0].locality;
                                houseNoController.text = placemark[0].name;
                                streetController.text =
                                    placemark[0].subLocality;
                                cityController.text =
                                    placemark[0].administrativeArea;
                                area = placemark[0].locality;
                                houseNumber = placemark[0].name;
                                street = placemark[0].subLocality;
                                city = placemark[0].administrativeArea;
                                setState(() {});
                                print(distanceInMeters);
                              }
                            }),
                        layers: [
                          new TileLayerOptions(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c']),
                          MarkerLayerOptions(
                            markers: [
                              new Marker(
                                width: 36.0,
                                height: 36.0,
                                point: LatLng(latitude, longitude),
                                builder: (ctx) => new Container(
                                  child: Image.asset(
                                    'images/map_pin.png',
                                    height: 36,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (widget.fromLocation) {
                          print('on location');
                          GeolocationStatus geolocationStatus =
                              await Geolocator()
                                  .checkGeolocationPermissionStatus();
                          print('this is status');
                          print(geolocationStatus);
                          print(geolocationStatus.value);
                          position = await Geolocator().getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                          setState(() {
                            latitude = position.latitude;
                            longitude = position.longitude;
                            mapController.move(LatLng(latitude, longitude), 15);
                            // mapController.fitBounds(LatLngBounds(
                            // LatLng(19.0760, 72.8777),
                            // LatLng(latitude, longitude)));
                          });
                          // setState(() async {
                          distanceInMeters = await Geolocator().distanceBetween(
                            19.0760,
                            72.8777,
                            latitude,
                            longitude,
                          );
                          // });
                          List<Placemark> placemark = await Geolocator()
                              .placemarkFromCoordinates(latitude, longitude);
                          areaController.text = placemark[0].locality;
                          houseNoController.text = placemark[0].name;
                          streetController.text = placemark[0].subLocality;
                          cityController.text = placemark[0].administrativeArea;
                          area = placemark[0].locality;
                          houseNumber = placemark[0].name;
                          street = placemark[0].subLocality;
                          city = placemark[0].administrativeArea;
                          setState(() {});
                        }
                        //

                        //
                        //remove this one
                        // print(distanceInMeters);
                        // List<Placemark> placemark = await Geolocator()
                        //     .placemarkFromAddress(
                        //         "A/18,103, shantidham near royal collage, Miraroad east, Mumbai - 401107");
                        // latitude = placemark[0].position.latitude;
                        // longitude = placemark[0].position.longitude;
                        // mapController.move(LatLng(latitude, longitude), 12);
                        // distanceInMeters = await Geolocator().distanceBetween(
                        //   19.0760,
                        //   72.8777,
                        //   latitude,
                        //   longitude,
                        // );
                        // print(latitude);
                        // print(longitude);
                        // setState(() {});
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0, right: 15),
                          child: Icon(Icons.location_searching),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   child: Text(distanceInMeters.toString()),
            // ),
            SizedBox(
              height: 20,
            ),
            EntryField(
              hint: 'Flat Number / Landmark',
              controller: houseNoController,
              onChanged: (val) async {
                houseNumber = val;
                List<Placemark> placemark = await Geolocator()
                    .placemarkFromAddress(
                        "$houseNumber, $street, $area, $city");
                latitude = placemark[0].position.latitude;
                longitude = placemark[0].position.longitude;
                mapController.move(LatLng(latitude, longitude), 15);
                distanceInMeters = await Geolocator().distanceBetween(
                  19.0760,
                  72.8777,
                  latitude,
                  longitude,
                );
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            EntryField(
              hint: 'Street',
              controller: streetController,
              onChanged: (val) async {
                street = val;
                List<Placemark> placemark = await Geolocator()
                    .placemarkFromAddress(
                        "$houseNumber, $street, $area, $city");
                latitude = placemark[0].position.latitude;
                longitude = placemark[0].position.longitude;
                mapController.move(LatLng(latitude, longitude), 15);
                distanceInMeters = await Geolocator().distanceBetween(
                  19.0760,
                  72.8777,
                  latitude,
                  longitude,
                );
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            EntryField(
              hint: 'Area',
              controller: areaController,
              onChanged: (val) async {
                area = val;
                List<Placemark> placemark = await Geolocator()
                    .placemarkFromAddress(
                        "$houseNumber, $street, $area, $city");
                latitude = placemark[0].position.latitude;
                longitude = placemark[0].position.longitude;
                mapController.move(LatLng(latitude, longitude), 15);
                distanceInMeters = await Geolocator().distanceBetween(
                  19.0760,
                  72.8777,
                  latitude,
                  longitude,
                );
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            EntryField(
              hint: 'Town/City/Village Name',
              controller: cityController,
              onChanged: (val) async {
                city = val;
                List<Placemark> placemark = await Geolocator()
                    .placemarkFromAddress(
                        "$houseNumber, $street, $area, $city");
                latitude = placemark[0].position.latitude;
                longitude = placemark[0].position.longitude;
                mapController.move(LatLng(latitude, longitude), 15);
                distanceInMeters = await Geolocator().distanceBetween(
                  19.0760,
                  72.8777,
                  latitude,
                  longitude,
                );
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            isCard ? SaveAddressCard() : Container(),
            SizedBox(
              height: 20,
            ),
            BottomBar(
                text: "Continue",
                onTap: () {
                  // if (isCard == false) {
                  //   setState(() {
                  //     isCard = true;
                  //   });
                  // } else {
                  //   Navigator.popAndPushNamed(
                  //       context, PageRoutes.homeOrderAccountPage);
                  // }
                  FToast flutterToast;
                  flutterToast = FToast(context);
                  flutterToast.removeCustomToast();
                  flutterToast.removeQueuedCustomToasts();
                  flutterToast.showToast(
                      toastDuration: Duration(seconds: 2),
                      child: Container(
                        child: Text('This is demo app no adding of address'),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}

enum AddressType {
  Home,
  Office,
  Other,
}
AddressType selectedAddress = AddressType.Other;

class SaveAddressCard extends StatefulWidget {
  @override
  _SaveAddressCardState createState() => _SaveAddressCardState();
}

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: EntryField(
            controller: _addressController,
            hint: 'Address Title',
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        //   child: Text(
        //     'SAVE ADDRESS AS',
        //     style: Theme.of(context).textTheme.subtitle2,
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(bottom: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: <Widget>[
        //       AddressTypeButton(
        //         label: 'Home',
        //         image: 'images/address/ic_homeblk.png',
        //         onPressed: () {
        //           setState(() {
        //             selectedAddress = AddressType.Home;
        //           });
        //         },
        //         isSelected: selectedAddress == AddressType.Home,
        //       ),
        //       AddressTypeButton(
        //         label: 'Office',
        //         image: 'images/address/ic_officeblk.png',
        //         onPressed: () {
        //           setState(() {
        //             selectedAddress = AddressType.Office;
        //           });
        //         },
        //         isSelected: selectedAddress == AddressType.Office,
        //       ),
        //       AddressTypeButton(
        //         label: 'Other',
        //         image: 'images/address/ic_otherblk.png',
        //         onPressed: () {
        //           setState(() {
        //             selectedAddress = AddressType.Other;
        //           });
        //         },
        //         isSelected: selectedAddress == AddressType.Other,
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
