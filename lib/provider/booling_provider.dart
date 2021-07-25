
import 'package:flutter/material.dart';
class BoolIngProvider extends ChangeNotifier {
  bool isBoolIng;
  bool isWrong;
  isTrueOrNot(bool boolIng) {
    isBoolIng = boolIng;
    notifyListeners();
  }

  isWrongV(bool boolIng ){
    isWrong=boolIng;
  }
}
