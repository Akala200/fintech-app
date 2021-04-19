import 'dart:convert';

import 'package:euzzit/view/screens/airtime.dart';
import 'package:euzzit/view/screens/cabletv.dart';
import 'package:euzzit/view/screens/databundle.dart';
import 'package:euzzit/view/screens/electricity.dart';
import 'package:euzzit/view/screens/insight_screen.dart';
import 'package:euzzit/view/screens/send_money1_screen.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/organization_provider.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {

  _fetchListItems<List>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://euzzitstaging.com.ng/api/v1/user/services";
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
      print(rawFavouriteList);
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
      body: SingleChildScrollView(
        child: Stack(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar
                  CustomAppBar(title:  'Bill Payment', color: ColorResources.COLOR_WHITE),

                  Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(23), color: ColorResources.COLOR_WHITE.withOpacity(.24)),
                  child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Select and make bill payment',
                            style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_WHITE,
                            )),
                      ),
                    ),

                  ],
                  ),
                  ),
                  SizedBox(height: 20),

                  // Receipt buttons
                  Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendMoneyScreen1()));
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(child: Text('Fund Wallet', style: poppinsRegular.copyWith(color: ColorResources.COLOR_CHARCOAL))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 65,
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InsightScreen()));
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(child: Text('History', style: poppinsRegular.copyWith(color: ColorResources.COLOR_CHARCOAL))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  ),
                  ),
                  SizedBox(height: 30),

                  // Icon Buttons
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text('Service Category', style: poppinsRegular.copyWith(color: ColorResources.COLOR_WHITE)),
                  ),
                  SizedBox(height: 15),
                  Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  height: 180,
                  child: Column(
                  children: [
                    Row(
                      children: [
                        IconSquareButton(iconUrl: 'assets/Icon/electricity.png', label: 'Electricity', widget: ElectricityScreen1()),
                        IconSquareButton(iconUrl: 'assets/Icon/tv.png', label: 'Cable TV', widget: cableTvScreen1()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconSquareButton(iconUrl: 'assets/Icon/telephn.png', label: 'Airtime', widget: AirtimeScreen1(),),
                        IconSquareButton(iconUrl: 'assets/Icon/internet.png', label: 'Data Bundle', widget: DataScreen1(),),
                      ],
                    )
                  ],
                  ),
                  ),

                  // All Organization
                  Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Examples Of Bill', style: poppinsRegular.copyWith(color: ColorResources.COLOR_CHARCOAL)),
                  ),
                  SizedBox(height: 30,),
                  FutureBuilder<dynamic>(
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
                              child:    ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: Provider.of<OrganizationProvider>(context).getOrganizationList().length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.home_repair_service, color: Colors.deepPurple,),
                                          SizedBox(width: 15),
                                          Text(snapshot.data[index]["name"]),
                                        ],
                                      ),
                                    );
                                  }),
                          );
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconSquareButton extends StatelessWidget {
  final Widget widget;
  final String iconUrl;
  final String label;


  IconSquareButton({@required this.iconUrl, @required this.label, @required this.widget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          if(widget != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
          }
        },
        child: Container(
          height: 65,
          margin: EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorResources.COLOR_WHITE,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 7,),
              Image.asset(iconUrl, width: 30, height: 30),
              SizedBox(height: 3,),
              Text(label,)
            ],
          ),
        ),
      ),
    );
  }
}
