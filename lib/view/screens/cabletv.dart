import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/buy_cabletv_dstv.dart';
import 'package:euzzit/view/screens/buy_electricity.dart';
import 'package:euzzit/view/screens/dstv.dart';
import 'package:euzzit/view/screens/gotv.dart';
import 'package:euzzit/view/screens/gotv_view.dart';
import 'package:euzzit/view/screens/startime_view.dart';
import 'package:euzzit/view/screens/startimes.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';

class cableTvScreen1 extends StatefulWidget {

  @override
  _cableTvScreen1State createState() => _cableTvScreen1State();
}

class _cableTvScreen1State extends State<cableTvScreen1> {


  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/services/electricity/providers";
    var token =  prefs.getString('accessToken');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomAppBar(title: 'CableTv Subscription', color: Colors.deepPurple),
                  Container(
                    width: double.infinity,
                    height: 100.0,
                    child:   GestureDetector(
                      onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => DSTVScreen1()));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const ListTile(
                                leading: CircleAvatar(
                                  radius: 42,
                                  backgroundImage: AssetImage('assets/Icon/dstv.png'),
                                ),
                                title: Text('DSTV', style: TextStyle(color: Colors.deepPurple)),
                                subtitle: Text('Cable payment', style: TextStyle(color: Colors.deepPurple)),
                              ),
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GOTVScreen1()));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const ListTile(
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/Icon/gotv.png'),
                                ),
                                title: Text('GOTV', style: TextStyle(color: Colors.deepPurple),),
                                subtitle: Text('Cable payment', style: TextStyle(color: Colors.deepPurple)),
                              ),
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
                        //Toast.show('This service is currently not available', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartimesScreen1()));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 43,
                                  backgroundImage: AssetImage('assets/Icon/startimes.png'),
                                ),
                                title:  Text('Startimes', style: TextStyle(color: Colors.deepPurple),),
                                subtitle: Text('Cable payment',  style: TextStyle(color: Colors.deepPurple)),
                              ),
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
