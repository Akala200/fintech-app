import 'dart:convert';
import 'package:euzzit/view/screens/home_screen.dart';
import 'package:euzzit/view/screens/send_fund.dart';
import 'package:euzzit/view/screens/startup_Screen.dart';
import 'package:euzzit/view/screens/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/goals_provider.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class FinishTransactionScreen extends StatefulWidget {
  final  String amount;
  final String description;
  final String type;
  final String from;
  final String recipient;
  final String coinEarned;
  final String token;
  final String serial;




  FinishTransactionScreen({Key key,  this.amount, this.description,  this.from, this.type, this.recipient, this.coinEarned, this.token, this.serial }) : super(key: key);
  @override
  _FinishTransactionScreenState createState() => _FinishTransactionScreenState();
}

class _FinishTransactionScreenState extends State<FinishTransactionScreen> {
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
              height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
              Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Center(child: Text('Transaction Result', style: TextStyle(color: Colors.white, fontSize: 18.0))),
              ]),
            ),
                Expanded(
                  child: Column(
                    children: [

                      SizedBox(
                        height: 50.0,
                      ),

                      Container(
                        child: Center(child: Icon(Icons.check_circle_outline_sharp, size: 150.0, color: Colors.green,)),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        child: Center(
                            child:  Text('${widget.type}', style: TextStyle(fontSize: 18.0, color: Colors.green),),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0, top: 30.0, left: 35.0),
                            child: Text('${widget.description} of ₦${widget.amount} to ${widget.recipient} was successful', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only( top: 10.0, left: 35.0),
                            child: Row(
                              children: [
                                Expanded(child: Text('${widget.token != null ? 'Token: ${widget.token}' : ''}', style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only( top: 5.0, left: 35.0),
                            child: Row(
                              children: [
                                Expanded(child: Text('${widget.serial != null ? 'SN: ${widget.serial}' : ''}', style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        child: Center(child: Image.asset('assets/Icon/oin.png', width: 130.0, height: 130.0,)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Center(
                          child:  Text('You have earn ${widget.coinEarned != null ? widget.coinEarned : '0'} ZIT coin!', style: TextStyle(fontSize: 17.0, color: Colors.black),),
                        ),
                      ),

                      SizedBox(
                        height: 70.0,
                      ),
                      Container(
                          child: Center(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WalletStartupScreen()));
                              },
                              height: 50.0,
                              color: Colors.deepPurple,
                              child: Text('Finish Transaction', style: TextStyle(color: Colors.white),),
                            ),
                          )
                      ),
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
