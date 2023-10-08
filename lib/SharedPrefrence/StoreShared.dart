import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class StoreShared{


 static SaveJson(String key ,String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json);
  }


 static getJson(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key)??'';
    return stringValue;
  }



 static  checkNetwork() async {
   bool isConnected = false;
   try {
     final result = await InternetAddress.lookup('google.com');
     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       isConnected = true;
     }
   } on SocketException catch (_) {
     isConnected = false;
   }
   return isConnected;
 }

}