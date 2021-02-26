import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _value ;
  Counter(this._value);
  increment(){
    _value++;
    notifyListeners();
  }
  get value => _value;
}