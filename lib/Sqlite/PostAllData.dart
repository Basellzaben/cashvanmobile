
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../Models/CustomersModel.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/languageProvider.dart';
import 'DatabaseHandler.dart';

import 'package:http/http.dart' as http;

class PostAllData {

  static PostAllManVisit(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    try{
      var handler = DatabaseHandler();

      var json=await handler.retrieveAllOpenManVisitssASjson();
      if(json.toString().length>20){
        print(json+"   thisisjsooon");

        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('openvisit')),
                  content: Text(LanguageProvider.Llanguage('loading')),
                ));


        Uri apiUrl = Uri.parse(Globalvireables.PostAllVisitAPI);


        var map = new Map<String, dynamic>();
        map['JsonStr'] = json;
        map['ProsType'] = "postv";

        http.Response res = await http.post(
          apiUrl,
          body: map,
        );


        if (res.statusCode == 200) {
          print("OUTPUT : "+res.body);

          if(res.body.toString().contains('done')){
            handler.updateManVisitsAfterpost();
          }
          Navigator.pop(context);

        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(LanguageProvider.Llanguage('anerror')),
                    content: Text(LanguageProvider.Llanguage('anerrortitle') + " : "+res.statusCode.toString() ),
                  ));
        }}}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('anerror')),
                content: Text(LanguageProvider.Llanguage('anerrortitle')+e.toString()),
              ));


    }

  }
  static PostAllManLongTrans(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      var handler = DatabaseHandler();
      var json=await handler.retrieveAllManLongTransnotposted();
      if(json.toString().length>20){
        print(json+"   thisisjsooon");

        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('openvisit')),
                  content: Text(LanguageProvider.Llanguage('loading')),
                ));


        Uri apiUrl = Uri.parse(Globalvireables.PostAllVisitAPI);



        var map = new Map<String, dynamic>();
        map['JsonStr'] = json;
        map['ProsType'] = 'postlongman';





        http.Response res = await http.post(
          apiUrl,
          body: map,
        );


        if (res.statusCode == 200) {
          print("OUTPUT : "+res.body);

          if(res.body.toString().contains('done')){
            handler.updateManManLogTrans();
          }
          Navigator.pop(context);

        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(LanguageProvider.Llanguage('anerror')),
                    content: Text(LanguageProvider.Llanguage('anerrortitle')),
                  ));
        }}}catch(e){
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('anerror')),
                content: Text(LanguageProvider.Llanguage('anerrortitle')+e.toString()),
              ));


    }

  }

  static PostInvoice(BuildContext context,String json,String OrderNo) async {
    var handler = DatabaseHandler();


    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('openvisit')),
                content: Text(LanguageProvider.Llanguage('loading')),
              ));


      Uri apiUrl = Uri.parse(Globalvireables.PostInvoiceAPI);



      var map = new Map<String, dynamic>();
      map['JsonStr'] = json;

      http.Response res = await http.post(
        apiUrl,
        body: map,
      );


      if (res.statusCode == 200) {
        print("OUTPUT : "+res.body);

        var jsonResponse = jsonDecode(res.body);


        List< dynamic> data = jsonDecode(res.body);
        double transID = data[0]["transID"];

        print("transID : "+transID.toString());


        if(transID>0) {

         handler.updateIncPost(OrderNo);

          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) =>
            new AlertDialog(
              title: new Text(LanguageProvider.Llanguage('done')),
              content: Text(LanguageProvider.Llanguage('donetxt')),
              actions: <Widget>[],
            ),
          );
        }
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('anerror') +res.statusCode.toString()),
                  content: Text(LanguageProvider.Llanguage('anerrortitle')),
                ));
      }}catch(e){

      print(e.toString());

      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('anerror')),
                content: Text(LanguageProvider.Llanguage('anerrortitle')+e.toString()),
              ));


    }

  }


}