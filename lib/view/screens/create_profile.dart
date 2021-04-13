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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, size: 30, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Create Profile',
                    style: poppinsRegular.copyWith(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 30,
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
                          controller: _nameController,
                          onChanged:(value) async {
                            name = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
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
                          keyboardType: TextInputType.name,
                          controller: _reg_noController,
                          onChanged:(value) async {
                            reg_no = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Reg Number",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
                          controller: _categoryController,
                          onChanged:(value) async {
                            category = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Category",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          onChanged:(value) async {
                            phone = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Phone Number",
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
                          keyboardType: TextInputType.text,
                          controller: _addressController,
                          onChanged:(value) async {
                            address = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Address",
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
                          keyboardType: TextInputType.text,
                          controller: _cac_reg_noController,
                          onChanged:(value) async {
                            cac_reg_no = value;
                          },
                          decoration: InputDecoration(
                            hintText: "CAC",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
                          controller: _referrerController,
                          onChanged:(value) async {
                            referrer = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Referrer Code",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: 'Create Profile',onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var token =  prefs.getString('access_token');

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
                      var status = st["status"];
                      var referral_link = st["data"]["referral_link"];
                      await prefs.setString('name', name );
                      await prefs.setString('reg_no', reg_no );
                      await prefs.setString('email', email );
                      await prefs.setString('phone', phone );
                      await prefs.setString('referrer_code', referrer );
                      await prefs.setString('address', address );
                      await prefs.setString('category', category );
                      print(status);
                      Toast.show("User already Exists", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                      Navigator.pop(context);
                    } else {
                      print(response.body);
                      print(token);
                      Toast.show("User already Exists", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                    }

                  },),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
