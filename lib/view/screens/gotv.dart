import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/dstv_pin.dart';
import 'package:euzzit/view/screens/gotv_pin.dart';
import 'package:euzzit/view/screens/jamb_pin.dart';
import 'package:euzzit/view/screens/pin_code.dart';
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

class GOTV extends StatefulWidget {
  final int amount;
  final String product;
  GOTV({Key key, @required this.amount, @required this.product }) : super(key: key);
  @override
  _GOTVState createState() => _GOTVState();
}

class _GOTVState extends State<GOTV> {
  var _myActivity;
  var bank_id;
  var amount;
  var amount2;
  var account;
  var service_id;
  var wallet;
  var customernumber;
  var customername;
  var invoicePeriod;
  var customeraddress;
  var _validate;
  var _validated;

  List<Map<String, dynamic>> _items = [];


  var code;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _customernumberController = TextEditingController();
  final TextEditingController _customernameController = TextEditingController();
  final TextEditingController _customeraddressController = TextEditingController();





  final String url = "https://euzzitstaging.com.ng/api/v1/user/services/cabletv/products?service_id=21";

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
    print(resBody["data"]);

    setState(() {
      data = resBody["data"]["products"];
      var walletMain = prefs.getString('mainWalletBalance');
      var walletMainSlug = prefs.getString('mainWalletSlug');
      var extraWallet = prefs.getString('extraWalletBalance');
      var extraWalletSlug = prefs.getString('extraWalletSlug');
      amount = widget.amount;
      _amountController.text = '${widget.product}   ${widget.amount}';
      amount2 = resBody["data"]["products"][1]["amount"];
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
    return SendMoneyWidget(title: '${widget.product} Subscription', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100.0,),
        Container(

          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  enabled: false,
                  onChanged:(value) async {
                    setState(() {
                      account = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    errorText: _validate == true ? 'Value Can\'t Be Empty' : null,
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
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _accountController,
                  onChanged:(value) async {
                    setState(() {
                      account = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Account",
                    errorText: _validated == true ? 'Value Can\'t Be Empty' : null,
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
                      'Package:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '${widget.product}',
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
                      'Account:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$account',
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
                      '$wallet',
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
            var url = "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Loader.show(context,progressIndicator: CircularProgressIndicator(), themeData: Theme.of(context).copyWith(accentColor: Colors.deepPurple),
                overlayColor: Color(0x99E8EAF6));
    if(_amountController.text.isEmpty){
    _amountController.text.isEmpty ? _validate = true : _validate = false;

    Toast.show('Amount cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else if ( _customernameController.text.isEmpty) {
    _customernameController.text.isEmpty ? _validated = true : _validate = false;
    Toast.show('Customer name cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else {
      await prefs.setInt('GOTVAmount', amount);
      await prefs.setInt('gotvService_id', 21);
      await prefs.setString('wallet', wallet);
      await prefs.setInt('gotvaccount', account);

      Loader.hide();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => GOTVPINScreen()));
    }
          }),
        ),
      ],
    ));
  }
}
