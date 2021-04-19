import 'dart:async';
import 'dart:ffi';

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


class AirtimePINScreen extends StatefulWidget {
  @override
  _AirtimePINScreenState createState() => _AirtimePINScreenState();
}

class _AirtimePINScreenState extends State<AirtimePINScreen> {
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
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, size: 30, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
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
                    var phone =  prefs.getString('AirtimePhone');
                    var amount =  prefs.getString('AirtimeAmount');
                    var id =  prefs.getInt('AirtimeService_id');
                    var wallet =  prefs.getString('wallet');
//dstvaccount
                    var url = "https://euzzitstaging.com.ng/api/v1/auth/activate_account";
                    var url1 = "https://euzzitstaging.com.ng/api/v1/user/services/airtime/purchase";

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
                        'code': code,
                      }),
                    );

                    if (response.statusCode == 200) {
                      final http.Response response = await http.post(
                        url1,
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': 'Bearer $token',

                        },
                        body: jsonEncode({
                          'amount': amount,
                          'phone_no': phone,
                          'wallet': wallet,
                          'service_id': id,
                        }),
                      );
                      Loader.hide();
                      if (response.statusCode == 200) {
                        var st = jsonDecode(response.body);
                        print(st);
                        Toast.show('Airtime purchase successful', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.green);

                        Navigator.pop(context);
                      } else {
                        var st = jsonDecode(response.body);
                        var message = st["message"];
                        print(response.body);
                        Toast.show(message, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
                      }
                    } else {
                      Loader.hide();
                      var st = jsonDecode(response.body);
                      var message = st["message"];
                      print(response.body);
                      Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

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
