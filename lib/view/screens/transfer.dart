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

class TransferScreen1 extends StatefulWidget {
  @override
  _TransferScreen1State createState() => _TransferScreen1State();
}

class _TransferScreen1State extends State<TransferScreen1> {
  var amount = '0';
  var phone;


  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SendMoneyWidget(title: 'Transfer Within Euzzit', child: Column(
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
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onChanged:(value) async {
                    setState(() {
                      amount = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
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
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  onChanged:(value) async {
                    setState(() {
                      phone = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Recipient Phone Number",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),

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
                      'Transfer',
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
                      'Wallet:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      'Main',
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
                      'Recipient:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$phone',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Initiate', onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));
            await prefs.setString('phone_transfer', phone );
            await prefs.setString('amount_transfer', amount );
            Loader.hide();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PinTransferScreen()));


          }),
        ),
      ],
    ));
  }
}
