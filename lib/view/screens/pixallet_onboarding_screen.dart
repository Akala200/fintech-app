import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/data/repository/onboarding_repo.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/strings.dart';
import 'package:euzzit/utility/style.dart';
import 'package:euzzit/view/cliper/get_startted_background_cliper.dart';
import 'package:euzzit/view/screens/startup_Screen.dart';
import 'package:euzzit/view/screens/step/step_one_screen.dart';
import 'package:euzzit/view/widgets/button/custom_button.dart';
import 'package:euzzit/view/widgets/get_started_cardwidget.dart';

class euzzitOnBoardingScreen extends StatefulWidget {
  @override
  _euzzitOnBoardingScreenState createState() => _euzzitOnBoardingScreenState();
}

class _euzzitOnBoardingScreenState extends State<euzzitOnBoardingScreen> {
  final CarouselController buttonCarouselController = CarouselController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                ColorResources.COLOR_ROYAL_BLUE,
                ColorResources.COLOR_DARK_ORCHID,
              ])),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(children: [
                  /* IconButton(icon: Icon(Icons.chevron_left, color: ColorResources.COLOR_WHITE_GRAY), onPressed: () {
                    buttonCarouselController.animateToPage(1);
                  }),*/
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: OnboardingRepo.getAllStartedData.length,
                      carouselController: buttonCarouselController,
                      itemBuilder: (context, index) => GetStatedCardWidget(
                          OnboardingRepo.getAllStartedData[index],
                          OnboardingRepo.getStartedModelDataSecondSlides[index],
                          buttonCarouselController),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 0.6,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        initialPage: 0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  /*IconButton(icon: Icon(Icons.chevron_right, color: ColorResources.COLOR_WHITE_GRAY), onPressed: () {
                    buttonCarouselController.nextPage();
                  }),*/
                ]),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _indicator()),

                SizedBox(height: 20),
                //_secondSlide(context),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: CustomButton(
                      btnTxt: Strings.CREATE_ACCOUNT,
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => StepOneScreen()));
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  margin: EdgeInsets.only(left: 36, right: 36),
                  child: FlatButton(
                    child: Text(
                      Strings.LOGIN_TO_ACCOUNT,
                      style: poppinsRegular.copyWith(
                          color: ColorResources.COLOR_DIM_GRAY),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => WalletStartupScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _indicator() {
    List<Widget> indicator = [];
    for (int i = 0; i < OnboardingRepo.getAllStartedData.length; i++) {
      indicator.add(TabPageSelectorIndicator(
        backgroundColor: i == selectedIndex
            ? ColorResources.COLOR_PRIMARY
            : ColorResources.COLOR_GRAY,
        borderColor: i == selectedIndex
            ? ColorResources.COLOR_PRIMARY
            : ColorResources.COLOR_GRAY,
        size: 10,
      ));
    }
    return indicator;
  }
}
