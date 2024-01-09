
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
import '../Models/CountryModel.dart';
import '../Models/CustomersModel.dart';
import '../Models/Sequences.dart';
import '../Models/StockModel.dart';
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
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
            title: Text(LanguageProvider.Llanguage('updatedata')),
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
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
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
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
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
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
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
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));


        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
                content: Text(e.toString()),
              ));


    }

    throw "Unable to retrieve Invoices.";
  }

  static Future<List<UnitItemModel>> GetUniteItem(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('updatedata')),
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
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));

        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
                content: Text(e.toString()),
              ));


    }

    throw "Unable to retrieve Invoices.";
  }



  static Future<List<CountryModel>> GetCountry(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('updatedata')),
              content: Text(LanguageProvider.Llanguage('loading')),
            ));
    try{
      Uri apiUrl = Uri.parse(Globalvireables.GetCountryAPI);
      final handler = DatabaseHandler();
      http.Response res = await http.post(
        apiUrl,
      );

      print("statusCode" + res.statusCode.toString());


      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());
        List<dynamic> body = jsonDecode(res.body);
        List<CountryModel> Invoices = body
            .map(
              (dynamic item) => CountryModel.fromJson(item),
        )
            .toList();
        handler.addCountry( Invoices).whenComplete(() =>  Navigator.pop(context));

        return Invoices;
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('updatedata')),
                  content: Text(res.statusCode.toString()),
                ));

        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('updatedata')),
                content: Text(e.toString()),
              ));


    }

    throw "Unable to retrieve Invoices.";
  }



  static Future<int> GetMaxVoucher (BuildContext context) async {
    final handler = DatabaseHandler();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var max=0;
    try{

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);



      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();
      map['type'] = 'maxvocher';

      http.Response res = await http.post(
          apiUrl,
          body:map
      );

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body.map((dynamic item) => Sequences.fromJson(item),)  .toList();


        print("Invoices" + seq.first.salesOrderMax.toString());



        if(seq.first.salesOrderMax.toString()!='0')
          StoreShared.SaveJson('maxvoch',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('maxvoch','0');



        var maxfromlocal=await handler.getmaxvoch(context);
        var maxfromapi=seq.first.salesOrderMax.toString();


        print("sttttttock  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
        {
          StoreShared.SaveJson('maxvoch',maxfromlocal.toString());
          max=int.parse(maxfromlocal.toString());

        }
        else
        {
          StoreShared.SaveJson('maxvoch',maxfromapi.toString());
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


        var maxfromlocal=await handler.getmaxvoch(context);

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('maxvoch',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal=await handler.getmaxvoch(context);

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('maxvoch',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maxvoch");

    }

    print(max.toString() + "maaaax");

    return max;
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
      map['type'] = 'maxinv';

      http.Response res = await http.post(
        apiUrl,
          body:map
      );

      var body = jsonDecode(res.body);

      if (res.statusCode == 200) {



        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body
            .map(
              (dynamic item) => Sequences.fromJson(item),
        )  .toList();


        print("Invoices" + seq.first.salesOrderMax.toString());



        if(seq.first.salesOrderMax.toString()!='0')
        StoreShared.SaveJson('salesOrderMax',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('salesOrderMax','0');



        var maxfromlocal=await handler.getMaxInvoice(context);
        var maxfromapi=seq.first.salesOrderMax.toString();


        print("Invoices444  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
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

  static Future<int> GetMaxReturnInv (BuildContext context) async {
    final handler = DatabaseHandler();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var max=0;
    try{

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);



      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();
      map['type'] = 'maxreturn';

      http.Response res = await http.post(
          apiUrl,
          body:map
      );

      var body = jsonDecode(res.body);

      if (res.statusCode == 200) {



        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body
            .map(
              (dynamic item) => Sequences.fromJson(item),
        )  .toList();


        print("Invoices" + seq.first.salesOrderMax.toString());



        if(seq.first.salesOrderMax.toString()!='0')
          StoreShared.SaveJson('returnOrderMax',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('returnOrderMax','0');



        var maxfromlocal=await handler.getMaxReturn(context);
        var maxfromapi=seq.first.salesOrderMax.toString();


        print("Invoices444  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
        {
          StoreShared.SaveJson('returnOrderMax',maxfromlocal.toString());
          max=int.parse(maxfromlocal.toString());

        }
        else
        {
          StoreShared.SaveJson('returnOrderMax',maxfromapi.toString());
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


        var maxfromlocal=await handler.getMaxReturn(context);

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('returnOrderMax',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal=await handler.getMaxReturn(context);

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('returnOrderMax',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maaaaxlocal");

    }

    print(max.toString() + "maaaax");

    return max;
    throw "Unable to retrieve Invoices.";
  }

  static Future<int> GetMaxStock (BuildContext context) async {
    final handler = DatabaseHandler();
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var max=0;
    try{

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);



      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();
      map['type'] = 'maxstock';

      http.Response res = await http.post(
          apiUrl,
          body:map
      );

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body.map((dynamic item) => Sequences.fromJson(item),)  .toList();


        print("Invoices" + seq.first.salesOrderMax.toString());



        if(seq.first.salesOrderMax.toString()!='0')
          StoreShared.SaveJson('maxstock',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('maxstock','0');



        var maxfromlocal=await handler.getMaxStock(context);
        var maxfromapi=seq.first.salesOrderMax.toString();


        print("sttttttock  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
        {
          StoreShared.SaveJson('maxstock',maxfromlocal.toString());
          max=int.parse(maxfromlocal.toString());

        }
        else
        {
          StoreShared.SaveJson('maxstock',maxfromapi.toString());
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


        var maxfromlocal=await handler.getMaxStock(context);

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('maxstock',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal=await handler.getMaxStock(context);

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('maxstock',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maxstock");

    }

    print(max.toString() + "maaaax");

    return max;
    throw "Unable to retrieve Invoices.";
  }

  static Future<int> GetMaxSupply (BuildContext context) async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var max=0;
    try{

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);



      var map = new Map<String, dynamic>();
      map['ManId'] = Loginprovider.getid();
      map['type'] = 'maxssupply';

      http.Response res = await http.post(
          apiUrl,
          body:map
      );

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body.map((dynamic item) => Sequences.fromJson(item),)  .toList();


        print("Invoices" + Loginprovider.getid());



        if(seq.first.salesOrderMax.toString()!='0')
          StoreShared.SaveJson('maxstock',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('maxstock','0');



        var maxfromlocal='0';
        var maxfromapi=seq.first.salesOrderMax.toString();


        print("sttttttock  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
        {
          StoreShared.SaveJson('maxstock',maxfromlocal.toString());
          max=int.parse(maxfromlocal.toString());

        }
        else
        {
          StoreShared.SaveJson('maxstock',maxfromapi.toString());
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


        var maxfromlocal='0';

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('maxstock',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal='0';

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('maxstock',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maxstock");

    }

    print(max.toString() + "maaaax");

    return max;
    throw "Unable to retrieve Invoices.";
  }


  static Future<int> GetMaxREQpermision (BuildContext context) async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var max=0;
    try{
      final handler = DatabaseHandler();

      Uri apiUrl = Uri.parse(Globalvireables.GetMaxInvoice);

      var map = new Map<String, dynamic>();
      map['ManId'] ='2';
      map['type'] = 'maxreqpermision';

      http.Response res = await http.post(
          apiUrl,
          body:map
      );

      if (res.statusCode == 200) {

        List<dynamic> body = jsonDecode(res.body);
        List<Sequences> seq = body.map((dynamic item) => Sequences.fromJson(item),)  .toList();


        print("maxstock " + body.toString());
        print("input " + map.toString());



        if(seq.first.salesOrderMax.toString()!='0')
          StoreShared.SaveJson('maxstock',seq.first.salesOrderMax.toString());
        else
          StoreShared.SaveJson('maxstock','0');



        var maxfromlocal=await handler.getMaxPerRequest(context);



        var maxfromapi=seq.first.salesOrderMax.toString();




        print("sttttttock  " + maxfromapi.toString());


        if(int.parse(maxfromlocal.toString())>double.parse(maxfromapi))
        {
          StoreShared.SaveJson('maxstock',maxfromlocal.toString());
          max=int.parse(maxfromlocal.toString());

        }
        else
        {
          StoreShared.SaveJson('maxstock',maxfromapi.toString());
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


        var maxfromlocal='0';

        print("reponceapppp"+maxfromlocal.toString());


        StoreShared.SaveJson('maxstock',maxfromlocal.toString());
        max=int.parse(maxfromlocal.toString());


      }}catch(e){

      print(e.toString() + "errrrror");


      var maxfromlocal='0';

      print(maxfromlocal.toString() + "maaaax");


      StoreShared.SaveJson('maxstock',maxfromlocal.toString());
      max=int.parse(maxfromlocal.toString());
      print(max.toString() + "maxstock");

    }

    print(max.toString() + "maaaax");

    return max;
    throw "Unable to retrieve Invoices.";
  }




}