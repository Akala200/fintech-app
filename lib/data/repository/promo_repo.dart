import 'package:euzzit/data/models/promo_model.dart';
import 'package:euzzit/utility/strings.dart';

class PromoRepo {
  List<PromoModel> getPromoData() {
    List<PromoModel> promoList = [
      PromoModel(
          imageUrl: 'assets/Icon/saving account banner.png',
          promoTitle: Strings.SAVING_ACCOUNT,
          promosubTitle: Strings.GET_UP_TO,
          id: 1),
      PromoModel(
          imageUrl: 'assets/Icon/request.png',
          promoTitle: Strings.SAVING_ACCOUNT,
          promosubTitle: Strings.GET_UP_TO,
          id: 2),
      PromoModel(
          imageUrl: 'assets/Icon/electricity.png',
          promoTitle: Strings.SAVING_ACCOUNT,
          promosubTitle: Strings.GET_UP_TO,
          id: 3),
    ];

    return promoList;
  }
}
