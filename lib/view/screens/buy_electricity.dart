import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/electricity_pin.dart';
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

class BuyElectricity extends StatefulWidget {
  final int service_id;
  final String company;
  BuyElectricity({Key key, @required this.service_id, @required this.company }) : super(key: key);
  @override
  _BuyElectricityState createState() => _BuyElectricityState();
}

class _BuyElectricityState extends State<BuyElectricity> {
  var _myActivity;
  var service_id;
  var amount;
  var account;
  var phone;
  var wallet;
  var _validated;
  var _validate;
  var _validates;



  var code;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();
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
     var phone3  = prefs.getString(phone);
      _phoneController.text = phone3;
      print(phone3);


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
    return SendMoneyWidget(title: '${widget.company} Purchase', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50.0,),
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _meterNumberController,
                  onChanged:(value) async {
                    setState(() {
                      amount = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Meter Number",
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
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  onChanged:(value) async {
                    setState(() {
                      phone = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    errorText: _validates == true ? 'Value Can\'t Be Empty' : null,
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
                      'Power Company',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      widget.company,
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
              SizedBox(height: 10.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      'Phone:',
                      style: montserratSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.COLOR_DIM_GRAY),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Text(
                      '$phone',
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


    if(_amountController.text.isEmpty){
    _amountController.text.isEmpty ? _validate = true : _validate = false;

    Toast.show('Amount cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else if ( _meterNumberController.text.isEmpty) {
      _meterNumberController.text.isEmpty ? _validated = true : _validate = false;
    Toast.show('Meter Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else if ( _phoneController.text.isEmpty) {
            _phoneController.text.isEmpty ? _validated = true : _validate = false;
              Toast.show('Meter Number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
            } else {
      await prefs.setString('electricityAmount', amount);
      await prefs.setInt('electricityService_id', widget.service_id);
      await prefs.setString('wallet', 'Main');
      await prefs.setString('electricityAccount', account);
      Loader.hide();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ElectricityPinScreen()));
    }
          }),
        ),
      ],
    ));
  }
}
