
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:cashvanmobile/Models/ItemModel.dart';
import 'package:cashvanmobile/Models/ItemsCategModel.dart';
import 'package:cashvanmobile/Models/UnitItemModel.dart';
import 'package:cashvanmobile/Models/UnitesModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../Models/CustomersModel.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
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



  static Future<List<ItemsCategModel>> GetAllItemCat(BuildContext context) async {
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

      Uri apiUrl = Uri.parse(Globalvireables.GetItemsCategAPI);


      final handler = DatabaseHandler();


      http.Response res = await http.post(
        apiUrl,
      );

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<ItemsCategModel> Invoices = body
            .map(
              (dynamic item) => ItemsCategModel.fromJson(item),
        )
            .toList();


        handler.addItemsCateg( Invoices).whenComplete(() =>  Navigator.pop(context));

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



  static Future<List<UnitesModel>> GetUnites(BuildContext context) async {
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

      Uri apiUrl = Uri.parse(Globalvireables.GetUnitesAPI);


      final handler = DatabaseHandler();


      http.Response res = await http.post(
        apiUrl,
      );

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<UnitesModel> Invoices = body
            .map(
              (dynamic item) => UnitesModel.fromJson(item),
        )
            .toList();


        handler.addUnites( Invoices).whenComplete(() =>  Navigator.pop(context));

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

  static Future<List<UnitItemModel>> GetUniteItem(BuildContext context) async {
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

      Uri apiUrl = Uri.parse(Globalvireables.GetUniteItemAPI);


      final handler = DatabaseHandler();


      http.Response res = await http.post(
        apiUrl,
      );

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<UnitItemModel> Invoices = body
            .map(
              (dynamic item) => UnitItemModel.fromJson(item),
        )
            .toList();


        handler.addUnitItem( Invoices).whenComplete(() =>  Navigator.pop(context));

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

 static Future<int> GetMaxInvoiceV (BuildContext context) async {
    final handler = DatabaseHandler();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
var max=0;
    try{

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);



      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();

      http.Response res = await http.post(
        apiUrl,
          body:map
      );


      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        var body = jsonDecode(res.body);


        if(body["salesOrderMax"].toString()!='0')
        StoreShared.SaveJson('salesOrderMax',body["salesOrderMax"].toString());
        else
          StoreShared.SaveJson('salesOrderMax','0');



        var maxfromlocal=await handler.getMaxInvoice(context);
        var maxfromapi=int.parse(StoreShared.getJson('salesOrderMax'));

        if(int.parse(maxfromlocal.toString())>maxfromapi)
          {
            StoreShared.SaveJson('salesOrderMax',maxfromlocal.toString());
            max=int.parse(maxfromlocal.toString());

          }
        else
          {
            StoreShared.SaveJson('salesOrderMax',maxfromapi.toString());
            max=int.parse(maxfromapi.toString());
          }



        /* List<UnitItemModel> Invoices = body
            .map(
              (dynamic item) => UnitItemModel.fromJson(item),
        )
            .toList();
*/

      //  handler.addUnitItem( Invoices).whenComplete(() =>  Navigator.pop(context));

      } else {

        print("reponceapppp"+res.statusCode.toString());


        var maxfromlocal=await handler.getMaxInvoice(context);

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('salesOrderMax',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal=await handler.getMaxInvoice(context);

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('salesOrderMax',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maaaaxlocal");

    }

    print(max.toString() + "maaaax");

    return max;
    throw "Unable to retrieve Invoices.";
  }




}