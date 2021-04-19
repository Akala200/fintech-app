import 'package:euzzit/view/screens/pin_code.dart';
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

class SendMoneyScreen1 extends StatefulWidget {
  @override
  _SendMoneyScreen1State createState() => _SendMoneyScreen1State();
}

class _SendMoneyScreen1State extends State<SendMoneyScreen1> {
  var amount = '0';


  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SendMoneyWidget(title: 'Fund Main Wallet', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60,),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _usernameController,
                  onChanged:(value) async {
                    setState(() {
                      amount = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                  ),
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      'Amount:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$amount',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      'Transaction Type:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      'Deposit',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
            ],
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Fund Wallet', onTap: () async {
            var url = "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));
            var token =  prefs.getString('accessToken');

            final http.Response response = await http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token',

              },
              body: jsonEncode(<String, String>{
                'amount': amount,
                'type':'deposit',
                'deposit_wallet': 'main'
              }),
            );
            if (response.statusCode == 200) {
            Loader.hide();
              var st = jsonDecode(response.body);
              var transactionRef = st["data"]["transaction_ref"];
              await prefs.setString('transactionRef', transactionRef);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PinScreen()));
            } else {
            Loader.hide();
              var st = jsonDecode(response.body);
              var message = st["message"];
              print(response.body);
            Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            }
          }),
        ),
      ],
    ));
  }
}
