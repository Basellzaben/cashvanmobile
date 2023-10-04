import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cashvanmobile/Calculator.dart';
import 'package:cashvanmobile/UI/Invoice.dart';
import 'package:cashvanmobile/UI/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'dart:math' as math;

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/CustomersModel.dart';
import '../Models/Locationn.dart';
import '../Models/OpenRoundModel.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/RoundProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
import 'MapScreen.dart';
import 'Settings.dart';
import 'UpdateScreen.dart';
import 'Visits.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var timer;
  var StringTimer;

  @override
  void initState() {


    //GetRounddata();
    //timer = Timer.periodic(Duration(seconds: 1),
    //(Timer t) => GetRounddata());


    //GetCustomers();
    super.initState();
  }
var IsOpen=false;
var CustomerName='';
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController dateinput = TextEditingController();
  var HospitLProvider;
  @override
  Widget build(BuildContext context) {

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var roundpr = Provider.of<RoundProvider>(context, listen: false);

    var ThemP = Provider.of<Them>(context, listen: false);

    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.00122;
    var LanguageProvider = Provider.of<Language>(context, listen: false);



    var stops = [0.0, 1.00];
    return Stack(children: <Widget>[
    Image.asset(
    "assets/background.png",
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      fit: BoxFit.cover,
    ),
    Scaffold(
    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    elevation: 8,
    selectedItemColor: HexColor(Globalvireables.white),
    unselectedItemColor: Colors.white,
    backgroundColor: HexColor(ThemP.getcolor()),
    items: [
    BottomNavigationBarItem(
    icon: Icon(Icons.settings,),
    label: LanguageProvider.Llanguage('settings',),
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: LanguageProvider.Llanguage('Home')),
    BottomNavigationBarItem(
    icon: Icon(Icons.inventory_2_outlined),
    label: LanguageProvider.Llanguage('Invoices')),
    ],
    iconSize: 30 * unitHeightValue,
    unselectedFontSize: 12 * unitHeightValue,
    selectedFontSize: 16 * unitHeightValue,
    showUnselectedLabels: true,
    currentIndex: selectedIndex,
    selectedIconTheme:
    IconThemeData(color: HexColor(Globalvireables.white)),
    onTap: _onItemTapped,
    ),
    backgroundColor: HexColor(ThemP.getcolor()),
    //backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor((Globalvireables.white)),
                  HexColor((ThemP.getcolor()))
                ],
                stops: stops,
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Container(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.24,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      image: AssetImage("assets/background.png"),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(29.0),
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(29.0)),
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                GetCustomers();
                              },
                              child: Container(
                                width: 44 * unitHeightValue,
                                height: 44 * unitHeightValue,
                                child:   SvgPicture.asset("assets/user.svg",color: HexColor(ThemP.getcolor()),
                                  height: 40 * unitHeightValue,
                                  width: 40 * unitHeightValue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.6
                              ,child: Text(
                              LanguageProvider.getLanguage() == "AR"
                                  ? Loginprovider.getnameA()
                                  : Loginprovider.getnameE(),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: HexColor(Globalvireables.black2),
                                  fontSize: 19 * unitHeightValue,
                                  fontWeight: FontWeight.w700),
                            ),),
                            Spacer(),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {

                          },
                          child: Container(
                            alignment: LanguageProvider.Align(),

                            child: Text(
                                LanguageProvider.Llanguage("galaxycasgvan"),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.black2),
                                    fontSize: 22 * unitHeightValue,
                                    fontWeight: FontWeight.w900)
                            ),


                          ),
                        ),
                        IsOpen?Row(
                          children: [
                            Container(
                              alignment: LanguageProvider.Align(),

                              child: Text(
                                'زياره مفتوحه لـ ',
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: HexColor(Globalvireables.black2),
                                      fontSize: 18 * unitHeightValue,
                                      fontWeight: FontWeight.w700)
                              ),


                            ),
                            Container(
                              alignment: LanguageProvider.Align(),

                              child: Text(
                                CustomerName,
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: Colors.green,
                                      fontSize: 20 * unitHeightValue,
                                      fontWeight: FontWeight.w900)
                              ),


                            ),
                          ],
                        ):Container(),





                        SizedBox(height: 5,),
                        SizedBox(
                          height: 15,
                        ),
                       Globalvireables.getDeviceType()=='tablet'? Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () async {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Visits()),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/Dates.svg",color: HexColor(ThemP.getcolor()),
                                          height: 50 * unitHeightValue,
                                          width: 50 * unitHeightValue,
                                        ),

                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      LanguageProvider.Llanguage("openvisit"),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize:

                                          Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: ()  {

                              //
                                if(IsOpen){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Invoice()),);
                                }else{
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          AlertDialog(
                                            title: Text(LanguageProvider.Llanguage('Invoices')),
                                            content: Text(LanguageProvider.Llanguage('selectvisitno')),
                                          ));
                                }


                              },
                              child: Column(
                                children: [


                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/invoices.svg",color: HexColor(ThemP.getcolor()),
                                          height: 50 * unitHeightValue,
                                          width: 50 * unitHeightValue,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      LanguageProvider.Llanguage("Invoices"),


                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize:                                           Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,

                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UpdateScreen()),
                                );


                              },


                              child: Column(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/xray.svg",color: HexColor(ThemP.getcolor()),
                                          height: 50 * unitHeightValue,
                                          width: 50 * unitHeightValue,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      LanguageProvider.Llanguage("Ray"),


                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize:Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,

                                          fontWeight: FontWeight.w700
                                      )


                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UpdateScreen()),
                                );


                              },


                              child: Column(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        6:MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/xray.svg",color: HexColor(ThemP.getcolor()),
                                          height: 50 * unitHeightValue,
                                          width: 50 * unitHeightValue,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      LanguageProvider.Llanguage("Ray"),


                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize:Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,

                                          fontWeight: FontWeight.w700
                                      )


                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],):


                       Row(
                         children: [
                           Spacer(),
                           GestureDetector(
                             onTap: () async {

                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => Visits()),
                               );
                             },
                             child: Column(
                               children: [
                                 Container(
                                   decoration: BoxDecoration(
                                     border: Border.all(color: HexColor(ThemP.getcolor())),
                                     borderRadius: BorderRadius.circular(15.0),

                                   ),
                                   width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   child: Column(
                                     children: [
                                       Spacer(),
                                       SvgPicture.asset("assets/visits.svg",color: HexColor(ThemP.getcolor()),
                                         height: 50 * unitHeightValue,
                                         width: 50 * unitHeightValue,
                                       ),

                                       Spacer(),
                                     ],
                                   ),
                                 ),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                     LanguageProvider.Llanguage("openvisit"),
                                     style: ArabicTextStyle(
                                         arabicFont: ArabicFont.tajawal,
                                         color: HexColor(ThemP.getcolor()),
                                         fontSize:

                                         Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,
                                         fontWeight: FontWeight.w700
                                     )



                                 ),
                               ],
                             ),
                           ),
                           Spacer(),
                           Spacer(),
                           GestureDetector(
                             onTap: () {
                               if(IsOpen){
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => Invoice()),);
                               }else{
                                 showDialog(
                                     context: context,
                                     builder: (_) =>
                                         AlertDialog(
                                           title: Text(LanguageProvider.Llanguage('Invoices')),
                                           content: Text(LanguageProvider.Llanguage('selectvisitno')),
                                           actions: [
                                             TextButton(
                                               //  textColor: Colors.black,
                                               onPressed: () {
                                                 Navigator.of(context).pop();

                                                 Navigator.push(
                                                   context,
                                                   MaterialPageRoute(builder: (context) => Visits()),
                                                 );
                                               },
                                               child: Text(
                                                 LanguageProvider.Llanguage('openvisit'),
                                                 style: ArabicTextStyle(
                                                     arabicFont: ArabicFont.tajawal,
                                                     color: Colors.redAccent,
                                                     fontSize: 15 *
                                                         unitHeightValue),
                                               ),
                                             ),
                                             TextButton(
                                               // textColor: Colors.black,
                                               onPressed: () {
                                                 Navigator.of(context).pop();


                                               },
                                               child: Text(
                                                 LanguageProvider.Llanguage('cancel'),
                                                 style: ArabicTextStyle(
                                                     arabicFont: ArabicFont.tajawal,
                                                     color: Colors.black87,
                                                     fontSize: 15 *
                                                         unitHeightValue),
                                               ),
                                             ),
                                           ],
                                         ));
                               }
                             },
                             child: Column(
                               children: [


                                 Container(
                                   decoration: BoxDecoration(
                                     border: Border.all(color: HexColor(ThemP.getcolor())),
                                     borderRadius: BorderRadius.circular(15.0),

                                   ),
                                   width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   child: Column(
                                     children: [
                                       Spacer(),
                                       SvgPicture.asset("assets/invoices.svg",color: HexColor(ThemP.getcolor()),
                                         height: 50 * unitHeightValue,
                                         width: 50 * unitHeightValue,
                                       ),
                                       Spacer(),
                                     ],
                                   ),
                                 ),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                     LanguageProvider.Llanguage("Invoices"),


                                     style: ArabicTextStyle(
                                         arabicFont: ArabicFont.tajawal,
                                         color: HexColor(ThemP.getcolor()),
                                         fontSize:                                           Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,

                                         fontWeight: FontWeight.w700
                                     )



                                 ),
                               ],
                             ),
                           ),
                           Spacer(),
                           Spacer(),
                           GestureDetector(
                             onTap: () async {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => UpdateScreen()),
                               );


                             },


                             child: Column(
                               children: [

                                 Container(
                                   decoration: BoxDecoration(
                                     border: Border.all(color: HexColor(ThemP.getcolor())),
                                     borderRadius: BorderRadius.circular(15.0),

                                   ),
                                   width: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   height: Globalvireables.getDeviceType()=='tablet'?MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       6:MediaQuery
                                       .of(context)
                                       .size
                                       .width /
                                       4.5,
                                   child: Column(
                                     children: [
                                       Spacer(),
                                       SvgPicture.asset("assets/xray.svg",color: HexColor(ThemP.getcolor()),
                                         height: 50 * unitHeightValue,
                                         width: 50 * unitHeightValue,
                                       ),
                                       Spacer(),
                                     ],
                                   ),
                                 ),
                                 SizedBox(
                                   height: 5,
                                 ),
                                 Text(
                                     LanguageProvider.Llanguage("Ray"),


                                     style: ArabicTextStyle(
                                         arabicFont: ArabicFont.tajawal,
                                         color: HexColor(ThemP.getcolor()),
                                         fontSize:Globalvireables.getDeviceType()=='tablet'?22 * unitHeightValue:13 * unitHeightValue,

                                         fontWeight: FontWeight.w700
                                     )


                                 ),
                               ],
                             ),
                           ),
                           Spacer(),
                         ],)


                        ,
                        SizedBox(
                          height: 5,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ))
    ,
    ]
    );
  }



  _onItemTapped(int index) {


    if(index != 1){
    setState(() {
      selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nav[index]),
      );
    });}
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    profile(),
  ];





 GetCustomers() async {
   print("SHARED JSON");


   print(await StoreShared.getJson(Globalvireables.CustomerJson));
   var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

   if(await StoreShared.checkNetwork()){
   Uri apiUrl = Uri.parse(Globalvireables.customerAPI);

   var map = new Map<String, dynamic>();

   map['EXCEPTION'] = 'false';
   map['ManId'] = Loginprovider.getid();


   try {
     http.Response res = await http.post(
         apiUrl,
       body: map

     );

     print("statusCode : " + res.statusCode.toString());


     if (res.statusCode == 200) {
      /*  StoreShared.SaveJson(
           Globalvireables.CustomerJson, res.body.toString());*/


     } else {
       throw "Unable to retrieve Doctors. orrr";
     }
   } catch (e) {
     print("ERROR : " + e.toString());
   }
 }else{

     print("NO INTERNET ");

   }
  //  throw "Unable to retrieve Doctors.";
  }


  Future<List<OpenRoundModel>?> GetRounddata() async {
    var roundpr = Provider.of<RoundProvider>(context, listen: false);
try{
    List<dynamic> body =
    jsonDecode(await StoreShared.getJson(Globalvireables.OpenRound));
    List<OpenRoundModel> users = body
        .map(
          (dynamic item) => OpenRoundModel.fromJson(item),
    )
        .toList();


    if (users[0].starttime
        .toString()
        .length > 7) {
      IsOpen = true;
      CustomerName = users[0].englishName.toString();


      String CustomerId = users[0].custId.toString();
      String CustomerLimite = '387';
      String Receivables = '0.0';

      roundpr.setCustomerId(CustomerId);
      roundpr.setCustomerLimite(CustomerLimite);
      roundpr.setReceivables(Receivables);
      roundpr.setCustomerName(CustomerName);
    }


    setState(() {

    });
    return users;
  }catch(_){



}
    return null;

  }




  GetCurrentTime(){

StringTimer= DateTime.now().toString().substring(10, 16);
setState(() {



});
  }


  Future<List<CustomersModel>> getCustomers() async {
    var handler = DatabaseHandler();

    List<Locationn> locations = [];
    List<CustomersModel> users = await handler.retrievebranches();
    print("getCustomersWORK1");

    try {
      print("getCustomersWORK");


      List<CustomersModel> users = await handler.retrievebranches();

      print(users.first.branchName.toString() + "   branchnameBBBB");


      for (int i = 0; i < users.length; i++) {
        if (users[i].locX.toString() != 'null' &&
            users[i].locX.toString() != 'NULL')
          locations.add(new Locationn(
              double.parse(users[i].locX.toString()),
              double.parse(users[i].locY.toString()),
              users[i].branchName.toString()));
      }
      //GetShortestDistance(locations);
      print("thisisiteeem : " + users.first.customerId.toString());
      return users;

    }catch(e){
      print(e.toString()+" ERRORSQKKL");
    }
    return users;
  }




}
