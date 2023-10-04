import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icon_forest/amazingneoicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/CustomersModel.dart';
import '../Models/OpenRoundModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/RoundProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class Invoice extends StatefulWidget {
  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {

  String CustomerId = '';
  String CustomerName = '';
  String CustomerLimite = '';
  String Receivables = '';

  @override
  void initState() {

   // getCustomerData();

    super.initState();
  }




/*  getCustomerData() async {


    CustomerName=await StoreShared.getJson(Globalvireables.CustomerName);
    CustomerId=await StoreShared.getJson(Globalvireables.CustomerId);
    CustomerLimite=await StoreShared.getJson(Globalvireables.CustomerLimite);
    Receivables=await StoreShared.getJson(Globalvireables.Receivables);

    print(CustomerName + "   CustomerName");
  }*/
  @override
  void dispose() {
    super.dispose();
  }

  bool IncludeTex = true;
  bool Cash = true;


  @override
  Widget build(BuildContext context) {
   // getCustomerData();
    var roundpr = Provider.of<RoundProvider>(context, listen: false);

    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          bottomNavigationBar: Container(
            color: HexColor(ThemP.color).withOpacity(0.8),
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                  width: 66,
                  color: HexColor(ThemP.color),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.add, color: Colors.white), Text(LanguageProvider.Llanguage('Add'), style: TextStyle(color: Colors.white))],
                  ),
                ),
                SizedBox(width: 3,),
                Container(
                  width: 90,
                  color: HexColor(ThemP.color),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.all_inclusive, color: Colors.white), Text(LanguageProvider.Llanguage('allInvoices'), style: TextStyle(color: Colors.white))],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: HexColor(ThemP.color).withOpacity(0.8),
                    child: Row(
                  children: [
                    Spacer(),

Spacer(),
                    Text(
                      '245.8',style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                        color: Colors.white,fontWeight: FontWeight.w600),),

                    Text(
                      ' : ',style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                        color: Colors.white,fontWeight: FontWeight.w900),),


                  Text(
                  LanguageProvider.Llanguage('Total'),style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                    color: Colors.white,fontWeight: FontWeight.w500),),



              ],),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
    /*      floatingActionButton: Align(
            alignment: new FractionalOffset(0.55, 1.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: FloatingActionButton(
                backgroundColor: HexColor(Globalvireables.basecolor),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                 // addClasses(context);
                },
              ),
            ),
          ),*/
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('Invoices'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          // backgroundColor: Colors.transparent,

          body: Directionality(
            textDirection: LanguageProvider.getDirection(),

              child: SafeArea(

                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.only(
                                      bottomLeft: Radius.circular(80)),
                                  // if you need this
                                  side: BorderSide(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height,
                                    //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                  ),
                                ),

                                child:Container(
                                  width: MediaQuery.of(context).size.width,

                                  child: Column(children: [

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Invoicesid'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getCustomerId()+"7534",style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('customerid'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getCustomerId(),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),
                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('customername'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getCustomerName(),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Clientceiling'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getCustomerLimite(),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Receivables'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getReceivables(),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(
                                      children: [

                                        Checkbox(
                                            value: Cash,
                                            //set variable for value
                                            onChanged: (bool? value) {
                                              setState(() {
                                                Cash = !Cash;
                                              });
                                            }),
                                        Text("نقدي",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.width > 600?22:15)),
                                        Spacer(),
                                        Checkbox(
                                            value: IncludeTex,
                                            //set variable for value
                                            onChanged: (bool? value) {
                                              setState(() {
                                                IncludeTex =
                                                !IncludeTex;
                                              });
                                            }),
                                        Text("شامل الضريبه",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize:MediaQuery.of(context).size.width > 600?22: 15)),
                                        Spacer(),
                                        Spacer(),
                                        Spacer(),





                                      ],
                                    ),

                                  ],),

                                )

                            ),
                          ),



                        ],
                      ),
                    ),
                ),
              ),
          )),
    ]);
  }





}
