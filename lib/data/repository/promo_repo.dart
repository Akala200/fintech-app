import 'package:euzzit/data/models/promo_model.dart';
import 'package:euzzit/utility/strings.dart';

class PromoRepo {
  List<PromoModel> getPromoData() {
    List<PromoModel> promoList = [
      PromoModel(
          imageUrl: 'assets/Icon/lock2.png',
          promoTitle: 'Protect Wallet',
          id: 1),
      PromoModel(
          imageUrl: 'assets/Icon/wallet3.png',
          promoTitle: 'Activate Wallet',
          id: 2),
    ];

    return promoList;
  }
}
