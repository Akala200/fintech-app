import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:euzzit/view/screens/company_profile.dart';
import 'package:euzzit/view/screens/create_profile.dart';
import 'package:euzzit/view/screens/service.dart';
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

class MerchantScreen extends StatefulWidget {
  @override
  _MerchantScreenState createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  int bannerIndex = 0;
  var balance;
  var walletMain;

  void getFreshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/profile";
    var token =  prefs.getString('access_token');
    print(token);
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var st = jsonDecode(response.body);
      var referral_link = st["data"]["user"]["referral_link"];
      var first_name = st["data"]["user"]["first_name"];
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
      var extraWalletSlug = st["data"]["user"]["user_wallets"][1]["slug"];
      var extraWalletBalance = st["data"]["user"]["user_wallets"][1]["balance"];
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
      balance = prefs.getString('extraWalletBalance');
      walletMain = prefs.getString('extraWalletName');
    });
//accountStatus

  }

  _fetchListItems<List>() async {
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


    if (response.statusCode == 200) {
      var st = jsonDecode(response.body);
      List rawFavouriteList = await st["data"][1]["history"];
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
                            Text('$walletMain', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE, fontWeight: FontWeight.bold, fontSize: 15.0)),
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
                            IconTitleButton(iconUrl: 'assets/Icon/withdraw.png', title: 'Create Profile', widget: CreateProfileScreen()),
                            SizedBox(width: 15),
                            IconTitleButton(iconUrl: 'assets/Icon/add money.png', title: 'Create Service',  widget: ServiceScreen1()),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Wallet History',
                          style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_CHARCOAL),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(height: 15),
                      Container(
                        child: FutureBuilder<dynamic>(
                            future: _fetchListItems(),
                            // ignore: missing_return
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }else if (snapshot.hasError || snapshot.data.length == 0 ) {
                                return Container(
                                  child: Center(child: Text('No Data Available', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),)),
                                );
                              } else {
                              return  Container(
                                  width: double.infinity,
                                  height: 500.0,
                                  child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (BuildContext context, int index) {
                                          return  Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                            padding: EdgeInsets.only(left: 17, bottom: 6, top: 23, right: 10),
                                            decoration: BoxDecoration(color: ColorResources.COLOR_WHITE, borderRadius: BorderRadius.circular(10)),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                       'Description:  ${snapshot.data[index]["description"]}',
                                                        style:
                                                        montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                                                      ),
                                                      SizedBox(height: 13.0,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            snapshot.data[index]["amount"],
                                                            style: poppinsSemiBold.copyWith(
                                                                fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_ROYAL_BLUE),
                                                          ),
                                                          Text(
                                                            snapshot.data[index]["type"],
                                                            style: poppinsSemiBold.copyWith(
                                                                fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_ROYAL_BLUE),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
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

