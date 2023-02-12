import 'package:flutter/material.dart';

class DebugProvider with ChangeNotifier {

  String _text = '';

  String get text {
    var t = _text;
    return t;
  }

  void setText(String text){
    _text=text;
    notifyListeners();
  }
}