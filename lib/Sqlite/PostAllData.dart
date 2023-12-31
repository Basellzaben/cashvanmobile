
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
      map['type'] = 'PostInv';

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


  static PostReturnInvoice(BuildContext context,String json) async {
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
      map['type'] = 'PostReturnRequest';



      http.Response res = await http.post(
        apiUrl,
        body: map,
      );


      if (res.statusCode == 200) {
        print("OUTPUT : "+res.body);
        List< dynamic> data = jsonDecode(res.body);
        double transID = data[0]["transID"];
        print("transID : "+transID.toString());


        if(transID>0) {
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

  static PostSupply(BuildContext context,String json) async {


    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('SupplyDocument')),
                content: Text(LanguageProvider.Llanguage('loading')),
              ));

      Uri apiUrl = Uri.parse(Globalvireables.PostInvoiceAPI);

      var map = new Map<String, dynamic>();
      map['JsonStr'] = json;
      map['type'] = 'Postsupply';



      http.Response res = await http.post(
        apiUrl,
        body: map,
      );


      if (res.statusCode == 200) {
        print("OUTPUT : "+res.body);
        List< dynamic> data = jsonDecode(res.body);

        double transID = double.parse(data[0]["transID"].toString());

        print("transID : "+transID.toString());


        if(transID>0) {
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

  static PostStock(BuildContext context,String id) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      var handler = DatabaseHandler();
      var json=await handler.retrieveSTOCKposted(id);
      if(json.toString().length>20){
        print(json+"   thisisjsooon");

        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('CustomerInventory')),
                  content: Text(LanguageProvider.Llanguage('loading')),
                ));


        Uri apiUrl = Uri.parse(Globalvireables.PostAllVisitAPI);



        var map = new Map<String, dynamic>();
        map['JsonStr'] = json;
        map['ProsType'] = 'poststock';





        http.Response res = await http.post(
          apiUrl,
          body: map,
        );


        if (res.statusCode == 200) {
          print("OUTPUT : "+res.body);

          if(res.body.toString().contains('done')){
            handler.updateStockposted(id);
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


  static PostrequestpermisionCustomer(BuildContext context,
      String id , String OrderDesc , String OrderNo ) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    try{
      var handler = DatabaseHandler();
      //var json=await handler.retrieveSTOCKposted(id);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('CustomerInventory')),
                content: Text(LanguageProvider.Llanguage('loading')),
              ));


      Uri apiUrl = Uri.parse(Globalvireables.PostCustomerPermisionAPI);


      var map = new Map<String, String>();
      map['ManNo'] = Loginprovider.getid().toString();
      map['OrderNo'] =OrderNo;
      map['OrderDesc'] =OrderDesc;
      print("input : "+map.toString());




      http.Response res = await http.post(
        apiUrl,
        body: map,
      );


      if (res.statusCode == 200) {
        print("OUTPUTddonneen : "+res.body);

        if(res.body.toString().contains('done')){
          handler.updateCustomerrequestpostInit(id);
        }
        Navigator.pop(context);

      } else {
        print("OUTPUT : "+res.statusCode.toString());

        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('anerror')),
                  content: Text(LanguageProvider.Llanguage('anerrortitle')),
                ));
      }}catch(e){

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
  static PostCustomer(BuildContext context,
      String id,
      String CusName,
      String OrderNo,
      String Area,
      String CustType,
      String Mobile,
      String Acc,
      String Lat,
      String Lng,
      String GpsLocation,
      String COMPUTERNAME,
      String UserID,
      ) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      var handler = DatabaseHandler();
      //var json=await handler.retrieveSTOCKposted(id);

        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('CustomerInventory')),
                  content: Text(LanguageProvider.Llanguage('loading')),
                ));


        Uri apiUrl = Uri.parse(Globalvireables.PostCustomerAPI);


        var map = new Map<String, String>();
        map['CusName'] = CusName;
        map['OrderNo'] ='6565';
        map['Area'] =Area;
        map['CustType'] ='1';
        map['Mobile'] =Mobile;
        map['Acc'] ='1';
        map['Lat'] =double.parse(Lat.toString()).toStringAsFixed(3);
        map['Lng'] =double.parse(Lng.toString()).toStringAsFixed(3);
        map['GpsLocation'] =GpsLocation;
        map['COMPUTERNAME'] ='phone';
        map['UserID'] =UserID;

      print("input : "+map.toString());




        http.Response res = await http.post(
          apiUrl,
          body: map,
        );


        if (res.statusCode == 200) {
          print("OUTPUTddonneen : "+res.body);
          Navigator.pop(context);

          if(res.body.toString().contains('done')){
            handler.updateCustomerInit(id);

            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      title: Text( LanguageProvider.Llanguage('addcustomer'),),
                      content: Text('تم تعريف العميل بنجاح'),
                    ));
          }else  if(res.body.toString().contains('prosss')){
            showDialog(
                context: context,
                builder: (_) =>
                    AlertDialog(
                      title: Text( LanguageProvider.Llanguage('addcustomer'),),
                      content: Text('الطلب تحت المعالجه'),
                    ));
          }

        } else {
          print("OUTPUT : "+res.statusCode.toString());

          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(LanguageProvider.Llanguage('anerror')),
                    content: Text(LanguageProvider.Llanguage('anerrortitle')),
                  ));
        }}catch(e){

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



  static PostCustomerLOCATION(BuildContext context,String id,
      String CustNo,
      String ManNo,
      String CustName,
      String Lat_X,
      String Lat_Y,
      String Locat,
      String Note,
      String Tr_Date,
      String PersonNm,
      String MobileNo,
      String Stutes,
      ) async {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    var LanguageProvider = Provider.of<Language>(context, listen: false);
    try{
      var handler = DatabaseHandler();
      //var json=await handler.retrieveSTOCKposted(id);

      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text(LanguageProvider.Llanguage('customerlocationn')),
                content: Text(LanguageProvider.Llanguage('loading')),
              )
      );

      Uri apiUrl = Uri.parse(Globalvireables.PostCustomerlocationAPI);


      print("CustomerIDdddd    "+CustNo);
      //print("Lat_X    "+double.parse(Lat_Y.toString()).toStringAsFixed(3).toString());
     // print("Lat_Y    "+double.parse(Lat_Y.toString()).toStringAsFixed(3).toString());



      var map = new Map<String, String>();
      map['CustNo'] = CustNo.toString();
      map['ManNo'] =Loginprovider.getid().toString();
      map['CustName'] =CustName.toString();
       map['Lat_X'] =double.parse(Lat_X.toString()).toStringAsFixed(3).toString();
      map['Lat_Y'] =double.parse(Lat_Y.toString()).toStringAsFixed(3).toString();
      map['Locat'] ='locat';
      map['Note'] ='--ssesz-';
      map['Tr_Date'] =Tr_Date.toString().substring(0,10);
      map['PersonNm'] =Loginprovider.getnameE().toString();
      map['MobileNo'] ='0';
      map['Stutes'] ='1';

      print("input : "+map.toString());

      http.Response res = await http.post(
        apiUrl,
        body: map,
      );

      if (res.statusCode == 200) {
        print("OUTPUTddonneen : "+res.body);

        if(res.body.toString().contains('done')){
          handler.updateCustomerLocation(id);
        }
        Navigator.pop(context);

      } else {
        print("OUTPUT : "+res.statusCode.toString());

        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(LanguageProvider.Llanguage('anerror')),
                  content: Text(LanguageProvider.Llanguage('anerrortitle')),
                ));
      }}catch(e){

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