import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/send_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toast/toast.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class UpgradeSettingScreen1 extends StatefulWidget {
  @override
  _UpgradeSettingScreen1State createState() => _UpgradeSettingScreen1State();
}

class _UpgradeSettingScreen1State extends State<UpgradeSettingScreen1> {
  var _myActivity;
  var service_id;
  var amount;
  var phone;
  var wallet;
  var _validate;
  var _validated;

  var code;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  List<Map<String, dynamic>> _items = [];

  final String url =
      "https://euzzitstaging.com.ng/api/v1/user/services/epin/products?service_id=27";

  List data = List(); //edited line

  Future<String> getSWData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    var resBody = json.decode(response.body);
    print(resBody["data"]["products"]);

    setState(() {
      data = resBody["data"]["products"];
      var walletMain = prefs.getString('mainWalletBalance');
      var walletMainSlug = prefs.getString('mainWalletSlug');
      var extraWallet = prefs.getString('extraWalletBalance');
      var extraWalletSlug = prefs.getString('extraWalletSlug');

      _items = [
        {
          'value': '$walletMainSlug',
          'label': '$walletMainSlug  $walletMain',
        },
        {
          'value': '$extraWalletSlug',
          'label': '$extraWalletSlug  $extraWallet',
        },
      ];
    });

    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SafeArea(
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: Icon(Icons.chevron_left, size: 30, color: Colors.deepPurple),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Center(child: Text('Upgrade Account', style: montserratSemiBold.copyWith(color: Colors.deepPurple, fontSize: 18.0))),
                  ]),
                ),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
                height: 670.0,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(color: ColorResources.COLOR_WHITE, borderRadius: BorderRadius.circular(15)),
                child: SingleChildScrollView(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SelectFormField(
                              type: SelectFormFieldType.dropdown, // or can be dialog
                              initialValue: 'null',
                              icon: Icon(Icons.account_balance_wallet),
                              items: _items,
                              decoration: InputDecoration(
                                hintText: "Choose Wallet",
                                labelText: "Choose Wallet",
                                labelStyle: TextStyle(color: Colors.deepPurple),
                                errorText: _validated == true ? 'Value Can\'t Be Empty' : null,
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onChanged: (value) async {
                                setState(() {
                                  wallet = value;
                                });
                              },
                              onSaved: (val) => {},
                            ),
                          ),
//https://euzzitstaging.com.ng/api/v1/auth/register
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: _usernameController,
                              onChanged:(value) async {
                                setState(() {
                                  phone = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Premium Invite ID",
                                labelText: "Enter Premium Invite ID",
                                labelStyle: TextStyle(color: Colors.deepPurple),
                                errorText: _validated == true ? 'Value Can\'t Be Empty' : null,
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                helperText: 'Leave Blank if you don not have any premium invite ID'

                              ),
                            ),
                          ),
//https://euzzitstaging.com.ng/api/v1/auth/register
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE),
                      child: CustomButton(
                          btnTxt: 'UPGRADE',
                          onTap: () async {
                            var url =
                                "https://euzzitstaging.com.ng/api/v1/user/upgrade";
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                            var token = prefs.getString('accessToken');

                            if (wallet == null) {
                              Toast.show('Choose A Wallet', context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM,
                                  backgroundColor: Colors.red);
                            } else {
                              if (await confirm(
                                context,
                                title: Text(
                                  'Proceed with Account Upgrade?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0,),
                                ),
                                content: Text(
                                    'The sum of ₦180,00.00 will be deducted from your $wallet account. Do you want to proceed with this action?'),
                                textOK: Text(
                                  'Proceed',
                                  style: TextStyle(color: Colors.green, fontSize: 15.0),
                                ),
                                textCancel: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red, fontSize: 15.0),
                                ),
                              )) {
                                print('pressedOK');

                                Loader.show(context,
                                    progressIndicator: CircularProgressIndicator(),
                                    themeData: Theme.of(context)
                                        .copyWith(accentColor: Colors.deepPurple),
                                    overlayColor: Color(0x99E8EAF6));
                                final http.Response response = await http.post(
                                  url,
                                  headers: <String, String>{
                                    'Content-Type': 'application/json; charset=UTF-8',
                                    'Authorization': 'Bearer $token',

                                  },
                                  body: jsonEncode({
                                    'wallet': wallet,
                                    'description': 'I am activating my account',
                                  }),
                                );
                                Loader.hide();
                                if (response.statusCode == 200) {
                                  var st = jsonDecode(response.body);
                                  print(st);
                                  Toast.show('Account Successfully Activated', context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.green);

                                  Navigator.pop(context);
                                } else {
                                  var st = jsonDecode(response.body);
                                  var message = st["message"];
                                  print(response.body);
                                  Toast.show(message, context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.red);
                                }
                              }
                              return print('pressedCancel');
                            }
                          }),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
