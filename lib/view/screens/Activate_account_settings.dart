import 'package:country_code_picker/country_code_picker.dart';
import 'package:euzzit/Network/auth.dart';
import 'package:euzzit/view/screens/activate_account_pin.dart';
import 'package:euzzit/view/screens/airtime_pin.dart';
import 'package:euzzit/view/screens/buy_airtime.dart';
import 'package:euzzit/view/screens/buy_electricity.dart';
import 'package:euzzit/view/screens/jamb.dart';
import 'package:euzzit/view/screens/step/login.dart';
import 'package:euzzit/view/screens/waec.dart';
import 'package:euzzit/view/widgets/send_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/step/step_two_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:euzzit/view/widgets/edittext/custom_text_field.dart';
import 'package:bs_overlay_loader/bs_overlay_loader.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class ActivateSettingScreen1 extends StatefulWidget {
  @override
  _ActivateSettingScreen1State createState() => _ActivateSettingScreen1State();
}

class _ActivateSettingScreen1State extends State<ActivateSettingScreen1> {
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
          'label': '$walletMainSlug  ₦$walletMain',
        },
        {
          'value': '$extraWalletSlug',
          'label': '$extraWalletSlug  ₦$extraWallet',
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
    return SendMoneyWidget(
        title: 'Activate Account',
        child: Column(
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
              height: 80.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                  btnTxt: 'INITIATE ACTIVATION',
                  onTap: () async {
                    var url =
                        "https://euzzitstaging.com.ng/api/v1/user/account_activation";
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
                          'Proceed with Account Activation?',
                          style: TextStyle(
                              color: Colors.deepPurple, fontSize: 20.0),
                        ),
                        content: Text(
                            'The sum of ₦ 500.00 will be deducted from your $wallet account. Do you want to proceed with this action?'),
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
                        await prefs.setString('wallet', wallet );
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ActivateAccountPINScreen()));

                      }
                      return print('pressedCancel');
                    }
                  }),
            ),
          ],
        ));
  }
}
