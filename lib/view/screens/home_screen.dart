import 'package:euzzit/view/screens/merchants.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/promo_provider.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/pay_screen.dart';
import 'package:euzzit/view/screens/saving_account_screen.dart';
import 'package:euzzit/view/screens/cashback_screen.dart';
import 'package:euzzit/view/screens/charity_screen.dart';
import 'package:euzzit/view/screens/e_shopping_screen.dart';
import 'package:euzzit/view/screens/gift_screen.dart';
import 'package:euzzit/view/screens/request_screen.dart';
import 'package:euzzit/view/screens/send_money1_screen.dart';
import 'package:euzzit/view/screens/topup_screen.dart';
import 'package:euzzit/view/widgets/promo_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

String firstName;
String lastName;
String fullName;
String accountStatus;
var balance;


class euzzitHomeScreen extends StatefulWidget {
  @override
  _euzzitHomeScreenState createState() => _euzzitHomeScreenState();
}

class _euzzitHomeScreenState extends State<euzzitHomeScreen> {

  void getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    firstName =  prefs.getString('first_name');
    lastName =  prefs.getString('last_name');
    accountStatus =  prefs.getString('accountStatus');
    fullName = firstName + '' + lastName;
    print(firstName);
  });
//accountStatus

  }


  void getFreshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/profile";
   var token =  prefs.getString('access_token');
   print(token);
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var st = jsonDecode(response.body);
      var referral_link = st["data"]["user"]["referral_link"];
      var first_name = st["data"]["user"]["first_name"];
      print(first_name);
      print(first_name);
      print(first_name);
      print(first_name);
      print(first_name);
      var last_name = st["data"]["user"]["last_name"];
      var email = st["data"]["user"]["email"];
      var phone = st["data"]["user"]["phone"];
      var username = st["data"]["user"]["username"];
      var accountStatus = st["data"]["user"]["account_status"];
      var referalCode = st["data"]["user"]["referral_code"];
      var accessToken = st["data"]["access_token"];
      var mainWalletName = st["data"]["user"]["user_wallets"][2]["name"];
      var mainWalletSlug = st["data"]["user"]["user_wallets"][2]["slug"];
      var mainWalletBalance = st["data"]["user"]["user_wallets"][2]["balance"];
      var euzzitCoinName = st["data"]["user"]["user_wallets"][0]["name"];
      var euzzitCoinSlug = st["data"]["user"]["user_wallets"][0]["slug"];
      var euzzitCoinBalance = st["data"]["user"]["user_wallets"][0]["balance"];
      var extraWalletName = st["data"]["user"]["user_wallets"][1]["name"];
      var extraWalletSlug = st["data"]["user"]["user_wallets"][0]["slug"];
      var extraWalletBalance = st["data"]["user"]["user_wallets"][0]["balance"];
      await prefs.setString('referral_link', referral_link );
      await prefs.setString('referral_link', referral_link );
      await prefs.setString('first_name', first_name );
      await prefs.setString('last_name', last_name );
      await prefs.setString('email', email );
      await prefs.setString('phone', phone );
      await prefs.setString('username', username );
      await prefs.setString('accountStatus', accountStatus );
      await prefs.setString('referalCode', referalCode );
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('mainWalletName', mainWalletName);
      await prefs.setString('mainWalletSlug', mainWalletSlug);
      await prefs.setString('mainWalletBalance', mainWalletBalance);
      await prefs.setString('euzzitCoinName', euzzitCoinName);
      await prefs.setString('euzzitCoinSlug', euzzitCoinSlug);
      await prefs.setString('euzzitCoinBalance', euzzitCoinBalance);
      await prefs.setString('extraWalletName', extraWalletName);
      await prefs.setString('extraWalletSlug', extraWalletSlug);
      await prefs.setString('extraWalletBalance', extraWalletBalance);
    }
    setState(() {
      firstName =  prefs.getString('first_name');
      lastName =  prefs.getString('last_name');
      accountStatus =  prefs.getString('accountStatus');
      fullName = firstName + '' + lastName;
      balance = prefs.getString('mainWalletBalance');
      print(firstName);
    });
//accountStatus

  }
  void initState() {
    super.initState();
    getData();
    getFreshData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 7,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/Illustration/Untitled-1.png',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Strings.euzzit, style: poppinsBold.copyWith(fontSize: 25, color: ColorResources.COLOR_WHITE)),
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          Icon(Icons.notifications, size: 30, color: ColorResources.COLOR_WHITE),
                          Positioned(
                            right: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.COLOR_DARK_ORCHID.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: ColorResources.COLOR_WHITE,
                                child: Text(Strings.TWO, style: TextStyle(fontSize: 8)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/person1.png',
                                width: Dimensions.PROFILE_WIDTH,
                                height: Dimensions.PROFILE_HEIGHT,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text( '$firstName' != null ? '$firstName': 'Null', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE)),
                                      SizedBox(width: 10.0,),
                                      Text('$lastName' != null ? '$lastName': 'Null', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE)),
                                    ],
                                  ),
                                  Text('$accountStatus' != null ? '$accountStatus': 'Null', style: poppinsRegular.copyWith(color: ColorResources.COLOR_VERY_LIGHT_GRAY)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 180,
                        margin: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 20,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 19, right: 22, bottom: 11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Main Balance", style: poppinsRegular.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                                  Text('$balance' != null ? '$balance': '0', style: poppinsRegular.copyWith(color: ColorResources.COLOR_DARK_ORCHID)),
                                ],
                              ),
                            ),
                            Container(height: 2, width: double.infinity, color: ColorResources.COLOR_WHITE_GRAY),
                            SizedBox(height: 10),
                            Container(
                                padding: EdgeInsets.only(left: 20, top: 19, right: 22),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavingAccountScreen()));
                                      },
                                      child: IconTitleColumnButton(iconUrl: 'assets/Icon/wallet.png', title: 'My Wallet'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MerchantScreen()));
                                      },
                                      child: IconTitleColumnButton(iconUrl: 'assets/Icon/team.png', title: 'Merchants'),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpScreen()));
                                      },
                                      child: IconTitleColumnButton(iconUrl: 'assets/Icon/oin.png',  title: 'My Coin'),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1, right: 1, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            IconTitleRowButton(
                              widget: CharityScreen(),
                              iconUrl: 'assets/Icon/money.png',
                              title: 'Send Money',
                            ),
                            IconTitleRowButton(
                              widget: CharityScreen(),
                              iconUrl: 'assets/Icon/wallet2.png',
                              title: 'Fund Wallet',
                            ),
                            IconTitleRowButton(
                              widget: EShoppingScreen(),
                              iconUrl: 'assets/Icon/education1.png',
                              title: 'Education',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1, right: 1, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleRowButton(
                              widget: PayScreen(),
                              iconUrl: 'assets/Icon/loan1.png',
                              title:  'Access Loan',
                            ),
                            IconTitleRowButton(
                              widget: EShoppingScreen(),
                              iconUrl: 'assets/Icon/topup1.png',
                              title: 'Top up',
                            ),
                            IconTitleRowButton(
                              iconUrl: 'assets/Icon/scan.png',
                              title: 'Scan2Pay',
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Text(Strings.PROMO, style: poppinsSemiBold),
                      ),
                      Container(
                        height: 85,
                        padding: EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: Provider.of<PromoProvider>(context).getPromoList().length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return PromoWidget(Provider.of<PromoProvider>(context).getPromoList()[index]);
                            },
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IconTitleClumnButton extends StatelessWidget {
  final String iconUrl;
  final String title;
  IconTitleClumnButton({@required this.iconUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 51,
          height: 51,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: ColorResources.COLOR_GHOST_WHITE, borderRadius: BorderRadius.circular(44)),
          child: Image.asset(iconUrl, fit: BoxFit.scaleDown),
        ),
        Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_CHARCOAL)),
      ],
    );
  }
}


class IconTitleColumnButton extends StatelessWidget {
  final String iconUrl;
  final String title;
  IconTitleColumnButton({@required this.iconUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 71,
          height: 62,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: ColorResources.COLOR_GHOST_WHITE, borderRadius: BorderRadius.circular(3)),
          child: Image.asset(iconUrl, fit: BoxFit.scaleDown),
        ),
        Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_CHARCOAL)),
      ],
    );
  }
}

class IconTitleRowButton extends StatelessWidget {
  final Widget widget;
  final String iconUrl;
  final String title;
  IconTitleRowButton({this.widget, @required this.iconUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(widget != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
          }
        },
        child: Column(
          children: [
            Container(
              width: 51,
              height: 51,
              child: Image.asset(iconUrl),
            ),
            SizedBox(width: 10),
            Text(title, style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY)),
          ],
        ),
      ),
    );
  }
}

