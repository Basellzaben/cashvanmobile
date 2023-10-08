import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginProvider extends ChangeNotifier {
  String id="";

  String nameA="";
  String nameE="";


  //max id's
  int MaxLongstRANS=0;
  int MaxLongstRANSNo=0;
  getMaxLongstRANSNo() {
    return MaxLongstRANSNo;
  }

  setMaxLongstRANSNo(int MaxLongstRANSNo) {
    this.MaxLongstRANSNo = MaxLongstRANSNo;
    notifyListeners();
  }



  getMaxLongstRANS() {
    return MaxLongstRANS;
  }

  setMaxLongstRANS(int MaxLongstRANS) {
    this.MaxLongstRANS = MaxLongstRANS;
    notifyListeners();
  }

  getnameE() {
    return nameE;
  }

  setnameE(String nameE) {
    this.nameE = nameE;
    notifyListeners();
  }

  getnameA() {
    return nameA;
  }

  setnameA(String nameA) {
    this.nameA = nameA;
    notifyListeners();
  }

  getid() {
    return id;
  }

  setid(String id) {
    this.id = id;
    notifyListeners();
  }


}