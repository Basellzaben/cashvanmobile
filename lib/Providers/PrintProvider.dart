
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/SalesInvoiceDModel.dart';
import '../Models/SalesInvoiceHModel.dart';
import '../main.dart';

class PrintProvider extends ChangeNotifier {
  String CusName = '';
  String Type = '';

  List<SalesInvoiceDModel>? cart = [];

  List<SalesInvoiceHModel>? cartHdr = [];


  getcart() {
    return cart;
  }

  setcart(List<SalesInvoiceDModel>? cart) {
    this.cart = cart;
    notifyListeners();
  }

  getcartHdr() {
    return cartHdr;
  }

  setcartHdr(List<SalesInvoiceHModel>? cartHdr) {
    this.cartHdr = cartHdr;
    notifyListeners();
  }
  
  
  getCusName() {
    return CusName;
  }

  setCusName(String CusName) {
    this.CusName = CusName;
    notifyListeners();
  }
  getType() {
    return Type;
  }

  setType(String Type) {
    this.Type = Type;
    notifyListeners();
  }

}