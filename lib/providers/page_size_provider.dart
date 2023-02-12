import 'package:flutter/material.dart';
import 'package:parallax/parallax.dart';

class PageSizeProvider with ChangeNotifier{
  double _height = 3000;
  BuildContext? _parallaxContext;
  double get height {
    return _height;
  }
  BuildContext? get parallaxContext{
    return _parallaxContext;
  }
  void setParallaxContext(BuildContext newC){
    _parallaxContext = newC;
    Future.delayed(const Duration(milliseconds: 900)).whenComplete(()=> notifyListeners());
  }
  void setHeight(double height){
    _height = height;
    notifyListeners();
  }
}