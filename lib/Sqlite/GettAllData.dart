
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:cashvanmobile/Models/ItemModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../Models/CustomersModel.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/languageProvider.dart';
import 'DatabaseHandler.dart';

import 'package:http/http.dart' as http;

class GettAllData {



  static Future<List<UsersModel>> GetAllUser(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    var LanguageProvider = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('login')),
              content: Text(LanguageProvider.Llanguage('loading')),
            ));
try{

    Uri apiUrl = Uri.parse(Globalvireables.loginAPI);

    final handler = DatabaseHandler();

    var map = new Map<String, dynamic>();
    print("Input" + map.toString());

    http.Response res = await http.post(
      apiUrl,
      body: map,
    );

    print("Input customer" + res.body.toString());

    if (res.statusCode == 200) {
      print("Invoices" + res.body.toString());

      List<dynamic> body = jsonDecode(res.body);

      List<UsersModel> Invoices = body
          .map(
            (dynamic item) => UsersModel.fromJson(item),
      )
          .toList();


      handler.addRepresentative( Invoices).whenComplete(() =>  Navigator.pop(context));

      return Invoices;
    } else {
      Navigator.pop(context);





      throw "Unable to retrieve Invoices." + res.statusCode.toString();
    }}catch(e){
  Navigator.pop(context);

  showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text(LanguageProvider.Llanguage('login')),
            content: Text(e.toString()),
          ));


}

    throw "Unable to retrieve Invoices.";
  }



  static Future<List<CustomersModel>> GetAllBranches(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('login')),
              content: Text(LanguageProvider.Llanguage('loading')),
            ));
    try{

      Uri apiUrl = Uri.parse(Globalvireables.customerAPI);

      var map = new Map<String, dynamic>();
      map['EXCEPTION'] = 'true';
      map['ManId'] = Loginprovider.getid();

      final handler = DatabaseHandler();


      http.Response res = await http.post(
        apiUrl,
        body: map,
      );

     // print("Input customer" + res.body.toString());

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<CustomersModel> Invoices = body
            .map(
              (dynamic item) => CustomersModel.fromJson(item),
        )
            .toList();


        handler.addbranches( Invoices).whenComplete(() =>  Navigator.pop(context));

        return Invoices;
      } else {
        Navigator.pop(context);


        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('login')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('login')),
                content: Text(e.toString()),
              ));


    }

    throw "Unable to retrieve Invoices.";
  }

 static GetMaxLongTrans(BuildContext context) async {
  var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

  final handler = DatabaseHandler();

  Loginprovider.MaxLongstRANS= await handler.getMaxIdFromTable('ManLogTrans');

return await handler.getMaxIdFromTable('ManLogTrans');

}


  static GetMaxLongTransNo(BuildContext context) async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    final handler = DatabaseHandler();

    Loginprovider.MaxLongstRANSNo= await handler.getMaxIdFromTableNo(context,'ManLogTrans');

    return await handler.getMaxIdFromTableNo(context,'ManLogTrans');

  }



  static Future<List<ItemModel>> GetAllInvF(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('login')),
              content: Text(LanguageProvider.Llanguage('loading')),
            ));
    try{

      Uri apiUrl = Uri.parse(Globalvireables.ItemsAPI);

      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();

      final handler = DatabaseHandler();


      http.Response res = await http.post(
        apiUrl,
        body: map,
      );

      // print("Input customer" + res.body.toString());

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ItemModel> Invoices = body
            .map(
              (dynamic item) => ItemModel.fromJson(item),
        )
            .toList();


        handler.addinvfe( Invoices).whenComplete(() =>  Navigator.pop(context));

        return Invoices;
      } else {
        Navigator.pop(context);


        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('login')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('login')),
                content: Text(e.toString()),
              ));


    }

    throw "Unable to retrieve Invoices.";
  }








}