import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/merchant_payment.dart';
import 'package:euzzit/view/screens/pin_code.dart';
import 'package:euzzit/view/screens/pin_transfer.dart';
import 'package:euzzit/view/screens/pin_withdraw.dart';
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
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:toast/toast.dart';

class MerchantViewScreen1 extends StatefulWidget {
  @override
  _MerchantViewScreen1State createState() => _MerchantViewScreen1State();
}

class _MerchantViewScreen1State extends State<MerchantViewScreen1> {
  var amount = '0';
  var accountNumber;
  var bank_id;
  var _myActivityResult = '';
  var wallet;
  var _validated;
  var _validate;
  List<Map<String, dynamic>> _items = [];

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _merchantIDController = TextEditingController();
  String _mySelection = 'Select Bank';

  final String url = "https://euzzitstaging.com.ng/api/v1/banks";

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

    setState(() {
      data = resBody["data"];
      var walletMain = prefs.getString('mainWalletBalance');
      var walletMainSlug = prefs.getString('mainWalletSlug');
      var extraWallet = prefs.getString('extraWalletBalance');
      var extraWalletSlug = prefs.getString('extraWalletSlug');

      _items = [
        {
          'value': '$walletMainSlug',
          'label': '$walletMainSlug  ???$walletMain',
        },
        {
          'value': '$extraWalletSlug',
          'label': '$extraWalletSlug  ???$extraWallet',
        },
      ];
    });

    print(resBody["data"]);

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
        title: 'Send Money',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.0,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _merchantIDController,
                      onChanged: (value) async {
                        setState(() {
                          accountNumber = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Merchant ID",
                        labelText: "Enter Merchant ID",
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        errorText:
                            _validated == true ? 'Value Can\'t Be Empty' : null,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
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
              height: 20.0,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      onChanged: (value) async {
                        setState(() {
                          amount = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Amount",
                        labelText: 'Enter Amount',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        errorText: _validate == true ? 'Value Can\'t Be Empty' : null,
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
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
                      decoration: InputDecoration(
                        hintText: 'Select Wallet',
                        labelText: 'Select Wallet',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      items: _items,
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
                          '${amount != null ? '???$amount' : '???0'}',
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
                          'Payment',
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
                          'Wallet:',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Text(
                          '${wallet != null ? wallet : ''}',
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
                          'Merchant ID:',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Text(
                          '${accountNumber != null ? accountNumber : ''}',
                          style: montserratSemiBold.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: ColorResources.COLOR_DIM_GRAY),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                  btnTxt: 'Initiate',
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    if (_merchantIDController.text.isEmpty) {
                      setState(() {
                        _merchantIDController.text.isEmpty
                            ? _validated = true
                            : _validated = false;
                      });
                      Toast.show('Merchant ID cannot be empty', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red);
                    } else if (_amountController.text.isEmpty) {
                      setState(() {
                        _amountController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                      Toast.show('Amount cannot be empty', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red);
                    } else if (wallet == null) {
                      Toast.show('Select a wallet', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          backgroundColor: Colors.red);
                    } else {
                      await prefs.setString('merchant_id', accountNumber);
                      await prefs.setString('merchant_amount', amount);
                      await prefs.setString('merchant_Wallet', wallet);
                      Loader.hide();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MerchantPaymentScreen()));
                    }
                  }),
            ),
          ],
        ));
  }
}
