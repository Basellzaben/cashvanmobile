import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Them extends ChangeNotifier {
  String color="#138B79";

  getcolor() {
    return color;
  }

  setcolor(String color) {
    this.color = color;
    notifyListeners();
  }


}