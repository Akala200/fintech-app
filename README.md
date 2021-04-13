# euzzit

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.













import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shamrock/constance/constance.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  final String fromAddress;
  final String toAddress;
  final String price;
  final String status;
  final Color statusColor;
  final String time;


  const CardWidget({Key key, this.fromAddress, this.toAddress, this.price, this.status, this.statusColor, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              children: <Widget>[
                Image.asset(
                  ConstanceData.startPin,
                  height: 32,
                  width: 32,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  fromAddress,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).textTheme.title.color,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 22,
            ),
            child: Container(
              height: 16,
              width: 2,
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: <Widget>[
                Image.asset(
                  ConstanceData.endPin,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  toAddress,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).textTheme.title.color,
                    fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 8, bottom: 8),
            child: Row(
              children: <Widget>[
                Text(
                  '₦',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Theme.of(context).textTheme.title.color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Theme.of(context).textTheme.title.color,
                         fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: statusColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: statusColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
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
}
