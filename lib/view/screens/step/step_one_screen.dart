import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/screens/step/step_two_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/custom_app_bar.dart';
import 'package:euzzit/view/widgets/edittext/custom_text_field.dart';

class StepOneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.COLOR_REGISTRATION_BACKGROUND,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    Strings.REGISTRATION,
                    style: poppinsRegular.copyWith(fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Text(
                    Strings.ENTER_YOUR_MOBILE,
                    textAlign: TextAlign.center,
                    style: montserratRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),

                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            hintText: "First Name",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.person,color: Colors.deepPurple,),
//https://euzzitstaging.com.ng/api/v1/auth/register
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Last Name",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.person,color: Colors.deepPurple,),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: print,
                        initialSelection: 'BD',
                        favorite: ['+88', 'BD'],
                        showCountryOnly: false,
                        textStyle: poppinsRegular.copyWith(fontSize: 13,),
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          hintTxt: Strings.MOBILE_NUMBER,
                          isPhoneNumber: true,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                      Icon(Icons.phone,color: Colors.deepPurple,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: ColorResources.COLOR_WHITE_GRAY,width: 2)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.lock,color: Colors.deepPurple,),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                  child: CustomButton(btnTxt: Strings.CONTINUE,onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StepTwoScreen()));
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
