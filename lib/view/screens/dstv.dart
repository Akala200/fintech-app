
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import 'buy_cabletv_dstv.dart';

class DSTVScreen1 extends StatefulWidget {

  @override
  _DSTVScreen1State createState() => _DSTVScreen1State();
}

class _DSTVScreen1State extends State<DSTVScreen1> {



  _fetchVerify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url1 = "http://api.airvendng.net/secured/seamless/verify/";

// then hash the string

  var myJson = jsonEncode({
    "details": {
      "ref": "",
      "type": "30",
      "account": "7021959296"
    }
  });
  var apiToken = 'CPL00BF6F1717A4A8D66AB8CEDB0F58DF3F0D4D2F761E02826BFF40815BFA12D500';
  var valueAdded = '$myJson$apiToken';
  var password = "smscafe3334\$";

  print(valueAdded);


    var bytes = utf8.encode(valueAdded); // data being hashed
    var digest = sha256.convert(bytes);
    print("Digest as hex string: $digest");

    final http.Response response = await http.post(
      url1,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'username': 'tomlove4all@gmail.co',
        'password': password,
        'hash': '$digest',

      },
      body: myJson,
    );
    var st = jsonDecode(response.body);
    print(st);
    if (response.statusCode == 200) {
      var st = jsonDecode(response.body);
      print(st);

    } else {
      var st = jsonDecode(response.body);
      print(response.body);
    }
  }



  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/services/cabletv/products?service_id=20";
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
      List rawFavouriteList = await st["data"]["products"];
      print(st["data"]["products"]);
      return rawFavouriteList;
    }
  }

  void initState() {
    super.initState();
    _fetchListItems();
    _fetchVerify();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
      body:  Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: 500.0,
              height: 340.0,
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomAppBar(title: 'DSTV Recharge', color: Colors.white),
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
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DSTV( amount:snapshot.data[index]["Amount"], product: snapshot.data[index]["name"],)));
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: ListTile(
                                                          title:  Text(snapshot.data[index]["name"],  style: TextStyle(color: Colors.deepPurple),),
                                                          subtitle: Text('${snapshot.data[index]["Amount"]}', style: TextStyle(color: Colors.deepPurple),),
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
        ],
      )
    );
  }
}
