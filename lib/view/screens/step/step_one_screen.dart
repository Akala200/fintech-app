import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/step/login.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/step/step_two_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:euzzit/view/widgets/edittext/custom_text_field.dart';
import 'package:bs_overlay_loader/bs_overlay_loader.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';

class StepOneScreen extends StatefulWidget {

  @override
  _StepOneScreenState createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _formKey = GlobalKey<FormState>();

  var first_name;

  var last_name;

  var email;

  var phone;

  var username;

  var password;

  var password_confirm;

  var _validate;

  var _validated;

  var _validates;

  var _validateds;

  var _validatess;

  var _validatedss;


  Color err_firstname = Colors.deepPurple;
  Color err_lastname = Colors.deepPurple;
  Color err_email = Colors.deepPurple;
  Color err_phone = Colors.deepPurple;
  Color err_username = Colors.deepPurple;
  Color err_password = Colors.deepPurple;




  final TextEditingController _first_nameController = TextEditingController();

  final TextEditingController _last_nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _password_confirmController = TextEditingController();

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
                  height: 50,
                ),
                Center(
                  child: Text(
                    Strings.REGISTRATION,
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
                    Strings.ENTER_YOUR_MOBILE,
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
                          keyboardType: TextInputType.name,
                          controller: _first_nameController,
                          onChanged:(value) async {
                            first_name = value;
                          },
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: _validate == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.person,color: err_firstname),
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
                          keyboardType: TextInputType.name,
                          controller: _last_nameController,
                          onChanged:(value) async {
                            last_name = value;

                          },
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: _validated == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.person,color: err_lastname),

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
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          onChanged:(value) async {
                            email = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: _validateds == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.email,color: err_email,),
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
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          onChanged:(value) async {
                            phone = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Phone Number",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: _validatedss == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.phone,color: err_phone,),
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
                          keyboardType: TextInputType.text,
                          controller: _usernameController,
                          onChanged:(value) async {
                            username = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorText: _validates == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.person_rounded,color: err_username,),
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
                            errorText: _validatess == true ? 'Value Can\'t Be Empty' : null,
                          ),
                        ),
                      ),
                      Icon(Icons.lock,color: err_password,),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: Strings.CONTINUE,onTap: () async {

                    var connectivityResult = await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {


                      if(_first_nameController.text.isEmpty){
                        _first_nameController.text.isEmpty ? _validate = true : _validate = false;
                        setState(() {
                          _first_nameController.text.isEmpty ?  err_firstname = Colors.red : Colors.green;
                        });
                        Toast.show('first name cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else if ( _last_nameController.text.isEmpty) {
                        _last_nameController.text.isEmpty ? _validated = true : _validate = false;
                        setState(() {
                          _last_nameController.text.isEmpty ?  err_lastname = Colors.red :  Colors.green;
                        });
                        Toast.show('last name cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else if ( _emailController.text.isEmpty) {
                        _emailController.text.isEmpty ? _validateds = true : _validate = false;
                        setState(() {
                          _emailController.text.isEmpty ?  err_email = Colors.red :  Colors.green;
                        });
                        Toast.show('Email cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else if ( _phoneController.text.isEmpty) {
                        _phoneController.text.isEmpty ? _validatedss = true : _validate = false;
                        setState(() {
                          _phoneController.text.isEmpty ?  err_phone = Colors.red :  Colors.green;
                        });
                        Toast.show('Phone Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else if ( _usernameController.text.isEmpty) {
                        _usernameController.text.isEmpty ? _validates = true : _validate = false;
                        setState(() {
                          _usernameController.text.isEmpty ?  err_username = Colors.red :  Colors.green;
                        });
                        Toast.show('Username cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else if ( _passwordController.text.isEmpty) {
                        _passwordController.text.isEmpty ? _validatess = true : _validate = false;
                        setState(() {
                          _passwordController.text.isEmpty ?  err_password = Colors.red :  Colors.green;
                        });
                        Toast.show('password cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      } else {

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var url = "https://euzzitstaging.com.ng/api/v1/auth/register";
                      Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                          overlayColor: Color(0x99E8EAF6));
                      final http.Response response = await http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, String>{
                          'first_name': first_name,
                          'last_name': last_name,
                          'email': email,
                          'phone': phone,
                          'username': username,
                          'password': password,
                          'password_confirmation': password
                        }),
                      );
                      Loader.hide();
                      print(response.body);
                      if (response.statusCode == 200) {
                        var st = jsonDecode(response.body);
                        print(st);
                        var status = st["status"];
                        var referral_link = st["data"]["referral_link"];
                        await prefs.setString('firstName', first_name );
                        await prefs.setString('lastName', last_name );
                        await prefs.setString('email', email );
                        await prefs.setString('phone', phone );
                        await prefs.setString('referral_link', referral_link );
                        await prefs.setString('referral_link', referral_link );
                        print(status);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StepTwoScreen()));
                      } else {
                        Loader.hide();
                        var st = jsonDecode(response.body);
                        var message = st["message"];
                        Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      }
                      }

                    } else {
                      Toast.show('You are not connected to the internet', context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red);
                    }
                    },),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Center(
                      child: Text(
                        "Already have an account? Login", style: TextStyle(color: Colors.black),
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