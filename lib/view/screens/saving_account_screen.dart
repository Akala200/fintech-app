import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/goals_provider.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:euzzit/view/widgets/my_goals_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:euzzit/view/screens/pay_screen.dart';
import 'package:euzzit/view/screens/saving_account_screen.dart';
import 'package:euzzit/view/screens/cashback_screen.dart';
import 'package:euzzit/view/screens/charity_screen.dart';
import 'package:euzzit/view/screens/e_shopping_screen.dart';
import 'package:euzzit/view/screens/gift_screen.dart';
import 'package:euzzit/view/screens/request_screen.dart';
import 'package:euzzit/view/screens/send_money1_screen.dart';
import 'package:euzzit/view/screens/topup_screen.dart';

class SavingAccountScreen extends StatefulWidget {
  @override
  _SavingAccountScreenState createState() => _SavingAccountScreenState();
}

class _SavingAccountScreenState extends State<SavingAccountScreen> {
  int bannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: 'Wallet', color: ColorResources.COLOR_WHITE),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        height: 80,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorResources.COLOR_WHITE.withOpacity(.24)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Strings.BALANCE, style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE, fontWeight: FontWeight.bold, fontSize: 18.0)),
                            Text(Strings.DOLLER6500, style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE, fontWeight: FontWeight.bold, fontSize: 18.0)),
                          ],
                        ),
                      ),
                      SizedBox(height: 70),
                      SizedBox(height: 25),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        height: 88,
                        child: Row(
                          children: [
                            IconTitleButton(iconUrl: 'assets/Icon/add money.png', title: Strings.ADD_MONEY,  widget: SendMoneyScreen1()),
                            SizedBox(width: 15),
                            IconTitleButton(iconUrl: 'assets/Icon/withdraw.png', title: Strings.WITHDRAW),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Transaction History',
                          style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_CHARCOAL),
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                     Container(
                       child:Center(
                         child: Text(
                           'No Record',
                           style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_CHARCOAL),
                         ),
                       ),
                     )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _indicator() {
    List<Widget> indicator = [];
    for(int i=0; i < Provider.of<GoalsProvider>(context).getGoalsList().length; i++) {
      indicator.add(TabPageSelectorIndicator(
        backgroundColor: i == bannerIndex ? Colors.orange : ColorResources.COLOR_WHITE,
        borderColor: i == bannerIndex ? Colors.orange : ColorResources.COLOR_WHITE,
        size: 8,
      ));
    }
    return indicator;
  }
}

class IconTitleButton extends StatelessWidget {
  final String iconUrl;
  final String title;
  final Widget widget;
  IconTitleButton({@required this.iconUrl, @required this.widget, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(widget != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
          }
        },
        child: Container(
          width: 90,
          height: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorResources.COLOR_WHITE,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconUrl, width: 35, height: 25),
              SizedBox(height: 10),
              Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY)),
            ],
          ),
        ),
      ),
    );
  }
}

