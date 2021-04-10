import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/Illustration/Untitled-1.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                CustomAppBar(title: Strings.SETTING, color: ColorResources.COLOR_WHITE),

                // Upper Card
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 30),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(color: ColorResources.COLOR_PRIMARY, shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/images/person3.png',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(Strings.NAME, style: poppinsBold),
                    Text(Strings.EMAIL,
                        style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY, fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL)),
                    Divider(height: 15, color: ColorResources.COLOR_DIM_GRAY),
                    Text(Strings.USD266,
                        style: poppinsBold.copyWith(color: ColorResources.COLOR_CARIBBEAN_GREEN, fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ]),
                ),

                Expanded(
                  child: ListView(physics: BouncingScrollPhysics(), padding: EdgeInsets.all(10), children: [
                    // Buttons
                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.home, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.HOME_DASHBOARD, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.picture_as_pdf, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.STATEMENT, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.category, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.COUPON, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.whatshot, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.PREFERENCE, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.language, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.SETTING, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.person_add, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.REFER_A_FRIEND, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.local_library, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.SUPPORT, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),

                    ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Icon(Icons.exit_to_app, color: ColorResources.COLOR_MEDIUM_VIOLET_RED),
                      ),
                      title: Text(Strings.LOG_OUT, style: poppinsSemiBold.copyWith(color: ColorResources.COLOR_DIM_GRAY)),
                    ),
                    Divider(height: 2, color: ColorResources.COLOR_WHITE_GRAY),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
