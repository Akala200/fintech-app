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
      body:  Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: 500.0,
              height: 340.0,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: Icon(Icons.chevron_left, size: 30, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Center(child: Text(title, style: montserratSemiBold.copyWith(color: Colors.white, fontSize: 18.0))),
                    ]),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                  height: 700.0,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(color: ColorResources.COLOR_WHITE, borderRadius: BorderRadius.circular(15)),
                  child: SingleChildScrollView(child: child),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
