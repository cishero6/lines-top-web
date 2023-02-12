import 'package:flutter/material.dart';

class CarouselProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex {
    int i = _currentIndex;
    return i;
  }

  void setIndex(int index,{required bool shouldNotify}) {
    _currentIndex = index;
    if (shouldNotify) notifyListeners();
  }

}