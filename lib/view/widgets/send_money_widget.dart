import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/style.dart';

class SendMoneyWidget extends StatelessWidget {
  final String title;
  final Widget child;
  SendMoneyWidget({@required this.title, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Image.asset(
            'assets/Illustration/back-full.png',
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 30, color: ColorResources.COLOR_WHITE),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Center(child: Text(title, style: montserratSemiBold.copyWith(color: ColorResources.COLOR_WHITE))),
              ]),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 150),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(color: ColorResources.COLOR_WHITE, borderRadius: BorderRadius.circular(15)),
            child: child,
          ),
        ],
      ),
    );
  }
}
