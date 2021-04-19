import 'dart:convert';
import 'package:euzzit/view/screens/Activate_account_settings.dart';
import 'package:euzzit/view/screens/Upgrade.dart';
import 'package:euzzit/view/screens/activation.dart';
import 'package:euzzit/view/screens/lifeline.dart';
import 'package:euzzit/view/screens/settings_screen.dart';
import 'package:euzzit/view/screens/step/login.dart';
import 'package:euzzit/view/screens/update_account.dart';
import 'package:euzzit/view/screens/upgrade_account_settings.dart';
import 'package:euzzit/view/screens/upgrade_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:share/share.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String firstName;
  String lastName;
  String fullName;
  String accountStatus;
  var username;
  var phone;
  var email;
  var balance;
  var mainWalletBalance;
  var userStatus;
  var accountType;
  var accountUpgrade;
  var referralLink;

  _fetchListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/profile";
    var token = prefs.getString('accessToken');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var st = jsonDecode(response.body);
      var rawFavouriteList = await st["data"]["user"];
      await prefs.setString('referral_link', rawFavouriteList["referral_link"]);
      await prefs.setString('first_name', rawFavouriteList["first_name"]);
      await prefs.setString('last_name', rawFavouriteList["last_name"]);
      await prefs.setString('email', rawFavouriteList["email"]);
      await prefs.setString('phone', rawFavouriteList["phone"]);
      await prefs.setString(
          'mainWalletBalance', rawFavouriteList["user_wallets"][2]["balance"]);
      await prefs.setString('userStatus', rawFavouriteList["status"]);

      setState(() {
        firstName = rawFavouriteList["first_name"];
        lastName = rawFavouriteList["last_name"];
        email = rawFavouriteList["email"];
        phone = rawFavouriteList["phone"];
        username = rawFavouriteList["username"];
        accountStatus = rawFavouriteList["account_status"];
        fullName = firstName + '' + lastName;
        mainWalletBalance = rawFavouriteList["user_wallets"][2]["balance"];
        userStatus = rawFavouriteList["status"];
        accountType = rawFavouriteList["type"];
        accountUpgrade = rawFavouriteList["account_upgrade"];
        referralLink = rawFavouriteList["referral_link"];
//UpdateScreen
      });

      print(rawFavouriteList);
      return rawFavouriteList;
    }
  }

  void initState() {
    super.initState();
    _fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400.0,
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
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text(
                        'Profile',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                    ]),
                  ),
                ),

                // Upper Card
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.FONT_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(90, 1, 10, 10),
                      child: Row(
                        children: [
                          Text('$firstName', style: poppinsBold),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('$lastName', style: poppinsBold),
                        ],
                      ),
                    ),
                    Text('Wallet ID: $phone',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0)),
                    Text('$email',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0)),
                    Text('$accountType Account',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0)),
                    Divider(height: 15, color: ColorResources.COLOR_DIM_GRAY),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ActivationsScreen()));
                          },
                          child: Column(
                            children: [
                              Text('0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('Activations',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpgradeScreen()));
                          },
                          child: Column(
                            children: [
                              Text('0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('Upgrades',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LifeLineScreen()));
                          },
                          child: Column(
                            children: [
                              Text('0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('LifeLines',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            ],
                          ),
                        )
                      ],
                    )
                  ]),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 0, 15, 5),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.FONT_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PinUpdateScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.label,
                              color: Colors.deepPurple,
                              size: 40.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('Manage Merchant',
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 15.0)),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.blueGrey,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 0, 15, 5),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.FONT_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Earn ₦160 and 10,000 eUcoin everytime you invite a friend to sign up on eUzzit with your  wallet ID: $phone',
                          style: TextStyle(
                              color: Colors.deepPurple, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(height: 15, color: ColorResources.COLOR_DIM_GRAY),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            //ActivateSettingScreen1
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Share.share('$referralLink',
                                      subject: 'Euzzit Referral Link!');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.deepPurple,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('SHARE',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 15.0)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ActivateSettingScreen1()));
                              },
                              child: Text('Activate Account',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 15.0))),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.FONT_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Earn ₦800 and 100,000 eUcoin everytime an invited friend upgrades their account eUzzit with your  wallet ID: $phone',
                          style: TextStyle(
                              color: Colors.deepPurple, fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(height: 15, color: ColorResources.COLOR_DIM_GRAY),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            //ActivateSettingScreen1
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Share.share('$referralLink',
                                      subject: 'Euzzit Referral Link!');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.deepPurple,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('SHARE',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 15.0)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UpgradeSettingScreen1()));
                              },
                              child: Text('Upgrade Account',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 15.0))),
                        ],
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
}
