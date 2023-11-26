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
import '../Models/CustomerLocationModel.dart';
import '../Models/CustomerinitModel.dart';
import '../Models/CustomersModel.dart';
import '../Models/Locationn.dart';
import '../Models/ManLogTransModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/GettAllData.dart';
import '../widget/Widgets.dart';
import 'CustomerLocation.dart';
import 'Home.dart';
import 'Invoice.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class CustomerLocation extends StatefulWidget {
  @override
  State<CustomerLocation> createState() => _CustomerLocationState();
}

class _CustomerLocationState extends State<CustomerLocation> {
  final handler = DatabaseHandler();

  List<Widget> listofwidgets = [];

  Timer? timer;
  bool active = false;
  bool IsOpen = false;


  bool IsNew = true;


  String latCustomer = '';
  String longCustomer = '';
  String CustomerId = '';

  String CustomerName = '';
  String CustomerIDdatabase = '';
  String CustomerLimite = '';
  String Receivables = '';

  List<CustomerLocationModel> customerloc = [];

  var Currentlat='';
  var Currentlong='';


  @override
  void initState() {
    getCurrentpostion();

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

/////////////////////

  String? CustNo;
  String? ManNo;
  String? CustName;
  String? Lat_X;
  String? Lat_Y;
  String? Locat;
  String? MobileNo;
  String? Note;
  String? Tr_Date;
  String? PersonNm;
  String? posted;

  /////////////////////
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
                LanguageProvider.Llanguage('customerlocationn'),
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





                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                    LanguageProvider.Llanguage(
                                        'selectcustomer'),
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
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
                                                                    CustomerLocationModel>>
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            List<CustomerLocationModel>?
                                                            CustomerInventory =
                                                                snapshot
                                                                    .data;

                                                            List<CustomerLocationModel>? search = CustomerInventory!
                                                                .where((element) =>
                                                            element
                                                                .CustName
                                                                .toString()
                                                                .contains(searchordercontroller.text
                                                                .toString()) ||
                                                                element
                                                                    .CustName
                                                                    .toString()
                                                                    .contains(searchordercontroller.text.toString()))
                                                                .toList();

                                                            return ListView(
                                                              children: search!
                                                                  .map((CustomerLocationModel v) => Column(
                                                                children: [
                                                                  Card(
                                                                    child: GestureDetector(
                                                                      onTap: () {
dateinput.text=v.CustName.toString()
;                                                                        customerloc.add(new CustomerLocationModel(
                                                                          id:v.id,
                                                                          CustNo: v.CustNo.toString(),
                                                                          ManNo: Loginprovider.getid().toString(),
                                                                          CustName: v.CustName.toString(),
                                                                          Lat_X: Currentlat,
                                                                          Lat_Y: Currentlong,
                                                                          Locat: '',
                                                                          MobileNo: '',


                                                                          Note: '',
                                                                          Tr_Date: v.Tr_Date.toString(),
                                                                          PersonNm: '',
                                                                          posted: '0',
                                                                        ));



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
                                                                                    v.CustName.toString(),
                                                                                    style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 18 * unitHeightValue : 13 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                  ),
                                                                                ),

                                                                                Spacer(),
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width / 5.5,
                                                                                  child: Text(
                                                                                    v.posted.toString()=='0'?'غير معتمد':'معتمد',
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
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.4,
                                child: SizedBox(
                                  child: TextField(
                                    controller: dateinput,
                                    //editing controller of this TextField
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Iconsax.user_tick,
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
                                                      'selectcustomer')) ||
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
                                          "selectcustomer"),
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
                                                          future: getCustomers(),
                                                          builder: (BuildContext
                                                          context,
                                                              AsyncSnapshot<
                                                                  List<
                                                                      CustomersModel>>
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<CustomersModel>?
                                                              Visits =
                                                                  snapshot
                                                                      .data;

                                                              List<CustomersModel>? search = Visits!
                                                                  .where((element) =>
                                                              element
                                                                  .branchname
                                                                  .toString()
                                                                  .contains(searchscustomerscontroller.text
                                                                  .toString()) ||
                                                                  element
                                                                      .customerid
                                                                      .toString()
                                                                      .contains(searchscustomerscontroller.text.toString()))
                                                                  .toList();

                                                              return ListView(
                                                                children: search!
                                                                    .map((CustomersModel v) => Column(
                                                                  children: [
                                                                    Card(
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          dateinput.text=v.branchname.toString();

                                                                          IsNew=true;

                                                                          customerloc.add(new CustomerLocationModel(
                                                                            CustNo: v.customerid.toString(),
                                                                            ManNo: Loginprovider.getid().toString(),
                                                                            CustName: v.branchname.toString(),
                                                                            Lat_X: Currentlat,
                                                                            Lat_Y: Currentlong,
                                                                            Locat: '',
                                                                            MobileNo: '',


                                                                            Note: '',
                                                                            Tr_Date: DateTime.now().toString().substring(0, 16),
                                                                            PersonNm: '',
                                                                            posted: '0',
                                                                          ));


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
                                                                                      v.branchname.toString(),
                                                                                      style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 20 * unitHeightValue : 15 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                    ),
                                                                                  ),
                                                                                  Spacer(),
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width / 5.5,
                                                                                    child: Text(
                                                                                      v.customerid.toString(),
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
                            ],
                          ),

                  Align(
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
    IsNew? LanguageProvider.Llanguage('save'):LanguageProvider.Llanguage('post'),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color:
                                      HexColor(Globalvireables.white),
                                      fontSize: 13 * unitHeightValue),
                                ),
                                onPressed: () async {
if(IsNew){

  SaveCustomer();

}else{

  PostCustomer();

}

                                },
                              ),
                            ),
                          ),


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


  getCurrentpostion() async {
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


  Future<List<CustomerLocationModel>> getCustomersInit() async {
    var handler = DatabaseHandler();
    List<CustomerLocationModel> users=[];
    try {
      users = await handler.retrievCustomerLocation();

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



  Future<List<CustomersModel>> getCustomers() async {
    var handler = DatabaseHandler();
    List<CustomersModel> users=[];
    try {
      List<Locationn> locations = [];
      users = await handler.retrievebranches();



      print("getCustomersWORK1");


      print("getCustomersWORK");


      print(users.first.branchname.toString() + "   branchnameBBBB");

      /* for (int i = 0; i < users.length; i++) {
        if (users[i].locx.toString() != 'null' &&
            users[i].locy.toString() != 'NULL')
          locations.add(new Locationn(
              double.parse(users[i].locx.toString()),
              double.parse(users[i].locy.toString()),
              users[i].branchname.toString()));
      }*/

      //GetShortestDistance(locations);

      try {
        for (int i = 0; i < users.length; i++) {
          if (users[i].locx.toString().length > 4 &&
              users[i].locy.toString().length > 4)
            locations.add(new Locationn(
                double.parse(users[i].locx.toString()),
                double.parse(users[i].locy.toString()),
                users[i].branchname.toString()));
        }

        print("Locationlength : " + locations.length.toString());
      } catch (e) {
        print("ERRORR1 : " + e.toString());
      }


      print("thisisiteeem : " + users.first.customerid.toString());
      return users;
    } catch (e) {
      print(e.toString() + " ERRORSQKKL");
    }
    return users;
  }


  SaveCustomer() async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);


    final handler = DatabaseHandler();
    await Future.delayed(Duration(seconds: 1));






    var ggg=await  handler.addCustomerLocation(customerloc);

    if(int.parse(ggg.toString())>0){
      customerloc.clear();
      dateinput.clear();
    }


  }

  PostCustomer(){

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    final handler = DatabaseHandler();

    print("CustomerIDdatabase "+CustomerIDdatabase);

    PostAllData.PostCustomerLOCATION(context,customerloc[0].id.toString(),
    customerloc[0].CustNo.toString(),
'',
    customerloc[0].CustName.toString(),
    Currentlat.toString(),
    Currentlong.toString(),
        ' ',
        ' ',
    customerloc[0].Tr_Date.toString(),
        '',
        '',
        '1',

    );

    dateinput.clear();


  }
}
