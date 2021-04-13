import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/step/forget_password.dart';
import 'package:euzzit/view/screens/step/login.dart';
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



class ResetPasswordScreen extends StatefulWidget {

  @override
  _ResetPasswordScreenScreenState createState() => _ResetPasswordScreenScreenState();
}

class _ResetPasswordScreenScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();


  var username;

  var password;
  var confirmPassword;


  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _password_confirmationController = TextEditingController();



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
                    'Set New Password',
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
                    "Enter activation code and new password",
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
                          keyboardType: TextInputType.number,
                          controller: _usernameController,
                          onChanged:(value) async {
                            username = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Code",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
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
                            hintText: "New Password",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.lock,color: Colors.deepPurple,),

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
                          controller: _password_confirmationController,
                          onChanged:(value) async {
                            confirmPassword = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.lock,color: Colors.deepPurple,),

                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: "Set Password",onTap: () async {
                    Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                        overlayColor: Color(0x99E8EAF6));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var url = "https://euzzitstaging.com.ng/api/v1/auth/forgot_password/reset";

                    if(password == confirmPassword){
                      final http.Response response = await http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'token': username,
                          'password': password,
                          'password_confirmation': password,
                        }),
                      );
                      Loader.hide();

                      if (response.statusCode == 200) {
                        var st = jsonDecode(response.body);
                        print(response.body);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                      } else {
                        var st = jsonDecode(response.body);
                        print(response.body);
                        var errMessage = st["message"];
                        Toast.show(errMessage, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                      }
                    } else {
                      Loader.hide();
                      Toast.show('Password does not match', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                    }
                  },),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
