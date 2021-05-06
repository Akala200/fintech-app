import 'dart:convert';
import 'package:euzzit/view/screens/view_transaction.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/provider/goals_provider.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class CominSoonScreen extends StatefulWidget {
  @override
  _CominSoonScreenState createState() => _CominSoonScreenState();
}

class _CominSoonScreenState extends State<CominSoonScreen> {
  int bannerIndex = 0;
  var balance;
  var balanceExtra;
  var balanceExtraSlug;
  var mainBalance;
  var mainRealBalance;
  var inputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var coinBalance;
  var benefitsSlug;
  var benefit;
  var loanSlug;
  var loanBenefit;
  var insuranceSlug;
  var insuranceBenefit;


  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: 500.0,
              height: 340.0,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                     title: 'Coming Soon', color: Colors.white),
                SizedBox(height: 250.0,),
                Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        height: 100,
                        child:  Image.asset(
                          'assets/Icon/coming_soon.png',
                          width: 400.0,
                          height: 400.0,
                        ),
                      ),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

