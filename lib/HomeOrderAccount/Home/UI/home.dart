import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocerycustomerdemo/Components/card_content.dart';
import 'package:grocerycustomerdemo/Components/custom_appbar.dart';
import 'package:grocerycustomerdemo/Components/imageSlider.dart';
import 'package:grocerycustomerdemo/Components/reusable_card.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/Stores/stores.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/custom_delivery.dart';
import 'package:grocerycustomerdemo/Models/category.dart';
import 'package:grocerycustomerdemo/Models/location.dart';
import 'package:grocerycustomerdemo/Pages/items.dart';
import 'package:grocerycustomerdemo/Maps/UI/location_page.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String value = 'Set Location';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var categoryProvider = Provider.of<CategoryProvider>(context);
    if (categoryProvider.init) {
      categoryProvider.fetchAndSetCategories();
    }
    if (categoryProvider.initSlider) {
      categoryProvider.fetchAndSetSlider();
    }
    if (categoryProvider.initManufacturer) {
      categoryProvider.fetchAndSetManufacturer();
    }
    if (categoryProvider.initsubCategory) {
      categoryProvider.fetchAndSetSubCategory();
    }
    if (categoryProvider.initItems) {
      categoryProvider.fetchAndSetItems();
    }
    if (categoryProvider.initProduct) {
      categoryProvider.fetchAndSetProducts();
    }
    if (categoryProvider.initLocation) {
      categoryProvider.fetchAndSetLocation();
    }
    if (categoryProvider.initOrders) {
      categoryProvider.fetchAndSetOrders();
    }
    if (categoryProvider.initCoupon) {
      categoryProvider.fetchAndSetCoupon();
    }
    if (categoryProvider.initTimeSlots) {
      categoryProvider.fetchAndSetTimeSlots();
    }
    super.didChangeDependencies();
  }

  var categoryprovider;

  List<String> listOfLocation = ['Set Location'];

  Future<void> _pullRefresh() async {
    print('this is on refresh');
    var categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.fetchAndSetCategories();
    categoryProvider.fetchAndSetSlider();
    categoryProvider.fetchAndSetManufacturer();
    categoryProvider.fetchAndSetSubCategory();
    categoryProvider.fetchAndSetItems();
    categoryProvider.fetchAndSetProducts();
    categoryProvider.fetchAndSetLocation();
    categoryProvider.fetchAndSetOrders();
    categoryProvider.fetchAndSetCoupon();
    categoryProvider.fetchAndSetTimeSlots();
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  void _showDialog() {
    show = false;
    Future.delayed(
        Duration.zero,
        () => showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                backgroundColor: kCardBackgroundColor,
                content: Text(
                  'This is just a demo app to see how app looks like. No orders will be places. If you want app on your brand or shop name call us at +91-9182469569',
                ),
                title: Container(
                  child: Text('Select the method'),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textTheme: ButtonTextTheme.accent,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 77,
                      height: 30,
                      child: Center(
                          child: Text(
                        "OK",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                      )),
                    ),
                  ),
                ],
              );
            }));
  }

  bool show = true;

  @override
  Widget build(BuildContext context) {
    show == true ? _showDialog() : null;
    categoryprovider = Provider.of<CategoryProvider>(context);
    List<Location> location = categoryprovider.location;
    print('this is location');
    print(location);
    List<String> listOfLocation = ['Set Location'];
    for (int i = 0; i < location.length; i++) {
      listOfLocation.insert(0, location[i].name + i.toString());
    }
    // setState(() {});
    // value = listOfLocation[0];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.location_on,
              color: kitemColor,
            ),
          ),
          titleWidget: DropdownButton(
            value: value,
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: kMainColor,
            ),
            iconSize: 24.0,
            elevation: 16,
            style: inputTextStyle.copyWith(fontWeight: FontWeight.bold),
            underline: Container(
              height: 0,
            ),
            onChanged: (String newValue) {
              setState(() {
                value = newValue;
              });
              if (value == 'Set Location')
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
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
                            textTheme: ButtonTextTheme.accent,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 77,
                              height: 30,
                              child: Center(
                                  child: Text(
                                "CURRENT LOCATION",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: kMainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                              )),
                            ),
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
                            textTheme: ButtonTextTheme.accent,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 77,
                              height: 30,
                              child: Center(
                                  child: Text(
                                "ENTER ADDRESS",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: kMainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                              )),
                            ),
                          ),
                        ],
                      );
                    });
            },
            items:
                listOfLocation.map<DropdownMenuItem<String>>((String address) {
              return DropdownMenuItem<String>(
                value: address,
                child: Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0), child: Container()),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: IconButton(
                icon: ImageIcon(
                  AssetImage('images/icons/ic_cart blk.png'),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, PageRoutes.viewCart),
              ),
            ),
          ],
          hint: 'Search item or store',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView(
          children: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Column(
                children: <Widget>[ImageSlider()],
              ),
            ),
            //               CustomSearchBar(hint: 'Search item or store'),
            // Padding(
            //   padding: EdgeInsets.only(top: 16.0, left: 24.0),
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         "Got Delivered",
            //         style: Theme.of(context).textTheme.bodyText1,
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Text(
            //         "everything you need",
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyText1
            //             .copyWith(fontWeight: FontWeight.normal),
            //       ),
            //     ],
            //   ),
            // ),
            buildGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildGrid() {
    List<Category> category = categoryprovider.category;
    List<Category> displayedCategory = [];
    for (int i = 0; i < category.length; i++) {
      if (category[i].categoryStatus == '0') {
        displayedCategory.add(category[i]);
      }
    }
    // setState(() {});
    print('before date');
    print(category.length);
    return Container(
      // margin: EdgeInsets.all(20.0),
      child: GridView.builder(
        // crossAxisCount: 2,
        // crossAxisSpacing: 20.0,
        // mainAxisSpacing: 20.0,
        itemCount: displayedCategory.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            displayedCategory[index].categoryStatus == '0'
                ? Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    child: ReusableCard(
                      cardChild: CardContent(
                        image: CachedNetworkImageProvider(
                            displayedCategory[index].categoryIcon),
                        text: displayedCategory[index].categoryName,
                      ),
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemsPage(
                            displayedCategory[index].categoryName,
                            CachedNetworkImageProvider(
                                displayedCategory[index].categoryImage),
                            displayedCategory[index].categoryId,
                          ),
                        ),
                      ),
                      // ),)
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => StoresPage(category[index].categoryName,category[index].categoryBusinessId),),
                      // ),
                    ),
                  )
                : Container(),
        // children: <Widget>[
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image:
        //           AssetImage('images/maincategory/vegetables_fruitsact.png'),
        //       text: 'VEGETABLES\n& FRUITS',
        //     ),
        //     onPress: () => Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => StoresPage('Vegetables & Fruits')),
        //     ),
        //   ),
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image: AssetImage('images/maincategory/food_mealsact.png'),
        //       text: 'FOOD\n& MEALS',
        //     ),
        //     onPress: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => StoresPage('Food & Meals'))),
        //   ),
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image: AssetImage('images/maincategory/meat_fishact.png'),
        //       text: 'MEAT\n& FISH',
        //     ),
        //     onPress: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => StoresPage('Meat & Fish'))),
        //   ),
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image:
        //           AssetImage('images/maincategory/pharma_medicinesact.png'),
        //       text: 'PHARMA\nMEDICINES',
        //     ),
        //     onPress: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => StoresPage('Pharma Medicines'))),
        //   ),
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image: AssetImage('images/maincategory/pet_suppliesact.png'),
        //       text: 'PET\nSUPPLIES',
        //     ),
        //     onPress: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => StoresPage('Pet Supplies'))),
        //   ),
        //   ReusableCard(
        //     cardChild: CardContent(
        //       image: AssetImage('images/maincategory/custom_deliveryact.png'),
        //       text: 'CUSTOM\nDELIVERY',
        //     ),
        //     onPress: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 CustomDeliveryPage('Custom Delivery'))),
        //   ),
        // ],
      ),
    );
  }
}
