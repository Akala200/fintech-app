import 'package:alert/alert.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/home_screen.dart';
import 'package:euzzit/view/screens/startup_Screen.dart';
import 'package:euzzit/view/screens/step/forget_password.dart';
import 'package:euzzit/view/screens/step/step_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/step/step_two_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:toast/toast.dart';



class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();


  var username;

  var password;


  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                   'Login',
                    style: poppinsRegular.copyWith(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Text(
                    "Enter your mobile number, email or username to login",
                    textAlign: TextAlign.center,
                    style: montserratRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),

                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: _usernameController,
                          onChanged:(value) async {
                            username = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.person_rounded,color: Colors.deepPurple,),
//https://euzzitstaging.com.ng/api/v1/auth/register
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          obscureText: true,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          onChanged:(value) async {
                            password = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.lock,color: Colors.deepPurple,),

                    ],
                  ),
                ),
                SizedBox(height: 2.0,),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('', style: TextStyle(color: Colors.black, fontSize: 14.0),),
                      GestureDetector( onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResetScreen()));
                      },
                          child: Text('Forget password', style: TextStyle(color: Colors.black, fontSize: 14.0),)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: "Login",onTap: () async {
                    Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                        overlayColor: Color(0x99E8EAF6));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var url = "https://euzzitstaging.com.ng/api/v1/auth/login";
                    final http.Response response = await http.post(
                      url,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'email': username,
                        'password': password,
                      }),
                    );
                    Loader.hide();

                    if (response.statusCode == 200) {
                      var st = jsonDecode(response.body);
                      var referral_link = st["data"]["user"]["referral_link"];
                      var first_name = st["data"]["user"]["first_name"];
                      print(st["data"]["access_token"]);
                      print(first_name);
                      print(first_name);
                      print(first_name);
                      print(first_name);
                      var fullname = await prefs.setString('referral_link', referral_link );

                      var last_name = st["data"]["user"]["last_name"];
                      var email = st["data"]["user"]["email"];
                      var phone = st["data"]["user"]["phone"];
                      var username = st["data"]["user"]["username"];
                      var status = st["data"]["user"]["status"];
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

                      print(status);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WalletStartupScreen()));
                    } else {
                      Loader.hide();
                      var st = jsonDecode(response.body);
                      print(response.body);
                      var errMessage = st["message"];
                      Toast.show(errMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                    }

                  },),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StepOneScreen()));
                    },
                    child: Center(
                      child: Text(
                        "Do not have an account? Register", style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
