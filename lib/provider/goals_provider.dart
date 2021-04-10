import 'package:flutter/material.dart';
import 'package:euzzit/data/models/my_goals_model.dart';
import 'package:euzzit/data/repository/goals_repo.dart';

class GoalsProvider extends ChangeNotifier {
  final GoalsRepo goalsRepo;
  GoalsProvider({@required this.goalsRepo});

  List<MyGoalsModel> getGoalsList() {
    return goalsRepo.getGoalsList();
  }
}