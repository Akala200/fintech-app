import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:euzzit/view/screens/transfer.dart';
import 'package:euzzit/view/screens/withdraw.dart';
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SavingAccountScreen extends StatefulWidget {
  @override
  _SavingAccountScreenState createState() => _SavingAccountScreenState();
}

class _SavingAccountScreenState extends State<SavingAccountScreen> {
  int bannerIndex = 0;
  var balance;

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
      balance = prefs.getString('mainWalletBalance');
    });
//accountStatus

  }

  _fetchListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/transactions/wallets";
    var token =  prefs.getString('accessToken');

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
    var st = jsonDecode(response.body);
    print(response.body);

    List rawFavouriteList = await st["data"][3]["history"];
    return rawFavouriteList;
    }
  }

  void initState() {
    super.initState();
    getFreshData();
    _fetchListItems();
  }

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
                            Text('Main Balance', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE, fontWeight: FontWeight.bold, fontSize: 15.0)),
                            Text('$balance' != null ? '$balance': '0', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE, fontWeight: FontWeight.bold, fontSize: 15.0)),
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
                            IconTitleButton(iconUrl: 'assets/Icon/add money.png', title: 'Fund Wallet',  widget: SendMoneyScreen1()),
                            SizedBox(width: 15),
                            IconTitleButton(iconUrl: 'assets/Icon/withdraw.png', title: 'Transfer', widget: TransferScreen1(),),
                            SizedBox(width: 15),
                            IconTitleButton(iconUrl: 'assets/Icon/add money.png', title: 'Withdraw',  widget: WithdrawScreen1()),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Wallet Transaction History',
                          style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_CHARCOAL),
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                     Container(
                       child: FutureBuilder(
                           future: _fetchListItems(),
                           // ignore: missing_return
                           builder: (context, AsyncSnapshot snapshot) {
                             if (!snapshot.hasData) {
                               return Center(child: CircularProgressIndicator());
                             } else {
                               Container(
                                   child: ListView.builder(
                                       itemCount: snapshot.data.length,
                                       scrollDirection: Axis.horizontal,
                                       itemBuilder: (BuildContext context, int index) {
                                         return Row(
                                           children: [
                                            Column(
                                              children: [
                                                Text('${snapshot.data[index].amount}', style: TextStyle(color: Colors.black, fontSize: 12.0),),
                                                Text('${snapshot.data[index].type}', style: TextStyle(color: Colors.black, fontSize: 12.0),)
                                              ],
                                            ),
                                             Column(
                                               children: [
                                                 Text('${snapshot.data[index].description}', style: TextStyle(color: Colors.black, fontSize: 12.0),),
                                                 Text('${new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(snapshot.data[index].created_at)}', style: TextStyle(color: Colors.black, fontSize: 12.0),)
                                               ],
                                             )
                                           ],
                                         );
                                       }));
                             }
                           }),
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

