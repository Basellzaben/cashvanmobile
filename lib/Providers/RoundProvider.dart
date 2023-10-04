
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class RoundProvider extends ChangeNotifier {
  String CustomerId = '';
  String CustomerName = '';
  String CustomerLimite = '';
  String Receivables = '';

  getCustomerId() {
    return CustomerId;
  }

  setCustomerId(String CustomerId) {
    this.CustomerId = CustomerId;
    notifyListeners();
  }
  getCustomerName() {
    return CustomerName;
  }

  setCustomerName(String CustomerName) {
    this.CustomerName = CustomerName;
    notifyListeners();
  }

  getCustomerLimite() {
    return CustomerLimite;
  }

  setCustomerLimite(String CustomerLimite) {
    this.CustomerLimite = CustomerLimite;
    notifyListeners();
  }
  getReceivables() {
    return Receivables;
  }

  setReceivables(String Receivables) {
    this.Receivables = Receivables;
    notifyListeners();
  }
}