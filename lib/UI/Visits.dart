import 'dart:async';
import 'dart:convert';
import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cashvanmobile/Models/ManVisitsModel.dart';
import 'package:cashvanmobile/Models/ManVisitsModel.dart';
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
import '../Models/CustomersModel.dart';
import '../Models/Locationn.dart';
import '../Models/ManLogTransModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/GettAllData.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class Visits extends StatefulWidget {
  @override
  State<Visits> createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
  final handler = DatabaseHandler();

  List<Widget> listofwidgets = [];

  Timer? timer;
  bool active = false;
  bool IsOpen = false;

  String latCustomer = '';
  String longCustomer = '';
  String CustomerId = '';

  String CustomerName = '';
  String CustomerLimite = '';
  String Receivables = '';

  List<ManLogTransModel> Manlogtrans = [];
  List<ManVisitsModel> manvisitsmodel = [];

  var Currentlat='';
  var Currentlong='';


  @override
  void initState() {
    getRoundData();
    getCurrentpostion();
    GettAllData.GetMaxLongTrans(context);
    GettAllData.GetMaxLongTransNo(context);

    determinePosition();
  /*  timer = Timer.periodic(Duration(seconds: 10),
        (Timer t) => PostAllManVisit());*/
/*
    timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => GettAllData.GetMaxLongTrans(context));
    timer = Timer.periodic(Duration(seconds: 2),
        (Timer t) => GettAllData.GetMaxLongTransNo(context));*/
    super.initState();
  }

  TextEditingController dateinput = TextEditingController();
  TextEditingController searchscustomerscontroller = TextEditingController();
  TextEditingController CustomerPathController = TextEditingController();

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
                          SizedBox(
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
                                                            future: check2
                                                                ? getCustomersOnline()
                                                                : getCustomers(),
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
                                                                                    Manlogtrans.clear();
                                                                                    GettAllData.GetMaxLongTrans(context);
                                                                                    GettAllData.GetMaxLongTransNo(context);


                                                                                    
                                                                                    StoreShared.SaveJson('OpenTime', DateTime.now().toString().substring(10,16));

                                                                                    StoreShared.SaveJson('OpendCustomerId', v.customerid.toString());
                                                                                    Manlogtrans.add(new ManLogTransModel(manNo: int.parse(Loginprovider.id), id: Loginprovider.MaxLongstRANS, custNo: int.parse(v.customerid.toString()), screenCode: 1123, actionNo: 18, transNo: (Loginprovider.MaxLongstRANSNo).toString(), transDate: DateTime.now(), tabletId: 'Mobile', batteryCharge: "88", notes: "", posted: 0));
                                                                                    dateinput.text = v.branchname.toString();
                                                                                    latCustomer = v.locx.toString();
                                                                                    longCustomer = v.locy.toString();
                                                                                    CustomerId = v.customerid.toString();
                                                                                    CustomerName = v.branchname.toString();
                                                                                    CustomerLimite = '652';
                                                                                    Receivables = '0.00';
                                                                                    print("Lat and Long : " + latCustomer + " : ");
                                                                                    GetDistance(latCustomer, longCustomer);
                                                                                    setState(() {});
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: SizedBox(
                                                                                        child: Row(
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: MediaQuery.of(context).size.width / 1.4,
                                                                                          child: Text(
                                                                                            textAlign: TextAlign.center,
                                                                                            v.branchname.toString(),
                                                                                            style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 20 * unitHeightValue : 15 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                          ),
                                                                                        ),
                                                                                        Spacer(),
                                                                                        Text(
                                                                                          v.customerid.toString(),
                                                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 18 * unitHeightValue : 13 * unitHeightValue, fontWeight: FontWeight.w700),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: check,
                                  //set variable for value
                                  onChanged: (bool? value) async {
                                    if (!check) check2 = false;

                                    setState(() {
                                      if (!IsOpen) check = !check;
                                    });
                                  }),
                              Text(
                                  LanguageProvider.Llanguage(
                                      "substituteemployee"),
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
                                  value: check2,
                                  //set variable for value
                                  onChanged: (bool? value) async {
                                    if (!check2) check = false;

                                    setState(() {
                                      if (!IsOpen) check2 = !check2;
                                    });
                                  }),
                              Text(
                                  LanguageProvider.Llanguage("Exceptionaltour"),
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
                          (active || IsOpen )
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    margin: EdgeInsets.only(top: 40, bottom: 5),
                                    color: HexColor(Globalvireables.white),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: IsOpen
                                              ? Colors.redAccent
                                              : HexColor(ThemP.getcolor()),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      child: Text(
                                        IsOpen
                                            ? LanguageProvider.Llanguage('end')
                                            : LanguageProvider.Llanguage(
                                                'start'),
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
                                      onPressed: () async {
                                        if (IsOpen) {
                                          CloseVisit();
                                        } else {

                                          //     PostAllData.PostAllManVisit(context);

                                  OpenVisit();
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Center(
                                    child: Text(
                                      LanguageProvider.Llanguage('outRange'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color: Colors.redAccent,
                                          fontSize:
                                              Globalvireables.getDeviceType() ==
                                                      'tablet'
                                                  ? 21 * unitHeightValue
                                                  : 16 * unitHeightValue),
                                    ),
                                  ),
                                ),



                          SizedBox(
                            height: 30,
                          ),
                          listofwidgets.length > 0
                              ? Row(
                                  children: [
                                    SizedBox(
                                      child: Text(
                                          LanguageProvider.Llanguage(
                                              'bestline'),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              color: HexColor(
                                                  Globalvireables.black2),
                                              fontSize: Globalvireables
                                                          .getDeviceType() ==
                                                      'tablet'
                                                  ? 18 * unitHeightValue
                                                  : 14 * unitHeightValue,
                                              fontWeight: FontWeight.w900)),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Expanded(
                                                child: AlertDialog(
                                                  title: Center(
                                                    child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        LanguageProvider
                                                            .Llanguage(
                                                                "bestline"),
                                                        style: ArabicTextStyle(
                                                            arabicFont: ArabicFont
                                                                .tajawal,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16 *
                                                                unitHeightValue)),
                                                  ),
                                                  content: Text(
                                                    LanguageProvider.Llanguage(
                                                        "bestlinedesc"),
                                                    textAlign: TextAlign.center,
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        fontSize: 16 *
                                                            unitHeightValue),
                                                  ),
                                                  actions: [],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.info_outline_rounded,
                                        ))
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: ListView.builder(
                                itemCount: listofwidgets.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return listofwidgets[index];
                                }),
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
    Visits(),
  ];

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
      GetShortestDistance(locations);
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

  Future<List<CustomersModel>> getCustomersOnline() async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    try {
      Uri apiUrl = Uri.parse(Globalvireables.customerAPI);
      List<Locationn> locations = [];

      var map = new Map<String, dynamic>();
      map['EXCEPTION'] = 'true';
      map['ManId'] = Loginprovider.getid();

      print("Input" + map.toString());

      http.Response res = await http.post(
        apiUrl,
        body: map,
      );

      print("Input customer" + res.body.toString());

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<CustomersModel> Invoices = body
            .map(
              (dynamic item) => CustomersModel.fromJson(item),
            )
            .toList();
        try {
          for (int i = 0; i < Invoices.length; i++) {
            if (Invoices[i].locx.toString().length > 4 &&
                Invoices[i].locy.toString().length > 4)
              locations.add(new Locationn(
                  double.parse(Invoices[i].locx.toString()),
                  double.parse(Invoices[i].locy.toString()),
                  Invoices[i].branchname.toString()));
          }

          print("Locationlength : " + locations.length.toString());
          GetShortestDistance(locations);
        } catch (e) {
          print("ERRORR1 : " + e.toString());
        }
        return Invoices;
      } else {
        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }
    } catch (e) {
      print("ERRORR : " + e.toString());
    }
    throw "Unable to retrieve Invoices.";
  }

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

  getRoundData() async {
    try{
      final handler = DatabaseHandler();




    ManVisitsModel manvisitsmodel=await handler.retrieveOpenManVisitss();
    if(manvisitsmodel!=null){
      IsOpen=true;

      dateinput.text = manvisitsmodel.CusName.toString();
      if(manvisitsmodel.isException.toString()=="1")
      check2=true;

      setState(() {
      });

      return manvisitsmodel;

    }else{
      print ("errrrrrrororor");
    }}
    catch(e){

      print ("errrrrrrororor   "+e.toString());

    }

    return null;
   }


   getCurrentpostion() async {
     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     double lat = position.latitude;
     double long = position.longitude;

     Currentlat=lat.toString();
     Currentlong=long.toString();
   }


   CloseVisit() async {
     var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

     IsOpen = false;
     GetDistance(latCustomer, longCustomer);

     Future.delayed(
         const Duration(
             milliseconds: 1000),
             () async {
           await GettAllData.GetMaxLongTrans(
               context);
           await GettAllData.GetMaxLongTransNo(
               context);
           var custno =
           await StoreShared.getJson(
               'OpendCustomerId');
           Manlogtrans.clear();
           manvisitsmodel.clear();
           Manlogtrans.add(new ManLogTransModel(
               manNo:
               int.parse(Loginprovider.id),
               id: Loginprovider.MaxLongstRANS,
               custNo: int.parse(custno),
               screenCode: 1123,
               actionNo: 19,
               transNo: (Loginprovider
                   .MaxLongstRANSNo -
                   1)
                   .toString(),
               transDate: DateTime.now(),
               tabletId: 'Mobile',
               batteryCharge: "88",
               notes: "",
               posted: 0));

           handler.addManLogTrans(Manlogtrans);

           check = false;
           check2 = false;

           var opentime= await StoreShared.getJson('OpenTime');
           var endtime= DateTime.now().toString();


           manvisitsmodel.add(new ManVisitsModel(
               End_Time:  DateTime.now().toString().substring(10,19),
               note: '',
               X_Lat: double.parse(Currentlat.toString()).toString(),
               Y_Long:double.parse(Currentlong.toString()).toString(),
               loct: ""));


           handler.updateManVisits(manvisitsmodel);



           GettAllData.GetMaxLongTrans(context);
           GettAllData.GetMaxLongTransNo(context);
         });
     dateinput.clear();
     setState(() {});

     Future.delayed(
         const Duration(
             milliseconds: 1000),
             () async {
     if(await StoreShared.checkNetwork()) {

       PostAllData.PostAllManVisit(context);
     }});




   }
OpenVisit() async {
    IsOpen=true;
  var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

  var opentime= await StoreShared.getJson('OpenTime');

  await StoreShared.SaveJson('OpenTime',
      DateTime.now().toString());

  Future.delayed(
      const Duration(
          milliseconds: 1000),
          () async {
        GettAllData.GetMaxLongTrans(context);
        GettAllData.GetMaxLongTransNo(context);

        handler.addManLogTrans(Manlogtrans);
        var custno =
        await StoreShared.getJson(
            'OpendCustomerId');
        manvisitsmodel.clear();
        manvisitsmodel.add(new ManVisitsModel(
            cusNo: int.parse(custno),
            dayNum: DateTime.now().weekday,
            CusName:dateinput.text,
            Start_Time: DateTime.now().toString().substring(10, 19),
            manNo: int.parse(
                Loginprovider.id),
            Tr_Data: DateTime.now().toString().substring(0, 10),
            no: 0,
            orderNo: (Loginprovider.MaxLongstRANSNo - 1),
            note: '',
            X_Lat: double.parse(Currentlat).toString(),
            Y_Long:double.parse(Currentlong).toString(),
            loct: "",
            isException: check2 ? 1 : 0,
            computerName: "Mobile",
            orderInVisit: null,
            duration: null,
            posted: -1));


        handler.addbManVisits(manvisitsmodel);

        
        GettAllData.GetMaxLongTrans(
            context);
        GettAllData.GetMaxLongTransNo(
            context);
      });
  setState(() {

  });


}



}
