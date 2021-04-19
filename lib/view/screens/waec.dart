import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/jamb_pin.dart';
import 'package:euzzit/view/screens/pin_code.dart';
import 'package:euzzit/view/screens/waec_pin.dart';
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

class WAECScreen1 extends StatefulWidget {
  @override
  _WAECScreen1State createState() => _WAECScreen1State();
}

class _WAECScreen1State extends State<WAECScreen1> {
  var _myActivity;
  var bank_id;
  var amount;
  var count;
  var account;
  var wallet;

  var code;
  final TextEditingController _usernameController = TextEditingController();

  final String url = "https://euzzitstaging.com.ng/api/v1/user/services/epin/products?service_id=25";
  List<Map<String, dynamic>> _items = [];


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
    print(resBody["data"]["products"]);

    setState(() {
      amount = resBody["data"]["products"]["amount"];
      count = resBody["data"]["products"]["count"];
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
    return SendMoneyWidget(title: 'Purchase WAEC Form', child: Column(
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
                      account = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Account Number",
                  ),
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),
        SizedBox(height: 30.0,),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  initialValue: 'null',
                  icon: Icon(Icons.account_balance_wallet),
                  labelText: 'Wallet',
                  items: _items,
                  onChanged:(value) async {
                    setState(() {
                      wallet = value;
                    });
                  },
                  onSaved: (val) => {

                  },
                ),
              ),
//https://euzzitstaging.com.ng/api/v1/auth/register
            ],
          ),
        ),
        SizedBox(height: 30.0,),

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
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$amount',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
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
                      'Account:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$account',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
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
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$wallet',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Initiate', onTap: () async {
            var url = "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));

            await prefs.setInt('WaecAmount', amount );
            await prefs.setInt('service_id', 25 );
            await prefs.setString('wallet', wallet );
            await prefs.setString('account', account );
            Loader.hide();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => WaecPinScreen()));
          }),
        ),
      ],
    ));
  }
}
