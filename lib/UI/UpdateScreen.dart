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

import '../Calculator.dart';
import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/CustomersModel.dart';
import '../Models/Locationn.dart';
import '../Models/OpenRoundModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/GettAllData.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }




  bool checkusers=false;
  bool checkcustomers=false;
  bool checkbrances=false;


  @override
  Widget build(BuildContext context) {
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
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(ThemP.getcolor()),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: LanguageProvider.Llanguage('settings'),
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('openvisit'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,

          body: Directionality(
            textDirection: LanguageProvider.getDirection(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor((Globalvireables.secondcolor)),
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children:[

   /* bool checkusers=false;
    bool checkcustomers=false;
    bool checkbrances=false;
*/
    Row(children: [

                            Row(
                              children: [
                                Checkbox(
                                    value: checkusers,
                                    //set variable for value
                                    onChanged: (bool? value) async {

                                     // if(!checkusers)


                                      setState(() {
                                        checkusers=!checkusers;
                                      });
                                    }),
                                Text(
                                   'المستخدمين',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 17 * unitHeightValue
                                            : 12 * unitHeightValue)),
                              ],
                            ),


      Row(
        children: [
          Checkbox(
              value: checkbrances,
              //set variable for value
              onChanged: (bool? value) async {

setState(() {
  checkbrances = !checkbrances;

});

              }),
          Text(
              'الافرع',
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize:
                  Globalvireables.getDeviceType() ==
                      'tablet'
                      ? 17 * unitHeightValue
                      : 12 * unitHeightValue)
          ),
        ],
      ),

                          ],),


                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              width:
                              MediaQuery.of(context).size.width / 1.2,
                              margin: EdgeInsets.only(top: 40, bottom: 5),
                              color: HexColor(Globalvireables.white),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor(ThemP.getcolor()),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    )),
                                child: Text(
                                  LanguageProvider.Llanguage('update'),

                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color:
                                      HexColor(Globalvireables.white),
                                      fontSize: Globalvireables
                                          .getDeviceType() ==
                                          'tablet'
                                          ? 21 * unitHeightValue
                                          : 16 * unitHeightValue),
                                ),
                                onPressed: ()  async {


                                  if(checkbrances)
                                    await  GettAllData.GetAllBranches(context);
                                  if(checkusers)
                                  await GettAllData.GetAllUser(context);


                               //   await Future.delayed(Duration(seconds: 1));


                                  setState(() {});
                                },
                              ),
                            ),
                          )





                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    ]);
  }

  _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });
    }
  }

  int selectedIndex = 1;

  final List<Widget> nav = [
    Settings(),
    Home(),
    UpdateScreen(),
  ];

}
