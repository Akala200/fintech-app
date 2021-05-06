import 'dart:async';
import 'dart:ffi';

import 'package:euzzit/view/screens/finish_transaction.dart';
import 'package:euzzit/view/screens/saving_account_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/step/step_three_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:euzzit/view/screens/startup_Screen.dart';
import 'package:euzzit/view/screens/step/step_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';


class ElectricityPinScreen extends StatefulWidget {
  @override
  _ElectricityPinScreenState createState() => _ElectricityPinScreenState();
}

class _ElectricityPinScreenState extends State<ElectricityPinScreen> {
  String currentText = '';
  var onTapRecognizer;
  var code;
  TextEditingController textEditingController = TextEditingController()..text = "";
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var ref;
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();

    void getFreshData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        ref =  prefs.getString('transactionRef');

      });
//accountStatus

    }
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, size: 30, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 150.0,),
              Center(
                child: Text(
                  'Transaction Authorization',
                  style: poppinsRegular.copyWith(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(left: 30, right: 20),
                alignment: Alignment.center,
                child: Text(
                  'Input your pin to authorize the transaction before it is approved',
                  textAlign: TextAlign.center,
                  style: montserratRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          length: 4,
                          appContext: context,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            selectedFillColor: Colors.transparent,
                            inactiveFillColor: Colors.transparent,
                            inactiveColor: ColorResources.COLOR_GRAY,
                            activeColor: ColorResources.COLOR_PRIMARY_DARK,
                            activeFillColor: hasError ? Colors.orange : Colors.transparent,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          onCompleted: (v) async {
                            print("Completed");
                            setState(() {
                              code = v;
                            });
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                              code = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: Dimensions.MARGIN_SIZE_DEFAULT,
                  left: Dimensions.MARGIN_SIZE_DEFAULT,
                  right: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                child: CustomButton(
                  btnTxt: 'Authorize',
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var phone =  prefs.getString('phone');
                    var amount =  prefs.getString('electricityAmount');
                    var id =  prefs.getInt('electricityService_id');
                    var wallet =  prefs.getString('wallet');
                    var account =  prefs.getString('electricityAccount');
                    var electricityComany = prefs.getString('electricityComany');
                    var refineAmount = int.parse(amount);

                    var url1 = "https://euzzitstaging.com.ng/api/v1/user/services/electricity/purchase";

                    Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                        overlayColor: Color(0x99E8EAF6));
                    var token =  prefs.getString('accessToken');
                    print(wallet);

                      final http.Response response = await http.post(
                        url1,
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'Bearer $token',
                          'pin': '$code'
                        },
                        body: jsonEncode({
                          'amount': refineAmount,
                          'account': account,
                          'wallet': wallet,
                          'service_id': id,
                          'phone_no': phone
                        }),
                      );
                      if (response.statusCode == 200) {
                        Loader.hide();
                        var st = jsonDecode(response.body);
                        print(st);
                        var coinEarned = st["data"]["coin_earned"];
                        var creditToken = st["data"]["credit_token"]["creditToken"];
                        var serialNumber = st["data"]["credit_token"]["serialNumber"];
                        Toast.show('Transaction Successful', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FinishTransactionScreen(type: '$electricityComany Purchase Was Successful', amount: amount.toString(), coinEarned: coinEarned,  recipient: electricityComany, from: wallet, token: creditToken, serial: serialNumber, description: 'EUZZIT power purchase',)));
                      } else {
                        Loader.hide();
                        var st = jsonDecode(response.body);
                        var message = st["message"];
                        print(response.body);
                        Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
