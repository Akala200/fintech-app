import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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


class StepTwoScreen extends StatefulWidget {
  @override
  _StepTwoScreenState createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  String currentText = '';
  var onTapRecognizer;
  var code;
  TextEditingController textEditingController = TextEditingController()..text = "";
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
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
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StepOneScreen())),
              ),
            ]),
          ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.0,
                margin: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 10),
                padding: EdgeInsets.all(25),
                child: Hero(
                  tag: 3,
                  child: Image.asset(
                    'assets/Illustration/verification pg.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Center(
                child: Text(
                  Strings.VERIFICATION,
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
                  Strings.ENTER_4_DIGIT,
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
                          length: 5,
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
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                           var phone =  prefs.getString('phone');
                            print(phone);
                            print(code);
                            var url = "https://euzzitstaging.com.ng/api/v1/auth/activate_account";
                            Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.deepPurple);// iOS
                            final http.Response response = await http.post(
                              url,
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'phone': phone,
                                'code': v
                              }),
                            );

                            if (response.statusCode == 200) {
                              var st = jsonDecode(response.body);
                              print(response.body);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WalletStartupScreen()));
                            } else {
                              var st = jsonDecode(response.body);
                              var message = st["message"];
                              print(response.body);
                              print(response.body);
                              Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                            }
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
                  btnTxt: Strings.CONTINUE,
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var phone =  prefs.getString('phone');
                    print(phone);
                    print(code);
                    var url = "https://euzzitstaging.com.ng/api/v1/auth/activate_account";
                    Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.deepPurple);// iOS
                    final http.Response response = await http.post(
                      url,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'phone': phone,
                        'code': code
                      }),
                    );

                    if (response.statusCode == 200) {
                      var st = jsonDecode(response.body);
                      print(response.body);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WalletStartupScreen()));
                    } else {
                      var st = jsonDecode(response.body);
                      var message = st["message"];
                      print(response.body);
                      Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                    }
                  },
                ),
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                 // var phone =  prefs.getString('phone');
                  var phone = '08180009938';
                  print(phone);
                  print(code);
                  var url = "https://euzzitstaging.com.ng/api/v1/auth/resend_code";
                  Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.deepPurple);// iOS
                  final http.Response response = await http.post(
                    url,
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'phone': phone,
                    }),
                  );

                  if (response.statusCode == 200) {
                    var st = jsonDecode(response.body);
                    print(response.body);
                  } else {
                    var st = jsonDecode(response.body);
                    var message = st["message"];
                    print(response.body);
                    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);

                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Center(
                      child: Text(
                  'Re-send code',
                    style: poppinsRegular,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
