import 'dart:convert';

import 'package:euzzit/view/screens/view_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/cashFlow_Screen.dart';
import 'package:euzzit/view/screens/investment_screen.dart';
import 'package:euzzit/view/screens/loan_screen.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'insurance_screen.dart';

class InsightScreen extends StatefulWidget {
  @override
  _InsightScreenState createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  var inputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');



  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/transactions";
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Center(child: Text('Transaction History', style: TextStyle(fontSize: 18.0, color: Colors.white),)),
                  ]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: 10),
                        FutureBuilder<dynamic>(
                            future: _fetchListItems(),
                            // ignore: missing_return
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }else if (snapshot.hasError || snapshot.data.length == 0 ) {
                                return Container(
                                  child: Center(child: Text('No Data Available', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),)),
                                  //snapshot.data[index]["name"]
                                );
                              } else {
                                return  Container(
                                    width: double.infinity,
                                    height: 700.0,
                                    child:     SingleChildScrollView(
                                      child: ListView.builder(
                                          itemCount: 10,
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                bottom: 10),
                                            padding: EdgeInsets.only(
                                                left: 17,
                                                bottom: 6,
                                                top: 23,
                                                right: 10),
                                            decoration: BoxDecoration(
                                                color:
                                                ColorResources.COLOR_WHITE,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10),
                                                Expanded(
                                                  flex: 5,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionViewScreen(amount: snapshot.data[index]["amount"], description: snapshot.data[index]["description"], time:  snapshot.data[index]["created_at"], type: snapshot.data[index]["type"],)));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  snapshot.data[index]
                                                                  ["type"],
                                                                  style: poppinsSemiBold.copyWith(
                                                                      fontSize: Dimensions
                                                                          .FONT_SIZE_SMALL,
                                                                      color: snapshot.data[index]["type"] == 'DEBIT' ? Colors.redAccent : Colors.green),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                snapshot.data[index]
                                                                ["description"],
                                                                style: TextStyle(fontSize: 15.0, color: Colors.black),
                                                              ),
                                                            ),
                                                            Text(
                                                              '₦ ${snapshot.data[index]
                                                              ["amount"]}',
                                                              style: TextStyle(fontSize: 17.0, color: snapshot.data[index]["type"] == 'DEBIT' ? Colors.redAccent : Colors.green),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${outputFormat.format(DateTime.parse(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(snapshot.data[index]["created_at"]).toString()))}',
                                                              style: TextStyle(fontSize: 15.0, color: Colors.black),
                                                            ),

                                                            Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 15.0,)
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 18.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),);
                              }
                            }),
                  ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconTitleButton extends StatelessWidget {
  final String iconUrl;
  final String title;

  IconTitleButton({@required this.iconUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(iconUrl, width: 52, height: 52, fit: BoxFit.scaleDown),
        SizedBox(height: 7),
        Text(title, style: poppinsRegular.copyWith(color: ColorResources.COLOR_DIM_GRAY, fontSize: Dimensions.FONT_SIZE_SMALL)),
      ],
    );
  }
}
