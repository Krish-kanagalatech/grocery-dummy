import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocerycustomerdemo/Components/custom_appbar.dart';
import 'package:grocerycustomerdemo/Components/search_bar.dart';
import 'package:grocerycustomerdemo/Models/category.dart';
import 'package:grocerycustomerdemo/Models/items.dart';
import 'package:grocerycustomerdemo/Models/products.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Models/cart.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';

List<String> list = ['1 kg', '500 g', '250 g'];
// String choosedWeight = '1kg';

class ItemsPage extends StatefulWidget {
  String name;
  CachedNetworkImageProvider image;
  String categoryId;
  ItemsPage(
    this.name,
    this.image,
    this.categoryId,
  );
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  int itemCount = 0;
  int totalCount = 0;
  final List<Tab> tabs = <Tab>[
    Tab(text: 'ALL'),
    // Tab(text: 'FRUITS'),
    // Tab(text: 'HERBS'),
    // Tab(text: 'DAIRY'),
  ];

  int totalItems = 0;
  double totalprice = 0;

  @override
  void initState() {
    var subCatDetails =
        Provider.of<CategoryProvider>(context, listen: false).subCategory;
    List<Items> items =
        Provider.of<CategoryProvider>(context, listen: false).items;
    for (int i = 0; i < subCatDetails.length; i++) {
      if (widget.categoryId ==
          subCatDetails[i].masterCategoryId) if (subCatDetails[i]
              .masterSubCategoryStatus ==
          '0') {
        tabs.add(Tab(
          text: subCatDetails[i].masterSubCategoryName,
        ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<Products> products = provider.products;
    List<Items> items = provider.items;
    List<Products> productsForThisCategory = [];
    List<Items> itemsForThisCategory = [];
    List<Cart> cart = provider.cart;
    totalprice = 0.0;
    totalItems = 0;
    print('this is cart');
    print(cart);
    if (cart != []) {
      for (int i = 0; i < cart.length; i++) {
        totalprice += cart[i].price;
        totalItems += 1;
      }
    }
    for (int k = 0; k < products.length; k++) {
      if (products[k].masterCategoryId == widget.categoryId) {
        productsForThisCategory.add(products[k]);
      }
    }
    print('this is products');
    print(productsForThisCategory);
    print('thsi is items');
    print(items);

    print('second itesm');
    print(itemsForThisCategory);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(345.0),
          child: CustomAppBar(
            titleWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: kMainTextColor)),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     Icon(
                  //       Icons.location_on,
                  //       color: kIconColor,
                  //       size: 10,
                  //     ),
                  //     SizedBox(width: 10.0),
                  //     Text('6.4 km ',
                  //         style: Theme.of(context).textTheme.overline),
                  //     Text('|', style: Theme.of(context).textTheme.overline),
                  //     Text(' Union Market',
                  //         style: Theme.of(context).textTheme.overline),
                  //     Spacer(),
                  //     Icon(
                  //       Icons.access_time,
                  //       color: kIconColor,
                  //       size: 10,
                  //     ),
                  //     SizedBox(width: 10.0),
                  //     Text('20 MINS',
                  //         style: Theme.of(context).textTheme.overline),
                  //     SizedBox(width: 20.0),
                  //   ],
                  // ),
                  // Container(
                  //   height: 20,
                  //   child: Text("HELLO"),
                  // ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 223,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.image,
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 60,
                  //   child: CustomSearchBar(hint: 'Search item or store'),
                  // ),
                  TabBar(
                    tabs: tabs,
                    isScrollable: true,
                    labelColor: kMainColor,
                    unselectedLabelColor: kLightTextColor,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  Divider(
                    color: kCardBackgroundColor,
                    thickness: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((Tab tab) {
            itemsForThisCategory = [];
            if (tab.text != "ALL") {
              for (int i = 0; i < productsForThisCategory.length; i++) {
                for (int j = 0; j < items.length; j++) {
                  print('this is in loop');
                  print(productsForThisCategory[i].masterProductId);
                  print(items[j].masterProductId);
                  if (productsForThisCategory[i].masterProductId ==
                          items[j].masterProductId &&
                      productsForThisCategory[i].masterSubCategoryName ==
                          tab.text) {
                    itemsForThisCategory.add(items[j]);
                  }
                }
              }
            } else {
              for (int i = 0; i < productsForThisCategory.length; i++) {
                for (int j = 0; j < items.length; j++) {
                  print('this is in loop');
                  print(productsForThisCategory[i].masterProductId);
                  print(items[j].masterProductId);
                  if (productsForThisCategory[i].masterProductId ==
                      items[j].masterProductId) {
                    itemsForThisCategory.add(items[j]);
                  }
                }
              }
            }
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      for (int i = 0; i < itemsForThisCategory.length; i++)
                        itemsForThisCategory[i].masterProductStatus == '0'
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0,
                                              top: 30.0,
                                              right: 14.0),
                                          child: Image.asset(
                                            'images/veg/Vegetables/onion.png',
                                            height: 93.3,
                                            width: 93.3,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                itemsForThisCategory[i]
                                                    .masterProductName,
                                                style: bottomNavigationTextStyle
                                                    .copyWith(fontSize: 15)),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                    itemsForThisCategory[i]
                                                            .selectedKg
                                                            .startsWith('1')
                                                        ? '\u{20B9} ${itemsForThisCategory[i].masterProductDetailsMrp}'
                                                        : itemsForThisCategory[
                                                                    i]
                                                                .selectedKg
                                                                .startsWith('5')
                                                            ? '\u{20B9}' +
                                                                (int.parse(itemsForThisCategory[i]
                                                                            .masterProductDetailsMrp) /
                                                                        2)
                                                                    .toString()
                                                            : '\u{20B9}' +
                                                                (int.parse(itemsForThisCategory[i]
                                                                            .masterProductDetailsMrp) /
                                                                        4)
                                                                    .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    itemsForThisCategory[i]
                                                            .selectedKg
                                                            .startsWith('1')
                                                        ? '\u{20B9} ${itemsForThisCategory[i].masterProductDetailsSalePrice}'
                                                        : itemsForThisCategory[
                                                                    i]
                                                                .selectedKg
                                                                .startsWith('5')
                                                            ? '\u{20B9}' +
                                                                (int.parse(itemsForThisCategory[i]
                                                                            .masterProductDetailsSalePrice) /
                                                                        2)
                                                                    .toString()
                                                            : '\u{20B9}' +
                                                                (int.parse(itemsForThisCategory[i]
                                                                            .masterProductDetailsSalePrice) /
                                                                        4)
                                                                    .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return BottomSheetWidget(
                                                      itemsForThisCategory[i]
                                                          .masterProductName,
                                                      tab.text,
                                                      itemsForThisCategory[i]
                                                          .masterProductId,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 30.0,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  color: kCardBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      itemsForThisCategory[i]
                                                          .selectedKg,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: kMainColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 20.0,
                                      bottom: 14,
                                      child: itemsForThisCategory[i]
                                                  .itemCount ==
                                              0
                                          ? Container(
                                              height: 30.0,
                                              child: FlatButton(
                                                child: Text(
                                                  'Add',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                          color: kMainColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                textTheme:
                                                    ButtonTextTheme.accent,
                                                onPressed: () {
                                                  setState(() {
                                                    for (int k = 0;
                                                        k <
                                                            productsForThisCategory
                                                                .length;
                                                        k++) {
                                                      for (int j = 0;
                                                          j < items.length;
                                                          j++) {
                                                        if (productsForThisCategory[
                                                                    k]
                                                                .masterProductId ==
                                                            items[j]
                                                                .masterProductId) {
                                                          itemsForThisCategory[
                                                                      i]
                                                                  .itemCount =
                                                              int.parse(
                                                                  productsForThisCategory[
                                                                          k]
                                                                      .masterProductMinOrderQty);
                                                        }
                                                      }
                                                    }

                                                    provider.addCartInPage(
                                                      itemsForThisCategory[i]
                                                          .masterProductName,
                                                      itemsForThisCategory[i]
                                                          .masterProductId,
                                                      itemsForThisCategory[i]
                                                          .selectedKg,
                                                      itemsForThisCategory[i]
                                                              .selectedKg
                                                              .startsWith('1')
                                                          ? int.parse(itemsForThisCategory[
                                                                      i]
                                                                  .masterProductDetailsSalePrice)
                                                              .toDouble()
                                                          : itemsForThisCategory[
                                                                      i]
                                                                  .selectedKg
                                                                  .startsWith(
                                                                      '5')
                                                              ? int.parse(itemsForThisCategory[
                                                                          i]
                                                                      .masterProductDetailsSalePrice) /
                                                                  2
                                                              : int.parse(itemsForThisCategory[
                                                                          i]
                                                                      .masterProductDetailsSalePrice) /
                                                                  4,
                                                      itemsForThisCategory[i]
                                                          .itemCount,
                                                    );
                                                  });
                                                },
                                              ),
                                            )
                                          : Container(
                                              height: 30.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 11.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kMainColor),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        int minValue = 0;
                                                        for (int k = 0;
                                                            k <
                                                                productsForThisCategory
                                                                    .length;
                                                            k++) {
                                                          for (int j = 0;
                                                              j < items.length;
                                                              j++) {
                                                            if (productsForThisCategory[
                                                                        k]
                                                                    .masterProductId ==
                                                                items[j]
                                                                    .masterProductId) {
                                                              minValue = int.parse(
                                                                  productsForThisCategory[
                                                                          k]
                                                                      .masterProductMinOrderQty);
                                                            }
                                                          }
                                                        }
                                                        if (minValue ==
                                                            itemsForThisCategory[
                                                                    i]
                                                                .itemCount) {
                                                          itemsForThisCategory[
                                                                  i]
                                                              .itemCount = 0;
                                                        } else {
                                                          itemsForThisCategory[
                                                                  i]
                                                              .itemCount--;
                                                        }
                                                        provider.removeCart(
                                                          itemsForThisCategory[
                                                                  i]
                                                              .masterProductId,
                                                          itemsForThisCategory[
                                                                      i]
                                                                  .selectedKg
                                                                  .startsWith(
                                                                      '1')
                                                              ? int.parse(itemsForThisCategory[
                                                                          i]
                                                                      .masterProductDetailsSalePrice)
                                                                  .toDouble()
                                                              : itemsForThisCategory[
                                                                          i]
                                                                      .selectedKg
                                                                      .startsWith(
                                                                          '5')
                                                                  ? int.parse(itemsForThisCategory[
                                                                              i]
                                                                          .masterProductDetailsSalePrice) /
                                                                      2
                                                                  : int.parse(itemsForThisCategory[
                                                                              i]
                                                                          .masterProductDetailsSalePrice) /
                                                                      4,
                                                          itemsForThisCategory[
                                                                  i]
                                                              .selectedKg,
                                                        );
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: kMainColor,
                                                      size: 20.0,
                                                      //size: 23.3,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                      itemsForThisCategory[i]
                                                          .itemCount
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption),
                                                  SizedBox(width: 8.0),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        itemsForThisCategory[i]
                                                            .itemCount++;
                                                        provider.addCart(
                                                            itemsForThisCategory[i]
                                                                .masterProductName,
                                                            itemsForThisCategory[i]
                                                                .masterProductId,
                                                            itemsForThisCategory[i]
                                                                .selectedKg,
                                                            itemsForThisCategory[i]
                                                                    .selectedKg
                                                                    .startsWith(
                                                                        '1')
                                                                ? int.parse(itemsForThisCategory[i]
                                                                        .masterProductDetailsSalePrice)
                                                                    .toDouble()
                                                                : itemsForThisCategory[
                                                                            i]
                                                                        .selectedKg
                                                                        .startsWith(
                                                                            '5')
                                                                    ? int.parse(itemsForThisCategory[i]
                                                                            .masterProductDetailsSalePrice) /
                                                                        2
                                                                    : int.parse(
                                                                            itemsForThisCategory[i].masterProductDetailsSalePrice) /
                                                                        4);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: kMainColor,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'images/icons/ic_cart wt.png',
                          height: 19.0,
                          width: 18.3,
                        ),
                        SizedBox(width: 20.7),
                        Text(
                          '$totalItems items | ' +
                              '\u{20B9} ' +
                              totalprice.toString(),
                          style: bottomBarTextStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        FlatButton(
                          color: Colors.white,
                          onPressed: () =>
                              Navigator.pushNamed(context, PageRoutes.viewCart),
                          child: Text(
                            'View Cart',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: kMainColor, fontWeight: FontWeight.bold),
                          ),
                          textTheme: ButtonTextTheme.accent,
                          disabledColor: Colors.white,
                        ),
                      ],
                    ),
                    color: kMainColor,
                    height: 60.0,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  String name;
  String category;
  String id;
  BottomSheetWidget(this.name, this.category, this.id);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<Items> items = provider.items;
    var notifiers = Provider.of<CategoryProvider>(context);
    String selectedKg;
    for (int i = 0; i < items.length; i++) {
      if (items[i].masterProductId == id) {
        selectedKg = items[i].selectedKg;
      }
    }
    return ListView(
      children: <Widget>[
        Container(
          height: 80.7,
          color: kCardBackgroundColor,
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(name,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
            subtitle: Text(category,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 15)),
            trailing: FlatButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                notifiers.callNotifiers();
              },
              child: Text(
                'Add',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: kMainColor, fontWeight: FontWeight.bold),
              ),
              textTheme: ButtonTextTheme.accent,
              disabledColor: Colors.white,
            ),
          ),
        ),
        CheckboxGroup(
          labelStyle:
              Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
          labels: list,
          checked: [selectedKg],
          onChange: (isChecked, label, index) {
            print(label);
            print(index);
            print(isChecked);
            if (isChecked) {
              for (int i = 0; i < items.length; i++) {
                if (items[i].masterProductId == id) {
                  items[i].selectedKg = label;
                }
              }
            }
          },
        ),
      ],
    );
  }
}
