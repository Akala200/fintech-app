import 'package:flutter/material.dart';
import 'package:euzzit/data/models/gift_model.dart';
import 'package:euzzit/data/repository/gift_repo.dart';

class GiftProvider extends ChangeNotifier {
  final GiftRepo giftRepo;
  GiftProvider({@required this.giftRepo});

  List<GiftModel> getGiftList() {
    return giftRepo.getGiftList();
  }
}