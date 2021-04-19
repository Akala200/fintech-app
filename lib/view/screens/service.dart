import 'package:euzzit/view/screens/pin_code.dart';
import 'package:euzzit/view/screens/pin_transfer.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/send_money2_Screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/send_money_widget.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';

class ServiceScreen1 extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen1> {
  var name;


  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SendMoneyWidget(title: 'Create A Service', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                  controller: _amountController,
                  onChanged:(value) async {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),

        SizedBox(height: 30.0,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Create Service', onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));
            var url = "https://euzzitstaging.com.ng/api/v1/user/merchant/service";
            var token =  prefs.getString('accessToken');

            final http.Response response = await http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(<String, String>{
                'name': name,
              }),
            );

            Loader.hide();
            if (response.statusCode == 200) {
              var st = jsonDecode(response.body);
              Toast.show("Service Created Successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
              Navigator.pop(context);

            } else {
              var st = jsonDecode(response.body);
              Toast.show(st["message"], context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            }


          }),
        ),
      ],
    ));
  }
}
