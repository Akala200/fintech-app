import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:euzzit/view/screens/airtime_pin.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/send_money_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:select_form_field/select_form_field.dart';

class BuyAirtime extends StatefulWidget {
  final int service_id;
  final String company;
  BuyAirtime({Key key, @required this.service_id, @required this.company }) : super(key: key);
  @override
  _BuyAirtimeState createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
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

  final String url = "https://euzzitstaging.com.ng/api/v1/user/services/epin/products?service_id=27";

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
        title: 'Purchase Airtime ',
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30.0,),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onChanged:(value) async {
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
                  keyboardType: TextInputType.phone,
                  controller: _usernameController,
                  onChanged:(value) async {
                    setState(() {
                      phone = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    labelText: 'Enter Phone Number',
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
                  icon: Icon(Icons.account_balance_wallet, color: Colors.deepPurple,),
                  labelText: 'Wallet',
                  style: TextStyle(color: Colors.deepPurple),
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    labelText: 'Select Wallet',
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
                      'Telco',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '${widget.company != null ? widget.company : ''}',
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
                      '${amount != null ? '₦$amount' : '₦0'}',
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
                      'Phone Number:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '${phone != null ? phone: ''}',
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
                      '${wallet !=null ? wallet : ''}',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 50.0,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(btnTxt: 'Buy Airtime', onTap: () async {
            var connectivityResult =
            await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi) {
            var url = "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if(_amountController.text.isEmpty){
              setState(() {
                _amountController.text.isEmpty ? _validate = true : _validate = false;
              });
              Toast.show('Amount cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            } else if ( _usernameController.text.isEmpty) {
              setState(() {
                _usernameController.text.isEmpty ? _validated = true : _validate = false;
              });
              Toast.show('Phone Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            }  else if(wallet == null){
              Toast.show('Select a wallet', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            } else {

              await prefs.setString('AirtimeAmount', amount );
              await prefs.setInt('AirtimeService_id', widget.service_id );
              await prefs.setString('wallet', wallet );
              await prefs.setString('AirtimePhone', phone );
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AirtimePINScreen()));
            }
            }
          }),
        ),
      ],
    ));
  }
}
