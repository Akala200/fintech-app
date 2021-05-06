import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/dstv_pin.dart';
import 'package:euzzit/view/screens/gotv_pin.dart';
import 'package:euzzit/view/screens/jamb_pin.dart';
import 'package:euzzit/view/screens/pin_code.dart';
import 'package:euzzit/view/screens/startimes_pin.dart';
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

class Startimes extends StatefulWidget {
  final String amount;
  final String product;
  Startimes({Key key, @required this.amount, @required this.product }) : super(key: key);
  @override
  _StartimesState createState() => _StartimesState();
}

class _StartimesState extends State<Startimes> {
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





  final String url = "https://euzzitstaging.com.ng/api/v1/user/services/cabletv/products?service_id=24";

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
                    labelText: "Enter Amount",
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
                    labelText: "Enter Account",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    errorText: _validated == true ? 'Value Can\'t Be Empty' : null,
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
                  decoration: InputDecoration(
                    hintText: "Select Wallet",
                    labelText: "Select Wallet",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
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
                      '${widget.product != null ? widget.product : ''}',
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
                      '${amount != null ? '₦$amount': '₦0'}',
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
                      '${ account != null ? account:''}',
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
                      '${wallet != null ? wallet: ''}',
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
            SharedPreferences prefs = await SharedPreferences.getInstance();

            if ( _accountController.text.isEmpty) {
              _accountController.text.isEmpty ? _validated = true : _validate = false;
              Toast.show('Account Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            } else if(wallet == null){
              Toast.show('Select a wallet', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            } else  {
              await prefs.setString('StartimesAmount', amount);
              await prefs.setInt('StartimesService_id', 24);
              await prefs.setString('StartimesWallet', wallet);
              await prefs.setString('StartimesAccount', account);

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StartimesPinScreen()));
            }
          }),
        ),
      ],
    ));
  }
}
