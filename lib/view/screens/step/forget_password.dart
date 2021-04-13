import 'package:alert/alert.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/step/reset_password.dart';
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


class ResetScreen extends StatefulWidget {

  @override
  _ResetScreenScreenState createState() => _ResetScreenScreenState();
}

class _ResetScreenScreenState extends State<ResetScreen> {
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
                  height: 200,
                ),
                Center(
                  child: Text(
                    'Reset Password',
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
                    "Enter you email to initiate reset password",
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
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          onChanged:(value) async {
                            username = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Email",
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

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt:"Reset Password",onTap: () async {
                    Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                        overlayColor: Color(0x99E8EAF6));
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var url = "https://euzzitstaging.com.ng/api/v1/auth/forgot_password";
                    final http.Response response = await http.post(
                      url,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'email': username,
                      }),
                    );
                    Loader.hide();
                    print(username);
                    if (response.statusCode == 200) {
                      print(response.body);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
                    } else if(response.statusCode == 404){
                       print(response.body);
                       Toast.show("Server Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);


                    } else {
                        print(response.body);
                        Toast.show("User does not exist", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      }

                  },),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
