import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/order_placed_map.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderMapPage(
              pageTitle: 'Vegetables & Fruits',
            ),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Sorry you have no orders',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            // Container(
            //   height: 51.0,
            //   padding: EdgeInsets.symmetric(vertical: 18.7, horizontal: 20.3),
            //   color: kCardBackgroundColor,
            //   child: Text(
            //     'ORDER(S) IN PROCESS',
            //     style: Theme.of(context).textTheme.headline6.copyWith(
            //         color: Color(0xff99a596),
            //         fontWeight: FontWeight.bold,
            //         letterSpacing: 0.67),
            //   ),
            // ),
            // Column(
            //   children: <Widget>[
            //     Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.only(left: 16.3),
            //           child: Image.asset(
            //             'images/maincategory/vegetables_fruitsact.png',
            //             height: 42.3,
            //             width: 33.7,
            //           ),
            //         ),
            //         Expanded(
            //           child: ListTile(
            //             title: Text(
            //               'Vegetables & Fruits',
            //               style: orderMapAppBarTextStyle.copyWith(
            //                   letterSpacing: 0.07),
            //             ),
            //             subtitle: Text(
            //               '20 June, 11:35am',
            //               style: Theme.of(context).textTheme.headline6.copyWith(
            //                   fontSize: 11.7,
            //                   letterSpacing: 0.06,
            //                   color: Color(0xffc1c1c1)),
            //             ),
            //             trailing: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 Text(
            //                   'Pickup Arranged',
            //                   style: orderMapAppBarTextStyle.copyWith(
            //                       color: kMainColor),
            //                 ),
            //                 SizedBox(height: 7.0),
            //                 Text(
            //                   '3 items | \$ 11.50',
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .headline6
            //                       .copyWith(
            //                           fontSize: 11.7,
            //                           letterSpacing: 0.06,
            //                           color: Color(0xffc1c1c1)),
            //                 )
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //     Divider(
            //       color: kCardBackgroundColor,
            //       thickness: 1.0,
            //     ),
            //     Row(
            //       children: <Widget>[
            //         Padding(
            //           padding: EdgeInsets.only(
            //               left: 36.0, bottom: 12.0, top: 12.0, right: 12.0),
            //           child: ImageIcon(
            //             AssetImage('images/custom/ic_droppointact.png'),
            //             size: 13.3,
            //             color: kMainColor,
            //           ),
            //         ),
            //         Text(
            //           'Home\t',
            //           style: orderMapAppBarTextStyle.copyWith(
            //               fontSize: 10.0, letterSpacing: 0.05),
            //         ),
            //         Text(
            //           '(Central Residency)',
            //           style: Theme.of(context)
            //               .textTheme
            //               .caption
            //               .copyWith(fontSize: 10.0, letterSpacing: 0.05),
            //         ),
            //       ],
            //     ),
            //     Divider(
            //       color: kCardBackgroundColor,
            //       thickness: 13.3,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
