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

class MerchantPercentScreen1 extends StatefulWidget {
  @override
  _MerchantPercentScreen1State createState() => _MerchantPercentScreen1State();
}

class _MerchantPercentScreen1State extends State<MerchantPercentScreen1> {
  var amount = '0';
  var accountNumber;
  var bank_id;
  var  _myActivityResult = '';
  var wallet;
  List<Map<String, dynamic>> _items = [];


  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _mySelection = 'Select Bank';

  final String url = "https://euzzitstaging.com.ng/api/v1/banks";

  List data = List(); //edited line

  Future<String> getSWData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =  prefs.getString('accessToken');
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
          'label': '$walletMainSlug  ₦$walletMain',
        },
        {
          'value': '$extraWalletSlug',
          'label': '$extraWalletSlug  ₦$extraWallet',
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
    return SendMoneyWidget(title: 'Set Reward', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60.0,),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  onChanged:(value) async {
                    setState(() {
                      accountNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Set Reward(%",
                  ),
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),
        SizedBox(height: 80.0,),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Update Merchant Reward', onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));
            await prefs.setString('merchant_id', accountNumber );
            await prefs.setString('merchant_amount', amount );
            await prefs.setString('merchant_Wallet', wallet );
            Loader.hide();

          }),
        ),
      ],
    ));
  }
}
