import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math' as math;

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController dateinput = TextEditingController();
  var HospitLProvider;
  @override
  Widget build(BuildContext context) {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

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
    icon: Icon(Icons.person),
    label: LanguageProvider.Llanguage('profile')),
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

                              },
                              child: Container(
                                width: 33 * unitHeightValue,
                                height: 33 * unitHeightValue,
                                child:   SvgPicture.asset("assets/user.svg",color: HexColor(ThemP.getcolor()),
                                  height: 30 * unitHeightValue,
                                  width: 30 * unitHeightValue,
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
                            GestureDetector(
                              onTap: () {

                              },
                              child: Icon(
                                Icons.notifications,
                                color: HexColor(ThemP.getcolor()),
                                size: 33 * unitHeightValue,
                              ),
                            )
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
                                LanguageProvider.Llanguage("AlEsraaHospital"),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.black2),
                                    fontSize: 22 * unitHeightValue,
                                    fontWeight: FontWeight.w700)
                            ),


                          ),
                        ),

                        SizedBox(height: 5,),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {



                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
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
                                      LanguageProvider.Llanguage("Appoiments"),


                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),
                            Spacer(),

                            GestureDetector(
                              onTap: () {

                              },
                              child: Column(
                                children: [


                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
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
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {



                              },


                              child: Column(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
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
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )


                                  ),
                                ],
                              ),
                            ),
                          ],),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {


                              },
                              child: Column(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/Insurance.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("Insurance"),


                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )


                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {



                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/VitalSigns.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("Vitalsigns"),

                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )

                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {


                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/Medical.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("Prescription"),

                                      style: ArabicTextStyle(

                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )


                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {


                              },
                              child: Column(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/Checkup.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("examination"),

                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {


                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/Medical_In.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("drugH"),

                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),

                            Spacer(),

                            GestureDetector(
                              onTap: () async {



                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: HexColor(ThemP.getcolor())),
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        4.5,
                                    child: Column(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset("assets/medicalreport.svg",color: HexColor(ThemP.getcolor()),
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
                                      LanguageProvider.Llanguage("medicalreport"),

                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: HexColor(ThemP.getcolor()),
                                          fontSize: 13 * unitHeightValue,
                                          fontWeight: FontWeight.w700
                                      )



                                  ),
                                ],
                              ),
                            ),



                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),



                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                LanguageProvider.Llanguage("Top"),
                                style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.black2),
                                    fontSize: 20 * unitHeightValue,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {

                              },
                              child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  LanguageProvider.Llanguage("SeeAll"),
                                  style: ArabicTextStyle(
                                    arabicFont: ArabicFont.tajawal,
                                    color: HexColor(Globalvireables.grey),
                                    fontSize: 16 * unitHeightValue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),







                        SizedBox(
                          height: 10,
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
    Home(),
    Home(),
    Home(),
  ];



}
