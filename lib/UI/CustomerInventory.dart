import 'dart:async';
import 'dart:convert';
import 'package:arabic_font/arabic_font.dart';
import 'package:cashvanmobile/Sqlite/PostAllData.dart';
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
import '../Models/CountryModel.dart';
import '../Models/CustomerinitModel.dart';
import '../Models/Locationn.dart';
import '../Models/ManLogTransModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/GettAllData.dart';
import '../widget/Widgets.dart';
import 'CustomerInventory.dart';
import 'Home.dart';
import 'Invoice.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class CustomerInventory extends StatefulWidget {
  @override
  State<CustomerInventory> createState() => _CustomerInventoryState();
}

class _CustomerInventoryState extends State<CustomerInventory> {
  final handler = DatabaseHandler();

  List<Widget> listofwidgets = [];

  Timer? timer;
  bool active = false;
  bool IsOpen = false;
var OrderNo='';

  bool IsNew = true;


  String latCustomer = '';
  String longCustomer = '';
  String CustomerId = '';
String post='';
  String CustomerName = '';
  String CustomerIDdatabase = '';
  String CustomerLimite = '';
  String Receivables = '';

  List<ManLogTransModel> Manlogtrans = [];

  var Currentlat='';
  var Currentlong='';


  @override
  void initState() {
    getCurrentpostion();
    GetMax();
    determinePosition();
    super.initState();
  }

  TextEditingController dateinput = TextEditingController();
  TextEditingController searchscustomerscontroller = TextEditingController();
  TextEditingController CustomerPathController = TextEditingController();

  TextEditingController customername = TextEditingController();
  TextEditingController customermobile = TextEditingController();
  TextEditingController customeraddres = TextEditingController();

  TextEditingController searchordercontroller = TextEditingController();


  @override
  void dispose() {
    super.dispose();
  }

  var check = false;
  var check2 = false;

  @override
  Widget build(BuildContext context) {
    var ThemP = Provider.of<Them>(context, listen: false);
    var colors = [
      HexColor((Globalvireables.secondcolor)),
      HexColor((ThemP.getcolor()))
    ];
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
                LanguageProvider.Llanguage('addcustomer'),
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
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    DateTime.now().toString().substring(0, 16),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),

                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                   OrderNo,
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),
                          
                          
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    LanguageProvider.Llanguage(
                                        'selectcity'),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            child: SizedBox(
                              child: TextField(
                                controller: dateinput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_balance,
                                    color: HexColor(ThemP.getcolor()),
                                    size: 27 * unitHeightValue,
                                  ),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          searchscustomerscontroller.clear();
                                        });
                                      },
                                      child: Icon(
                                          color: Colors.redAccent,
                                          dateinput.text.contains(
                                              LanguageProvider.Llanguage(
                                                  'selectcity')) ||
                                              dateinput.text.length != 10
                                              ? null
                                              : Icons.cancel)),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(ThemP.getcolor()),
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  contentPadding: EdgeInsets.only(
                                      top: 18, bottom: 18, right: 20, left: 20),
                                  fillColor: HexColor(Globalvireables.white),
                                  filled: true,
                                  hintText: LanguageProvider.Llanguage(
                                      "selectcity"),
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  IsOpen
                                      ? null
                                      : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Card(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(9.0),
                                            child: Container(
                                              height:
                                              MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  1.2,
                                              width:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: SizedBox(
                                                      child: Text(
                                                          LanguageProvider
                                                              .Llanguage(
                                                              'customers'),
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                              ArabicFont
                                                                  .tajawal,
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .black2),
                                                              fontSize: Globalvireables.getDeviceType() ==
                                                                  'tablet'
                                                                  ? 25 *
                                                                  unitHeightValue
                                                                  : 20 *
                                                                  unitHeightValue,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w900)),
                                                    ),
                                                  ),
                                                  Divider(
                                                      thickness: 1.0,
                                                      color: Colors.grey),
                                                  SizedBox(
                                                    child: TextField(
                                                      onChanged:
                                                          (content) {
                                                        setState(() {});
                                                      },
                                                      controller:
                                                      searchscustomerscontroller,
                                                      //editing controller of this TextField
                                                      decoration:
                                                      InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: HexColor(
                                                              ThemP
                                                                  .getcolor()),
                                                          size: 27 *
                                                              unitHeightValue,
                                                        ),
                                                        suffixIcon:
                                                        GestureDetector(
                                                            onTap:
                                                                () {
                                                              setState(
                                                                      () {
                                                                    searchscustomerscontroller.text =
                                                                    '';
                                                                  });
                                                            },
                                                            child: Icon(
                                                                color: Colors
                                                                    .redAccent,
                                                                searchscustomerscontroller.text.isEmpty || searchscustomerscontroller.text.toString() == LanguageProvider.Llanguage('Search')
                                                                    ? null
                                                                    : Icons.cancel)),
                                                        border:
                                                        OutlineInputBorder(),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width:
                                                                2.0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width:
                                                                2.0),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0)),
                                                        contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            bottom:
                                                            18,
                                                            right: 20,
                                                            left: 20),
                                                        fillColor: HexColor(
                                                            Globalvireables
                                                                .white),
                                                        filled: true,
                                                        hintText:
                                                        LanguageProvider
                                                            .Llanguage(
                                                            "Search"),
                                                      ),
                                                      //a  readOnly: true,  //set it true, so that user will not able to edit text
                                                      onTap: () async {
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height /
                                                        1.6,
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width /
                                                        1.1,
                                                    child: FutureBuilder(
                                                      future:  getCustomers(),
                                                      builder: (BuildContext
                                                      context,
                                                          AsyncSnapshot<
                                                              List<
                                                                  CountryModel>>
                                                          snapshot) {
                                                        if (snapshot
                                                            .hasData) {
                                                          List<CountryModel>?
                                                          CustomerInventory =
                                                              snapshot
                                                                  .data;

                                                          List<CountryModel>? search = CustomerInventory!
                                                              .where((element) =>
                                                          element
                                                              .name
                                                              .toString()
                                                              .contains(searchscustomerscontroller.text
                                                              .toString()) ||
                                                              element
                                                                  .ename
                                                                  .toString()
                                                                  .contains(searchscustomerscontroller.text.toString()))
                                                              .toList();

                                                          return ListView(
                                                            children: search!
                                                                .map((CountryModel v) => Column(
                                                              children: [
                                                                Card(
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                     Manlogtrans.clear();


                                                                      dateinput.text = v.name.toString();

                                                                      CustomerId = v.no.toString();


                                                                      setState(() {});
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: SizedBox(
                                                                          child: Row(
                                                                            children: [
                                                                              Spacer(),
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width / 3,
                                                                                child: Text(
                                                                                  textAlign: TextAlign.center,
                                                                                  v.name.toString(),
                                                                                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 20 * unitHeightValue : 15 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                ),
                                                                              ),
                                                                              Spacer(),
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width / 5.5,
                                                                                child: Text(
                                                                                  v.no.toString(),
                                                                                  style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 18 * unitHeightValue : 13 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                                .toList(),
                                                          );
                                                        } else {
                                                          return Center(
                                                              child:
                                                              CircularProgressIndicator());
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Align(
                                                    child: SizedBox(
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          4,
                                                      child:
                                                      ElevatedButton(
                                                        style:
                                                        ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              ThemP
                                                                  .getcolor()),
                                                        ),
                                                        child: Text(
                                                          LanguageProvider
                                                              .Llanguage(
                                                              'cancel'),
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                              ArabicFont
                                                                  .tajawal,
                                                              color: HexColor(
                                                                  Globalvireables
                                                                      .white),
                                                              fontSize: Globalvireables.getDeviceType() ==
                                                                  'tablet'
                                                                  ? 19 *
                                                                  unitHeightValue
                                                                  : 14 *
                                                                  unitHeightValue),
                                                        ),
                                                        onPressed:
                                                            () async {
                                                          Navigator.of(
                                                              context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                  ,



                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    LanguageProvider.Llanguage(
                                        'customername'),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),

                          Row(
                            children: [
                              Spacer(),
    GestureDetector(
    onTap: () {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return Center(
    child: Card(
    child: Padding(
    padding:
    const EdgeInsets.all(9.0),
    child: Container(
    height:
    MediaQuery.of(context)
        .size
        .height /
    1.2,
    width:
    MediaQuery.of(context)
        .size
        .width /
    1.1,
    child: Column(
    children: [
    Padding(
    padding:
    const EdgeInsets
        .all(8.0),
    child: SizedBox(
    child: Text(
    LanguageProvider
        .Llanguage(
    'customers'),
    style: ArabicTextStyle(
    arabicFont:
    ArabicFont
        .tajawal,
    color: HexColor(
    Globalvireables
        .black2),
    fontSize: Globalvireables.getDeviceType() ==
    'tablet'
    ? 25 *
    unitHeightValue
        : 20 *
    unitHeightValue,
    fontWeight:
    FontWeight
        .w900)),
    ),
    ),
    Divider(
    thickness: 1.0,
    color: Colors.grey),
    SizedBox(
    child: TextField(
    onChanged:
    (content) {
    setState(() {});
    },
    controller:
    searchordercontroller,
    //editing controller of this TextField
    decoration:
    InputDecoration(
    prefixIcon: Icon(
    Icons.search,
    color: HexColor(
    ThemP
        .getcolor()),
    size: 27 *
    unitHeightValue,
    ),
    suffixIcon:
    GestureDetector(
    onTap:
    () {
    setState(
    () {
      searchordercontroller.text =
    '';
    });
    },
    child: Icon(
    color: Colors
        .redAccent,
        searchordercontroller.text.isEmpty || searchordercontroller.text.toString() == LanguageProvider.Llanguage('Search')
    ? null
        : Icons.cancel)),
    border:
    OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: HexColor(
    ThemP
        .getcolor()),
    width:
    2.0),
    borderRadius:
    BorderRadius
        .circular(
    10.0)),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: HexColor(
    ThemP
        .getcolor()),
    width:
    2.0),
    borderRadius:
    BorderRadius
        .circular(
    10.0)),
    contentPadding:
    EdgeInsets.only(
    top: 18,
    bottom:
    18,
    right: 20,
    left: 20),
    fillColor: HexColor(
    Globalvireables
        .white),
    filled: true,
    hintText:
    LanguageProvider
        .Llanguage(
    "Search"),
    ),
    //a  readOnly: true,  //set it true, so that user will not able to edit text
    onTap: () async {
    setState(() {});
    },
    ),
    ),
    SizedBox(
    height: MediaQuery.of(
    context)
        .size
        .height /
    1.6,
    width: MediaQuery.of(
    context)
        .size
        .width /
    1.1,
    child: FutureBuilder(
    future:  getCustomersInit(),
    builder: (BuildContext
    context,
    AsyncSnapshot<
    List<
        CustomerinitModel>>
    snapshot) {
    if (snapshot
        .hasData) {
    List<CustomerinitModel>?
    CustomerInventory =
    snapshot
        .data;

    List<CustomerinitModel>? search = CustomerInventory!
        .where((element) =>
    element
        .OrderNo
        .toString()
        .contains(searchordercontroller.text
        .toString()) ||
    element
        .CusName
        .toString()
        .contains(searchordercontroller.text.toString()))
        .toList();

    return ListView(
    children: search!
        .map((CustomerinitModel v) => Column(
    children: [
    Card(
    child: GestureDetector(
    onTap: () {

      dateinput.text=v.Area.toString();
      customername.text=v.CusName.toString();
      customermobile.text=v.Mobile.toString();
      customeraddres.text=v.GpsLocation.toString();
      CustomerIDdatabase=v.id.toString();

      post=v.posted.toString();

      OrderNo=v.OrderNo.toString();

      IsNew=false;


    setState(() {});
      Navigator.pop(context);

    },
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
    child: Row(
    children: [
    Spacer(),
      Container(
        width: MediaQuery.of(context).size.width / 5.5,
        child: Text(
          v.OrderNo.toString(),
          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 18 * unitHeightValue : 13 * unitHeightValue, fontWeight: FontWeight.w700),
        ),
      ),
    Spacer(),
      SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Text(
          textAlign: TextAlign.center,
          v.CusName.toString(),
          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 20 * unitHeightValue : 15 * unitHeightValue, fontWeight: FontWeight.w700),
        ),
      ),
      Spacer(),
      Container(
        width: MediaQuery.of(context).size.width / 5.5,
        child: Text(
          v.posted.toString()=='-1'?'غير مرحل':'بانتظار الموافقه',
          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: v.posted.toString()=='0'? Colors.redAccent:Colors.green, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 12 * unitHeightValue : 12 * unitHeightValue, fontWeight: FontWeight.w400),
        ),
      ),
    ],
    )),
    ),
    ),
    ),
    ],
    ))
        .toList(),
    );
    } else {
    return Center(
    child:
    CircularProgressIndicator());
    }
    },
    ),
    ),
    Align(
    child: SizedBox(
    width: MediaQuery.of(
    context)
        .size
        .width /
    4,
    child:
    ElevatedButton(
    style:
    ElevatedButton
        .styleFrom(
    primary: HexColor(
    ThemP
        .getcolor()),
    ),
    child: Text(
    LanguageProvider
        .Llanguage(
    'cancel'),
    style: ArabicTextStyle(
    arabicFont:
    ArabicFont
        .tajawal,
    color: HexColor(
    Globalvireables
        .white),
    fontSize: Globalvireables.getDeviceType() ==
    'tablet'
    ? 19 *
    unitHeightValue
        : 14 *
    unitHeightValue),
    ),
    onPressed:
    () async {
    Navigator.of(
    context)
        .pop();
    },
    ),
    ),
    )
    ,



    ],
    ),
    ),
    ),
    ),
    );
    },
    );
    },
                                child: Icon(Icons.arrow_drop_down_circle,
                                size: 35,),
                              ),
                              Spacer(),

                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
width: MediaQuery.of(context).size.width/1.3,
                                    child: TextField(
                                      controller: customername,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor(
                                                    Globalvireables.black),
                                                width: 0.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor(
                                                    ThemP.getcolor()),
                                                width: 1.0),
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        contentPadding: EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            right: 20,
                                            left: 20),
                                        fillColor:
                                        HexColor(Globalvireables.white),
                                        filled: true,
                                        hintText: LanguageProvider.Llanguage(
                                            "customername"),
                                      ),
                                    )),
                              ),

                            ],
                          ),



                          SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    LanguageProvider.Llanguage(
                                        'customerphone'),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(

                                child: TextField(
                                  controller: customermobile,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                Globalvireables.black),
                                            width: 0.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                ThemP.getcolor()),
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                        right: 20,
                                        left: 20),
                                    fillColor:
                                    HexColor(Globalvireables.white),
                                    filled: true,
                                    hintText: LanguageProvider.Llanguage(
                                        "customerphone"),
                                  ),
                                )),
                          ),


                          SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    LanguageProvider.Llanguage(
                                        'customerlocation'),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: HexColor(Globalvireables.black2),
                                        fontSize:
                                        Globalvireables.getDeviceType() ==
                                            'tablet'
                                            ? 18 * unitHeightValue
                                            : 14 * unitHeightValue,
                                        fontWeight: FontWeight.w900)),
                              ),
                              Spacer(),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(

                                child: TextField(
                                  controller: customeraddres,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                Globalvireables.black),
                                            width: 0.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                ThemP.getcolor()),
                                            width: 1.0),
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(
                                        top: 18,
                                        bottom: 18,
                                        right: 20,
                                        left: 20),
                                    fillColor:
                                    HexColor(Globalvireables.white),
                                    filled: true,
                                    hintText: LanguageProvider.Llanguage(
                                        "customerlocation"),
                                  ),
                                )),
                          ),


                          returnfull()? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2.5:
                              MediaQuery.of(context).size.width/1.2,
                              margin: EdgeInsets.only(top: 40, bottom: 5),
                              color: HexColor(Globalvireables.white),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                  HexColor(ThemP.getcolor()),
                                ),
                                child: Text(
    IsNew? LanguageProvider.Llanguage('sendperrequest'):LanguageProvider.Llanguage('post'),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color:
                                      HexColor(Globalvireables.white),
                                      fontSize: 13 * unitHeightValue),
                                ),
                                onPressed: () async {

if(IsNew && returnfull())
   SaveCustomer();
else if(returnfull())
  PostCustomer();


setState(() {

});
                                },
                              ),
                            ),
                          ):Container(),


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
    Invoice(),
  ];



  GetDistance(String latCustomer, String longCustomer) async {
    try {
      print(latCustomer.toString() +
          " : " +
          longCustomer.toString() +
          " latCustomer");

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double long = position.longitude;

      print("Latitude: $lat and Longitude: $long");

      double distanceInMeters = await Geolocator.distanceBetween(
          lat, long, double.parse(lat.toString()), double.parse(longCustomer));

      print((distanceInMeters / 1000).toStringAsFixed(2).toString() +
          " DISTANCE");
      if ((distanceInMeters / 1000) < 100000) active = true;
      setState(() {});
    } catch (e) {
      print("ERROR : " + e.toString());
    }
  }

  determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {

        return Future.error('Location Not Available');

      }
    } else {
      throw Exception('Error');
    }
  }

  GetShortestDistance(List<Locationn> locations) {
    List<String> CustomerLine = [];
    var ThemP = Provider.of<Them>(context, listen: false);

    if (locations.length > 2) {
      List<Locationn> shortestPath = Calculator.nearestNeighbor(locations);

      double totalDistance = 0;
      for (var i = 0; i < shortestPath.length - 1; i++) {
        totalDistance += Calculator.calculateDistance2(shortestPath[i].x,
            shortestPath[i].y, shortestPath[i + 1].x, shortestPath[i + 1].y);
      }

      print('Total distance: $totalDistance');
      //  super.initState();
      print('shortest path algorthim :');
      print("Names" +
          shortestPath.map((location) => '(${location.name})').join(' -> '));
      CustomerPathController.text =
          (shortestPath.map((location) => '(${location.name})').join(' -> ')) +
              "\n";

      print("liiistaaa   :  " + json.encode(listofwidgets).toString());

      listofwidgets.clear();
      for (int i = 0; i < shortestPath.length; i++) {
        listofwidgets.add(new Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0),
                        shape: BoxShape.circle,
                        color: HexColor(ThemP.color),
                      ),
                      child: Center(
                          child: Text(
                            (i + 1).toString(),
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
            ),
            Text(shortestPath[i].name),
          ],
        ));

        setState(() {});
      }

      //  StoreShared.SaveJson(Globalvireables.listofbestline, json.encode(listofwidgets));

      //  const Step(title: Text('Address'), content: Center(child: Text('Address'),)),
    } else {
      print('shortest path algorithm error');
    }
  }

  getCurrentpostion() async {
    GetMax();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    Currentlat=lat.toString();
    Currentlong=long.toString();


    latCustomer = Currentlat.toString();
    longCustomer = Currentlong.toString();


    print("lat : "+Currentlat);
    print("long : "+Currentlong);

  }

  Future<List<CountryModel>> getCustomers() async {
    GetMax();

    var handler = DatabaseHandler();
    List<CountryModel> users=[];
    try {
      users = await handler.retrievCountry();



      print("getCustomersWORK1");


      print("getCustomersWORK");



      try {
      } catch (e) {
      }

      return users;
    } catch (e) {
      print(e.toString() + " ERRORSQKKL");
    }
    return users;
  }

  Future<List<CustomerinitModel>> getCustomersInit() async {
    GetMax();

    var handler = DatabaseHandler();
    List<CustomerinitModel> users=[];
    try {
      users = await handler.retrievCustomerinitModel();

      print("getCustomersWORK1");


      print("getCustomersWORK");



      try {
      } catch (e) {
      }

      return users;
    } catch (e) {
      print(e.toString() + " ERRORSQKKL");
    }
    return users;
  }

  SaveCustomer() async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    GetMax();

  var max=  await GettAllData.GetMaxREQpermision(context);
  OrderNo=max.toString();


 print("OrderNo " +OrderNo.toString());


    setState(() {

    });
    await Future.delayed(Duration(seconds: 1));


    List<CustomerinitModel> c=[];
    c.add(new CustomerinitModel(
      CusName: customername.text,
      OrderNo: OrderNo.toString(),
      Area:dateinput.text,
      CustType: '1',
      Mobile:customermobile.text,
      Acc: '',
      Lat: Currentlat.toString(),
      Lng: Currentlong.toString(),
      GpsLocation: customeraddres.text,
      COMPUTERNAME: 'mobile',
      UserID: Loginprovider.getid().toString(),
      posted: '0'

    ));

   var ggg=await  handler.addCustomerinitModel(c);
    PostRequest(OrderNo.toString());



/*if(int.parse(ggg.toString())>0){
  c.clear();
  dateinput.clear();
  customername.clear();
  customeraddres.clear();
  customermobile.clear();
}*/


  }

  PostCustomer(){
    GetMax();

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    final handler = DatabaseHandler();

    print("CustomerIDdatabase "+CustomerIDdatabase);

    PostAllData.PostCustomer(context,
      CustomerIDdatabase.toString(),
      customername.text,
      '1',
      dateinput.text,
      '1',
      customermobile.text,
      '1',
      Currentlat.toString(),
      Currentlong.toString(),
      customeraddres.text,
      'mobile',
      Loginprovider.getid().toString()
    );
    customername.clear();
    customeraddres.clear();
    customermobile.clear();
dateinput.clear();


  }


  PostRequest(String OrderNo) async {

    GetMax();
    print("CustomerIDdatabase "+CustomerIDdatabase);
    print("customername  "+customername.text);
    print("OrderNo  "+OrderNo);



    PostAllData.PostrequestpermisionCustomer(context,
        CustomerIDdatabase.toString(),
        customername.text+'سام العميل : ',
        OrderNo.toString()
        );
    customername.clear();
    customeraddres.clear();
    customermobile.clear();
    dateinput.clear();


  }


 bool returnfull(){

    if(dateinput.text.isNotEmpty &&
        customername.text.isNotEmpty &&
        customeraddres.text.isNotEmpty &&
        customermobile.text.isNotEmpty )
      return true;
    return false;



  }

  Future GetMax() async {
   var max = await GettAllData.GetMaxREQpermision(context);
   OrderNo=max.toString();
  }
}
