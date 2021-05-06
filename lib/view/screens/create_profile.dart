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

class CreateProfileScreen extends StatefulWidget {

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  var name;

  var reg_no;

  var cac_reg_no;

  var category;

  var address;

  var email;

  var phone;

  var referrer;
  var _validate1;
  var _validate2;
  var _validate3;
  var _validate4;
  var _validate5;
  var _validate6;
  var _validate7;
  var _validate8;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _reg_noController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _cac_reg_noController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _referrerController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
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
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left, size: 30, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ]),
                    ),

                    Center(
                      child: Text(
                        'Activate Merchant',
                        style:TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            child: Row(
                              children: [

                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _nameController,
                                    onChanged:(value) async {
                                      name = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Business Name",
                                      errorText: _validate1 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText:   "Business Name",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _reg_noController,
                                    onChanged:(value) async {
                                      reg_no = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Business Registration Number",
                                      errorText: _validate2 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText:   "Business Registration Number",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _categoryController,
                                    onChanged:(value) async {
                                      category = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Category",
                                      errorText: _validate3 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText:    "Category",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
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
                                      hintText: "Business Email",
                                      errorText: _validate4 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText:  "Business Email",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
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
                                      hintText: "Business Number",
                                      errorText: _validate5 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText: "Business Number",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _addressController,
                                    onChanged:(value) async {
                                      address = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Business Address",
                                      errorText: _validate6 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText: "Business Address",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _cac_reg_noController,
                                    onChanged:(value) async {
                                      cac_reg_no = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "CAC Registration Number",
                                      errorText: _validate7 == true ? 'Value Can\'t Be Empty' : null,
                                      labelText: "CAC Registration Number",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _referrerController,
                                    onChanged:(value) async {
                                      referrer = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Referrer Code",
                                      labelText:"Referrer Code",
                                      labelStyle: TextStyle(color: Colors.deepPurple),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                            child: CustomButton(btnTxt: 'Activate Profile',onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var token =  prefs.getString('access_token');

                              if(_nameController.text.isEmpty){
                                setState(() {
                                  _nameController.text.isEmpty ? _validate1 = true : _validate1 = false;
                                });
                                Toast.show('Business name cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if ( _reg_noController.text.isEmpty) {
                                setState(() {
                                  _reg_noController.text.isEmpty ? _validate2 = true : _validate2 = false;
                                });
                                Toast.show('Business registration Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if (_categoryController.text.isEmpty){
                                setState(() {
                                  _categoryController.text.isEmpty ? _validate3 = true : _validate3 = false;
                                });
                                Toast.show('Business category cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if (_emailController.text.isEmpty){
                                setState(() {
                                  _emailController.text.isEmpty ? _validate4 = true : _validate4 = false;
                                });
                                Toast.show('Business email cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if (_phoneController.text.isEmpty){
                                setState(() {
                                  _phoneController.text.isEmpty ? _validate5 = true : _validate5 = false;
                                });
                                Toast.show('Business email cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if (_addressController.text.isEmpty){
                                setState(() {
                                  _addressController.text.isEmpty ? _validate6 = true : _validate6 = false;
                                });
                                Toast.show('Business address cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else if (_cac_reg_noController.text.isEmpty){
                                setState(() {
                                  _cac_reg_noController.text.isEmpty ? _validate7 = true : _validate7 = false;
                                });
                                Toast.show('Business CAC number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                              } else {
                                var url = "https://euzzitstaging.com.ng/api/v1/user/merchant/profile";
                                Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                                    overlayColor: Color(0x99E8EAF6));
                                final http.Response response = await http.post(
                                  url,
                                  headers: <String, String>{
                                    'Content-Type': 'application/json; charset=UTF-8',
                                    'Authorization': 'Bearer $token',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'name': name,
                                    'reg_no': reg_no,
                                    'email': email,
                                    'phone': phone,
                                    'category': category,
                                    'cac_reg_no': cac_reg_no,
                                    'referrer_code': referrer,
                                    'address': address
                                  }),
                                );
                                Loader.hide();
                                if (response.statusCode == 200) {
                                  var st = jsonDecode(response.body);
                                  print(st);
                                  var status = st["message"];
                                  var referral_link = st["data"]["referral_link"];
                                  await prefs.setString('name', name );
                                  await prefs.setString('reg_no', reg_no );
                                  await prefs.setString('email', email );
                                  await prefs.setString('phone', phone );
                                  await prefs.setString('referrer_code', referrer );
                                  await prefs.setString('address', address );
                                  await prefs.setString('category', category );
                                  print(status);
                                  Toast.show("status", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                                  Navigator.pop(context);
                                } else {
                                  var st = jsonDecode(response.body);
                                  print(st);
                                  var status = st["message"];
                                  print(response.body);
                                  print(token);
                                  Toast.show(status, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                                }
                              }
                            },),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
