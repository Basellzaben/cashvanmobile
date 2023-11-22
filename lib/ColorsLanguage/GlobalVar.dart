
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';


class Globalvireables {

  static String basecolor="#3268BA";
  static String secondcolor="#B6D0E2";

  static String white="#F5F5F5";
  static String black="#191919";
  static String black2="#333334";

  static String grey="#707070";
  static String secondcolor2="#d0e8ee";
  static String connectIPLocal="http://10.0.1.120:3210";


  static String them1="#229954";
  static String them2="#2E86C1";

  static String them3="#8E44AD";
  static String them4="#2E4053";
  static String them5="#138B79";


//Store Data into Shared Keys
  static String UsersJson='UsersJson';
  static String CustomerJson='CustomerJson';

  static String CustomerName='CustomerName';
  static String CustomerId='CustomerId';
  static String CustomerLimite='CustomerLimite';
  static String Receivables='Receivables';
  static String listofbestline='listofbestline';


  static String OpenRound='OpenRoundJson';
  static String AllRound='AllRound';

  static String loginAPI=connectIPLocal+"/api/LoginController/login";
  static String customerAPI=connectIPLocal+"/api/customerController/customer";
  static String PostAllVisitAPI=connectIPLocal+"/api/PostManVisitController/PostManVisit";

  static String ItemsAPI=connectIPLocal+"/api/itemsController/items";
  static String GetItemsCategAPI=connectIPLocal+"/api/ItemCategController/ItemCateg";
  static String GetUnitesAPI=connectIPLocal+"/api/UnitesController/Unites";
  static String GetUniteItemAPI=connectIPLocal+"/api/UniteItemController/UniteItem";
  static String GetMaxInvoice=connectIPLocal+"/api/InvoiceMaxController/InvoiceMax";

  static String PostInvoiceAPI=connectIPLocal+"/api/PostInvoiceController/PostInvoice";


  static String invforReturnedsURL=connectIPLocal+"/api/getInvoicehdrController/getInvoicehdr";
  static String invdtlforReturnedsURL=connectIPLocal+"/api/getInvoicedtlController/getInvoicedtl";

  static String GetCountryAPI=connectIPLocal+"/api/CountryContrler/Country";
  static String PostCustomerAPI=connectIPLocal+"/api/postCustomer/postCustomer";



  static String Total='';


  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' :'tablet';
  }

}