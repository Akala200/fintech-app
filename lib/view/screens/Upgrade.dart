import 'dart:convert';
import 'package:euzzit/view/screens/view_transaction.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/goals_provider.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class UpgradeScreen extends StatefulWidget {
  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  int bannerIndex = 0;
  var balance;
  var balanceExtra;
  var balanceExtraSlug;
  var mainBalance;
  var mainRealBalance;
  var inputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');


  void getFreshData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/profile";
    var token = prefs.getString('access_token');
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
      await prefs.setString('referral_link', referral_link);
      await prefs.setString('referral_link', referral_link);
      await prefs.setString('first_name', first_name);
      await prefs.setString('last_name', last_name);
      await prefs.setString('email', email);
      await prefs.setString('phone', phone);
      await prefs.setString('username', username);
      await prefs.setString('accountStatus', accountStatus);
      await prefs.setString('referalCode', referalCode);
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
      print(balanceExtra);
    }
    //mainWalletName
    setState(() {
      balance = prefs.getString('mainWalletBalance');
      balanceExtraSlug =  prefs.getString('extraWalletName');
      balanceExtra = prefs.getString('extraWalletBalance');
      mainBalance = prefs.getString('mainWalletName');
      mainRealBalance = prefs.getString('mainWalletBalance');
    });
//accountStatus  mainWalletBalance
  }

  _fetchListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/transactions/wallets";
    var token = prefs.getString('accessToken');

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
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: 500.0,
              height: 500.0,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                    title: 'Upgrade', color: Colors.white),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  width: 160,
                                  height: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorResources.COLOR_WHITE,
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('List Of Upgrade',
                                            style: TextStyle( fontSize: 23.0,
                                              color: Colors.deepPurple, )),
                                        SizedBox(height: 10.0,),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text('Below are the numbers of classic Account you have Upgraded to Premium Account',
                                              style: TextStyle( fontSize: 16.0,
                                                  color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Center(
                          child: Text('You have not Upgraded any account yet...!',
                              style: TextStyle( fontSize: 22.0,
                                color: Colors.deepPurple, )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _indicator() {
    List<Widget> indicator = [];
    for (int i = 0;
    i < Provider.of<GoalsProvider>(context).getGoalsList().length;
    i++) {
      indicator.add(TabPageSelectorIndicator(
        backgroundColor:
        i == bannerIndex ? Colors.orange : ColorResources.COLOR_WHITE,
        borderColor:
        i == bannerIndex ? Colors.orange : ColorResources.COLOR_WHITE,
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
  IconTitleButton(
      {@required this.iconUrl, @required this.widget, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (widget != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => widget));
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
              Text(title,
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: ColorResources.COLOR_DIM_GRAY)),
            ],
          ),
        ),
      ),
    );
  }
}
