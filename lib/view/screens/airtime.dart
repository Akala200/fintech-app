import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/buy_airtime.dart';
import 'package:euzzit/view/screens/buy_electricity.dart';
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

class AirtimeScreen1 extends StatefulWidget {

  @override
  _AirtimeScreen1State createState() => _AirtimeScreen1State();
}

class _AirtimeScreen1State extends State<AirtimeScreen1> {



  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/services/airtime/providers";
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
      List rawFavouriteList = await st["data"];
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
                  CustomAppBar(title: 'Airtime Purchase', color: Colors.deepPurple),
                  SizedBox(height: 30.0,),
                  Container(
                    width: double.infinity,
                    child:   FutureBuilder<dynamic>(
                        future: _fetchListItems(),
                        // ignore: missing_return
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }else if (snapshot.hasError || snapshot.data.length == 0 ) {
                            return Container(
                              child: Center(child: Text('No Data Available', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),)),
                            );
                          } else {
                            return  Container(
                                width: double.infinity,
                                height: 700.0,
                                child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, int index) {
                                      return    Column(
                                        children: [
                                          Card(
                                            color: Colors.white,

                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyAirtime(service_id: snapshot.data[index]["id"], company: snapshot.data[index]["name"], )));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 40,
                                                        backgroundImage: AssetImage('${(snapshot.data[index]["category_type"] == 'mtn')? 'assets/Icon/mtn.png':(snapshot.data[index]["category_type"] == 'glo')? 'assets/Icon/glo.png':(snapshot.data[index]["category_type"] == '9mobile')? 'assets/Icon/9mobile.png': (snapshot.data[index]["category_type"] == 'airtel')? 'assets/Icon/airtel.png': (snapshot.data[index]["category_type"] == 'smile')? 'assets/Icon/smile.png':'assets/Icon/smile.jpg'}'),
                                                      ),
                                                      title:  Text(snapshot.data[index]["name"],  style: TextStyle(color: Colors.deepPurple),),
                                                      subtitle: Text(snapshot.data[index]["category_type"],  style: TextStyle(color: Colors.deepPurple),),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );


                                    }));
                          }
                        }), ),
                ],
              )

          ),
        ),
      ),
    );
  }
}
