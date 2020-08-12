import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:grocerycustomerdemo/Models/items.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

List<String> list = ['1 kg', '500 g', '250 g'];

class CustomSearchBar extends StatefulWidget {
  final String hint;
  final Function onTap;
  final Color color;
  final BoxShadow boxShadow;

  CustomSearchBar({
    this.hint,
    this.onTap,
    this.color,
    this.boxShadow,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<Items> items = provider.items;
    List<Items> itemsForThisCategory = [];
    // List<Items> items = [];
    for (int i = 0; i < items.length; i++) {
      if (items[i]
          .masterProductName
          .toLowerCase()
          .contains(searchString.toLowerCase())) {
        itemsForThisCategory.add(items[i]);
      }
    }
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20.0, left: 20),
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
          decoration: BoxDecoration(
            boxShadow: [
              widget.boxShadow ?? BoxShadow(color: kCardBackgroundColor),
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: widget.color ?? kCardBackgroundColor,
          ),
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchString = val;
              });
            },
            textCapitalization: TextCapitalization.sentences,
            cursorColor: kMainColor,
            decoration: InputDecoration(
              icon: ImageIcon(
                AssetImage('images/icons/ic_search.png'),
                color: Colors.black,
                size: 16,
              ),
              hintText: widget.hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kHintColor),
              border: InputBorder.none,
            ),
            onTap: widget.onTap,
          ),
        ),
        for (int i = 0; i < itemsForThisCategory.length; i++)
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 30.0, right: 14.0),
                      child: Image.asset(
                        'images/veg/Vegetables/onion.png',
                        height: 93.3,
                        width: 93.3,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(itemsForThisCategory[i].masterProductName,
                            style: bottomNavigationTextStyle.copyWith(
                                fontSize: 15)),
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
                                    : itemsForThisCategory[i]
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
                                    decoration: TextDecoration.lineThrough)),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                itemsForThisCategory[i]
                                        .selectedKg
                                        .startsWith('1')
                                    ? '\u{20B9} ${itemsForThisCategory[i].masterProductDetailsSalePrice}'
                                    : itemsForThisCategory[i]
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
                                  itemsForThisCategory[i].masterProductName,
                                  '',
                                  itemsForThisCategory[i].masterProductId,
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30.0,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: kCardBackgroundColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  itemsForThisCategory[i].selectedKg,
                                  style: Theme.of(context).textTheme.caption,
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
                  child: itemsForThisCategory[i].itemCount == 0
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
                                      fontWeight: FontWeight.bold),
                            ),
                            textTheme: ButtonTextTheme.accent,
                            onPressed: () {
                              setState(() {
                                itemsForThisCategory[i].itemCount++;

                                provider.addCart(
                                  itemsForThisCategory[i].masterProductName,
                                  itemsForThisCategory[i].masterProductId,
                                  itemsForThisCategory[i].selectedKg,
                                  itemsForThisCategory[i]
                                          .selectedKg
                                          .startsWith('1')
                                      ? int.parse(itemsForThisCategory[i]
                                              .masterProductDetailsSalePrice)
                                          .toDouble()
                                      : itemsForThisCategory[i]
                                              .selectedKg
                                              .startsWith('5')
                                          ? int.parse(itemsForThisCategory[i]
                                                  .masterProductDetailsSalePrice) /
                                              2
                                          : int.parse(itemsForThisCategory[i]
                                                  .masterProductDetailsSalePrice) /
                                              4,
                                );
                              });
                            },
                          ),
                        )
                      : Container(
                          height: 30.0,
                          padding: EdgeInsets.symmetric(horizontal: 11.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: kMainColor),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    itemsForThisCategory[i].itemCount--;
                                    provider.removeCart(
                                      itemsForThisCategory[i].masterProductId,
                                      itemsForThisCategory[i]
                                              .selectedKg
                                              .startsWith('1')
                                          ? int.parse(itemsForThisCategory[i]
                                                  .masterProductDetailsSalePrice)
                                              .toDouble()
                                          : itemsForThisCategory[i]
                                                  .selectedKg
                                                  .startsWith('5')
                                              ? int.parse(itemsForThisCategory[
                                                          i]
                                                      .masterProductDetailsSalePrice) /
                                                  2
                                              : int.parse(itemsForThisCategory[
                                                          i]
                                                      .masterProductDetailsSalePrice) /
                                                  4,
                                      itemsForThisCategory[i].selectedKg,
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
                              Text(itemsForThisCategory[i].itemCount.toString(),
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(width: 8.0),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    itemsForThisCategory[i].itemCount++;
                                    provider.addCart(
                                      itemsForThisCategory[i].masterProductName,
                                      itemsForThisCategory[i].masterProductId,
                                      itemsForThisCategory[i].selectedKg,
                                      itemsForThisCategory[i]
                                              .selectedKg
                                              .startsWith('1')
                                          ? int.parse(itemsForThisCategory[i]
                                                  .masterProductDetailsSalePrice)
                                              .toDouble()
                                          : itemsForThisCategory[i]
                                                  .selectedKg
                                                  .startsWith('5')
                                              ? int.parse(itemsForThisCategory[
                                                          i]
                                                      .masterProductDetailsSalePrice) /
                                                  2
                                              : int.parse(itemsForThisCategory[
                                                          i]
                                                      .masterProductDetailsSalePrice) /
                                                  4,
                                    );
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
          ),
      ],
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
