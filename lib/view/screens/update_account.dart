import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
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

class UpdateScreen extends StatefulWidget {

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  var first_name;

  var last_name;

  var email;

  var phone;

  var username;

  var gender;
  var _myActivity;
  var _validate;
  var _validated;
  var  _validates;
  var  _validatess;
  var  _validateds;


  List data = [
    {
      "name": "Male",
      "value": "MALE"
    },
    {
      "name": "Female",
      "value": "FEMALE"
    }
  ];


  final TextEditingController _first_nameController = TextEditingController();

  final TextEditingController _last_nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _gender = TextEditingController();



  _fetchListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/profile";
    var token =  prefs.getString('accessToken');
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
      await prefs.setString('referral_link', rawFavouriteList["referral_link"] );
      await prefs.setString('first_name', rawFavouriteList["first_name"] );
      await prefs.setString('last_name', rawFavouriteList["last_name"] );
      await prefs.setString('email', rawFavouriteList["email"] );
      await prefs.setString('phone', rawFavouriteList["phone"] );
      await prefs.setString('mainWalletBalance', rawFavouriteList["user_wallets"][2]["balance"]);
      await prefs.setString('userStatus', rawFavouriteList["status"] );



      setState(() {
        first_name = rawFavouriteList["first_name"];
        last_name = rawFavouriteList["last_name"];
        email =rawFavouriteList["email"];
        phone =  rawFavouriteList["phone"];
        username = rawFavouriteList["username"];
        gender = rawFavouriteList["gender"];
        print(username);

        _first_nameController.text = first_name;
        _last_nameController.text = last_name;
        _emailController.text = email;
        _phoneController.text = phone;
        _usernameController.text = username;
        _gender.text = gender;

      });
      return rawFavouriteList;
    }
  }

  void initState() {
    super.initState();
    _fetchListItems();
  }

  void dispose(){
    _first_nameController.dispose();
    _last_nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _gender.dispose();

    super.dispose();
  }

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
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, size: 40, color: Colors.deepPurple),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ]),
            ),
                SizedBox(
                  height: 30,
                ),
                Center(child: Text('Update User Profile', style: montserratSemiBold.copyWith(color: Colors.deepPurple))),
                SizedBox(
                  height: 40,
                ),
                Container(
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
                            labelText: "First Name",
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
                          controller: _last_nameController,
                          onChanged:(value) async {
                            last_name = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            labelText: "Last Name",
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
                            hintText: "Email",
                            labelText: "Email",
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
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropDownFormField(
                        titleText: 'Select Gender',
                        value: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        dataSource: data,
                        textField: 'name',
                        valueField: 'value',
                      ),
                    ),
//https://euzzitstaging.com.ng/api/v1/auth/register
                  ],
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
                            hintText: "Phone Number",
                            labelText:  "Phone Number",
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
                          controller: _usernameController,
                          onChanged:(value) async {
                            username = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Username",
                            labelText:   "Username",
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
                  height: 70,
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: 'Update Account',onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var token =  prefs.getString('accessToken');

                    var url = "https://euzzitstaging.com.ng/api/v1/user/update_profile";
                    Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                        overlayColor: Color(0x99E8EAF6));

                    print(email);
                    final http.Response response = await http.put(
                      url,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization': 'Bearer $token',
                      },
                      body: jsonEncode(<String, String>{
                        'first_name': first_name,
                        'last_name': last_name,
                        'email': email,
                        'phone': phone,
                        'username': username,
                        'gender': gender,
                      }),
                    );
                    Loader.hide();
                    print(response.body);
                    if (response.statusCode == 200) {
                      var st = jsonDecode(response.body);
                      var message = st["message"];


                      Toast.show("User updated successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                      Navigator.of(context).pop();
                    } else {
                      var st = jsonDecode(response.body);
                      var message = st["message"];
                      Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                    }

                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
