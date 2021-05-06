import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:euzzit/view/screens/data_pin.dart';
import 'package:euzzit/view/screens/dstv_pin.dart';
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

class DATAPHONE extends StatefulWidget {

  final int service_id;
  final String company;
  DATAPHONE({Key key, @required this.service_id, @required this.company }) : super(key: key);
  @override
  _DATAPHONEState createState() => _DATAPHONEState();
}

class _DATAPHONEState extends State<DATAPHONE> {
  var _myActivity;
  var phone;
  var amount;
  var service_id;
  var wallet;
  var _validate;
  var _validated;


  var code;
  final TextEditingController _phoneController = TextEditingController();



  List data = List(); //edited line
  List<Map<String, dynamic>> _items = [];

  Future<String> getSWData() async {
    final String url = "https://euzzitstaging.com.ng/api/v1/user/services/databundle/products?service_id=${widget.service_id}";
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

    print(response.body);

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
    return SendMoneyWidget(title: 'Purchase  ${widget.company}', child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropDownFormField(
                titleText: 'Subscription Type',
                hintText: 'Select Subscription Type',
                value: amount,
                onChanged: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                dataSource: data,
                textField: 'description',
                valueField: 'Amount',
              ),
            ),
//https://euzzitstaging.com.ng/api/v1/auth/register
          ],
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
                    labelText:  "Select Wallet",
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
                      'Data Type:',
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
                      'Phone:',
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
            var url = "https://euzzitstaging.com.ng/api/v1/user/transfer/generate_transaction_ref";
            SharedPreferences prefs = await SharedPreferences.getInstance();
    if ( _phoneController.text.isEmpty) {
      _phoneController.text.isEmpty ? _validated = true : _validate = false;
    Toast.show('Phone number cannot be empty', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else if(wallet == null){
      Toast.show('Select a wallet', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else if(amount == null){
      Toast.show('Select a data bundle', context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM, backgroundColor: Colors.red);
    } else {
      await prefs.setString('dataAmount', amount);
      await prefs.setInt('dataService_id', widget.service_id);
      await prefs.setString('wallet', wallet);
      await prefs.setString('dataPhone', phone);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DataPINScreen()));
    }
          }),
        ),
      ],
    ));
  }
}
