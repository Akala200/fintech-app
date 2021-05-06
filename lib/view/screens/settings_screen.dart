import 'dart:convert';
import 'package:euzzit/view/screens/Activate_account_settings.dart';
import 'package:euzzit/view/screens/Upgrade.dart';
import 'package:euzzit/view/screens/activation.dart';
import 'package:euzzit/view/screens/create_profile.dart';
import 'package:euzzit/view/screens/lifeline.dart';
import 'package:euzzit/view/screens/step/login.dart';
import 'package:euzzit/view/screens/update_account.dart';
import 'package:euzzit/view/screens/upgrade_account_settings.dart';
import 'package:euzzit/view/screens/upgrade_pin.dart';
import 'package:euzzit/view/screens/verify_pin_update.dart';
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

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                          SizedBox(width: 120.0,),
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ]),
                  ),
                ),

                SizedBox(height: 80.0,),

                Expanded(
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      children: [
                        // Buttons

                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateScreen()));
                          },
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Edit Profile',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                                Icon(Icons.arrow_right,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            height: 5, color: Colors.black),
                        ListTile(
                            onTap: () {},
                            title: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Bank Details',
                                      style: poppinsSemiBold.copyWith(
                                          color:
                                          ColorResources.COLOR_DIM_GRAY)),
                              Icon(Icons.arrow_right,
                                  color: Colors.black),
                                ],
                              ),
                            )),
                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {},
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Verification',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                                Icon(Icons.arrow_right,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VerifyPinUpdateScreen()));
                          },
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Update Transaction Pin',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                            Icon(Icons.arrow_right,
                                color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {},
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Security Settings',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                            Icon(Icons.arrow_right,
                                color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateProfileScreen()));
                          },
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Activate Merchant',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                            Icon(Icons.arrow_right,
                                color: Colors.black),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {

                          },
                          title: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Verify Email',
                                    style: poppinsSemiBold.copyWith(
                                        color: ColorResources.COLOR_DIM_GRAY)),
                                Icon(Icons.arrow_right,
                                    color: Colors.black),
                              ],
                            ),
                          ),
                        ),

                        Divider(
                            height: 5, color: Colors.black),

                        ListTile(
                          onTap: () {},
                          title: Text(Strings.SUPPORT,
                              style: poppinsSemiBold.copyWith(
                                  color: ColorResources.COLOR_DIM_GRAY)),
                        ),
                        Divider(
                            height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                        ListTile(
                          onTap: () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.remove('accessToken');
                            await Future.delayed(Duration(seconds: 2));
                            var token = prefs.getString('accessToken');
                            print(token);

                            Navigator.of(context).pushAndRemoveUntil(
                              // the new route
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginScreen(),
                              ),

                              // this function should return true when we're done removing routes
                              // but because we want to remove all other screens, we make it
                              // always return false
                                  (Route route) => false,
                            );
                          },
                          title: Text(Strings.LOG_OUT,
                              style: poppinsSemiBold.copyWith(
                                  color: ColorResources.COLOR_DIM_GRAY)),
                        ),
                        Divider(
                            height: 2, color: ColorResources.COLOR_WHITE_GRAY),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
