import 'package:flutter/material.dart';

class DoubleProvider extends ChangeNotifier{
  double value=0;
  value0Or1(double val){
    value=val;
    notifyListeners();
  }
}