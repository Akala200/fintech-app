import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/data/models/promo_model.dart';
import 'package:euzzit/utility/dimensions.dart';
import 'package:euzzit/utility/style.dart';

class PromoWidget extends StatelessWidget {
  final PromoModel promo;
  PromoWidget(this.promo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 280,
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/Illustration/offer-banner.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Expanded(child: Image.asset(
                  promo.imageUrl,
                  width: 60,
                  height: 50,
                )),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(promo.promoTitle, style: poppinsRegular.copyWith(fontSize: 16, color: ColorResources.COLOR_WHITE)),
                    ],
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
