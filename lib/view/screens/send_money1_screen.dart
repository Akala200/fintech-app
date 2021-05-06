import 'package:euzzit/view/screens/finish_transaction.dart';
import 'package:euzzit/view/screens/pin_code.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/send_money2_Screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/send_money_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';
import 'dart:convert';

class SendMoneyScreen1 extends StatefulWidget {
  @override
  _SendMoneyScreen1State createState() => _SendMoneyScreen1State();
}

class _SendMoneyScreen1State extends State<SendMoneyScreen1> {
  var amount = '0';
  var ref;
  var firstName;
  var lastName;
  var email;
  var phone;

  var _validated;

  Future<void> getDataCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString('first_name');
    lastName = prefs.getString('last_name');
    email = prefs.getInt('email');
    phone = prefs.getString('phone');
//dstvaccount  merchantCode
  }

  Future<void> initSdk() async {
    // messages may fail, so we use a try/catch PlatformException. merchantCode
    try {
      String merchantId = "IKIA5BA5374FBB9EED86752E118B272C5A538C4108C6",
          merchantKey = "1EEB5A9C59231D858F6A6B9D1FB34F9094C5BBAB",
          merchantCode = '1EEB5A9C59231D858F6A6B9D1FB34F9094C5BBAB',
          currencyCode = "566", // e.g  566 for NGN
          merchantSecret = "tnFadFHA3uJGsUxzf0I1TK/uHswGnst/RN1MlhPu9CQ=";

      var config = new IswSdkConfig(
        merchantId,
        merchantKey,
        merchantCode,
        currencyCode,
      );

      // initialize the sdk
      await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      // IswMobileSdk.initialize(config, Environment.SANDBOX);

    } on PlatformException {}
  }

  Future<void> pay(int amount) async {
    var customerId = "<customer-id>",
        customerName = "$firstName  $lastName",
        customerEmail = email,
        customerMobile = phone,
        // generate a unique random
        // reference for each transaction
        reference = ref;

    // initialize amount
    // amount expressed in lowest
    // denomination (e.g. kobo): "N500.00" -> 50000
    int amountInKobo = amount * 100;

    // create payment info
    var iswPaymentInfo = new IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amountInKobo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    // process result
    if (result.hasValue) {
      print(result);
      // process result
      Toast.show('jhgjhgwwe', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    } else {
      print(result);
      Toast.show('Unable to complete payment', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    initSdk();
    getDataCurrent();
  }

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SendMoneyWidget(
        title: 'Fund Main Wallet',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _usernameController,
                      onChanged: (value) async {
                        setState(() {
                          amount = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        labelText: "Enter Amount",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        errorText:
                            _validated == true ? 'Value Can\'t Be Empty' : null,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
//https://euzzitstaging.com.ng/api/v1/auth/register
                ],
              ),
            ),
            SizedBox(
              height: 30,
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
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Text(
                          '$amount',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          'Transaction Type:',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Text(
                          'Deposit',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
                ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                  btnTxt: 'Fund Wallet',
                  onTap: () async {
                    var url =
                        "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
                    if (_usernameController.text.isEmpty
                        ? _validated = true
                        : _validated = false) {
                      Toast.show('Kindly knter an amount', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red);
                    } else {
                      print('here');
                    }
                  }),
            ),
          ],
        ));
  }
}
