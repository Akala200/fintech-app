
import 'package:euzzit/view/screens/buy_data.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataScreen1 extends StatefulWidget {
  @override
  _DataScreen11State createState() => _DataScreen11State();
}

class _DataScreen11State extends State<DataScreen1> {



  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/services/databundle/providers";
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
                  CustomAppBar(title: 'Data Purchase', color: Colors.deepPurple),
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
                                                  onTap: () async {
                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    await prefs.setInt('service_id',  snapshot.data[index]["id"] );
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DATAPHONE(service_id: snapshot.data[index]["id"], company: snapshot.data[index]["name"], )));
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child:  ListTile(
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
