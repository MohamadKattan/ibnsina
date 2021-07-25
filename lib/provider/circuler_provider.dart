import 'package:flutter/material.dart';

class CircularProvider extends ChangeNotifier{
  bool isLoading ;

  circularLoading(bool yes){
    isLoading=yes;
    notifyListeners();
  }
}