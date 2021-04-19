import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/jamb.dart';
import 'package:euzzit/view/screens/step/login.dart';
import 'package:euzzit/view/screens/waec.dart';
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

class EducationScreen extends StatefulWidget {

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {



  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/transactions/wallets";
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
      List rawFavouriteList = await st["data"][1]["history"];
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
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomAppBar(title: 'Education', color: Colors.deepPurple),
            SizedBox(height: 30.0,),
            Container(
              width: double.infinity,
              height: 100.0,
              child:   GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => JambScreen1()));
                },
                child: Card(
                  color: Colors.white,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/Icon/charity.png'), // no matter how big it is, it won't overflow
                ),
                        title: Text('UTME (JAMB)', style: TextStyle(color: Colors.deepPurple),),
                        subtitle: Text('PIN', style: TextStyle(color: Colors.deepPurple),),
                      ),
                    ],
                  ),
                ),
              ), ),
                SizedBox(height: 10.0,),

                Container(
                  width: double.infinity,
                  height: 100.0,
                  child:   GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WAECScreen1()));
                    },
                    child: Card(
                      color: Colors.white,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/Icon/shopping.png'), // no matter how big it is, it won't overflow
                            ),
                            title: Text('WAEC', style: TextStyle(color: Colors.deepPurple),),
                            subtitle: Text('PIN', style: TextStyle(color: Colors.deepPurple),),
                          ),
                        ],
                      ),
                    ),
                  ), )
              ],
            )

          ),
        ),
      ),
    );
  }
}
