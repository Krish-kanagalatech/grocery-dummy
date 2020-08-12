import 'package:grocerycustomerdemo/Components/custom_appbar.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class StoresPage extends StatelessWidget {
  String pageTitle;
  String bussinessId;

  StoresPage(this.pageTitle, this.bussinessId);

  int noOfStores = 0;

  @override
  Widget build(BuildContext context) {
    noOfStores = 0;
    final manufacturer = Provider.of<CategoryProvider>(context);
    for (int i = 0; i < manufacturer.manufacturer.length; i++) {
      if (manufacturer.manufacturer[i].manufacturerBusinessId == bussinessId) {
        noOfStores += 1;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(276.0),
        child: CustomAppBar(
          titleWidget: Text(
            pageTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          hint: 'Search item or store',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              '$noOfStores Stores found',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kHintColor),
            ),
          ),
          InkWell(
            child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 25.3),
                child: Column(
                  children: <Widget>[
                    for (int i = 0; i < manufacturer.manufacturer.length; i++)
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, PageRoutes.items,),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        "images/layer_1.png"), //delivoo logo
                                    height: 93.3,
                                    width: 93.3,
                                  ),
                                  SizedBox(width: 13.3),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          manufacturer
                                              .manufacturer[i].manufacturerName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(color: kMainTextColor)),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: kIconColor,
                                            size: 10,
                                          ),
                                          SizedBox(width: 10.0),
                                          Text('6.4 km ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: kLightTextColor,
                                                      fontSize: 10.0)),
                                          Text('|',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: kMainColor,
                                                      fontSize: 10.0)),
                                          Text(' Union Market',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: kLightTextColor,
                                                      fontSize: 10.0)),
                                        ],
                                      ),
                                      SizedBox(height: 10.3),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            color: kIconColor,
                                            size: 10,
                                          ),
                                          SizedBox(width: 10.0),
                                          Text('20 MINS',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      color: kLightTextColor,
                                                      fontSize: 10.0)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )),
          ),
//          ListTile(
//            leading: Image.asset('images/veg/Vegetables/onion.png'),
//            onTap: () => Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => OrderMapPage(
//                  pageTitle: pageTitle,
//                  pickupLatLng: LatLng(20.5937, 78.9629),
//                  dropLatLng: LatLng(20.5937, 78.9630),
//                ),
//              ),
//            ),
//          ),

//          ListView.builder(
//              itemCount: 1,
//              itemBuilder: (BuildContext context, int index) {
//                return ListTile(
//                  title: Text('Hello'),
//                  subtitle: Text('Bye'),
//                );
//              })
        ],
      ),
    );
  }
}
