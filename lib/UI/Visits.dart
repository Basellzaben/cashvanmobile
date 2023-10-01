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
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class Visits extends StatefulWidget {
  @override
  State<Visits> createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
  Timer? timer;
  bool active = false;
  bool IsOpen = false;

  @override
  void initState() {
    determinePosition();
    GetRounddata();
    timer = Timer.periodic(Duration(seconds: 10),
        (Timer t) => GetDistance(latCustomer, longCustomer));

    timer = Timer.periodic(Duration(seconds: 3),
            (Timer t) => GetRounddata());



    super.initState();
  }

  TextEditingController dateinput = TextEditingController();
  TextEditingController searchscustomerscontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  String latCustomer = '';
  String longCustomer = '';
  String CustomerId = '';

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
                                        Globalvireables.getDeviceType()=='tablet'?18 * unitHeightValue:14 * unitHeightValue,
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
                                        Globalvireables.getDeviceType()=='tablet'?18 * unitHeightValue:14 * unitHeightValue,
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
                                  IsOpen?null:
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                              fontSize:
                                                              Globalvireables.getDeviceType()=='tablet'?25 * unitHeightValue:20 * unitHeightValue,

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
                                                      onChanged: (content) {
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
                                                              ThemP.getcolor()),
                                                          size: 27 *
                                                              unitHeightValue,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    searchscustomerscontroller
                                                                        .text = '';
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    searchscustomerscontroller.text.isEmpty ||
                                                                            searchscustomerscontroller.text.toString() ==
                                                                                LanguageProvider.Llanguage('Search')
                                                                        ? null
                                                                        : Icons.cancel)),
                                                        border:
                                                            OutlineInputBorder(),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 18,
                                                                bottom: 18,
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            1.6,
                                                    width:
                                                        MediaQuery.of(context)
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
                                                        if (snapshot.hasData) {
                                                          List<CustomersModel>?
                                                              Visits =
                                                              snapshot.data;

                                                          List<CustomersModel>? search = Visits!
                                                              .where((element) =>
                                                                  element
                                                                      .branchName
                                                                      .toString()
                                                                      .contains(searchscustomerscontroller
                                                                          .text
                                                                          .toString()) ||
                                                                  element
                                                                      .customerId
                                                                      .toString()
                                                                      .contains(searchscustomerscontroller
                                                                          .text
                                                                          .toString()))
                                                              .toList();

                                                          return ListView(
                                                            children: search!
                                                                .map(
                                                                    (CustomersModel
                                                                            v) =>
                                                                        Column(
                                                                          children: [
                                                                            Card(
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  dateinput.text = v.branchName.toString();
                                                                                  latCustomer = v.locX.toString();
                                                                                  longCustomer = v.locY.toString();
                                                                                  CustomerId = v.id.toString();

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
                                                                                          v.branchName.toString(),
                                                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black,

                                                                                              fontSize:   Globalvireables.getDeviceType()=='tablet'?20 * unitHeightValue:15 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      ),
                                                                                      Spacer(),
                                                                                      Text(
                                                                                        v.id.toString(),
                                                                                        style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black,
                                                                                            fontSize: Globalvireables.getDeviceType()=='tablet'?18 * unitHeightValue:13 * unitHeightValue, fontWeight: FontWeight.w700),
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: HexColor(
                                                              ThemP.getcolor()),
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
                                                              fontSize:
                                                              Globalvireables.getDeviceType()=='tablet'?19*
                                                                  unitHeightValue:14 *
                                                                  unitHeightValue),
                                                        ),
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                  /*  TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text(
    LanguageProvider.Llanguage('cancel'),
    style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,
    color: HexColor(ThemP.getcolor())87,
    fontSize: 15 *
    unitHeightValue),
    ),
    ),*/
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
                                    setState(() {
                                      if(!IsOpen)
                                        check = !check;
                                    });
                                  }),
                              Text(
                                  LanguageProvider.Llanguage(
                                      "substituteemployee"),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:  Globalvireables.getDeviceType()=='tablet'?17 * unitHeightValue:12 * unitHeightValue)),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: check2,
                                  //set variable for value
                                  onChanged: (bool? value) async {
                                    setState(() {
                                      if(!IsOpen)
                                      check2 = !check2;
                                    });
                                  }),
                              Text(
                                  LanguageProvider.Llanguage("Exceptionaltour"),
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Globalvireables.getDeviceType()=='tablet'?17 * unitHeightValue:12 * unitHeightValue)),
                            ],
                          ),
                          active||IsOpen
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    margin: EdgeInsets.only(top: 40, bottom: 5),
                                    color: HexColor(Globalvireables.white),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: IsOpen?Colors.redAccent:HexColor(ThemP.getcolor()),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      child: Text(
                                        IsOpen?LanguageProvider.Llanguage('end'):LanguageProvider.Llanguage('start'),
                                        style: ArabicTextStyle(
                                            arabicFont: ArabicFont.tajawal,
                                            color:
                                                HexColor(Globalvireables.white),
                                            fontSize: Globalvireables.getDeviceType()=='tablet'?21 * unitHeightValue:16 * unitHeightValue),
                                      ),
                                      onPressed: () async {
if(IsOpen){
  IsOpen=false;

  StoreShared.SaveJson(Globalvireables.OpenRound,"");

  dateinput.clear();
  check=false;
  check2=false;


      }else {
  IsOpen=true;
  List<OpenRoundModel> openRound=[new OpenRoundModel(
      manno: Loginprovider.id,
      englishName: dateinput.text,
      roundType: check2 ? '1' : '0',
      //0 normal
      employeeType: check ? '1' : '0',
      //0 normal
      custId: CustomerId,
      starttime: DateTime.now().toString().substring(0, 16),
      endtime: DateTime.now().toString().substring(0, 16),
      status: '0'
  )];
 // openRound.add(;

  StoreShared.SaveJson(Globalvireables.OpenRound,
      jsonEncode(openRound.map((e) => e.toJson()).toList()));
}
setState(() {

});
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
                                          fontSize: Globalvireables.getDeviceType()=='tablet'?21 * unitHeightValue:16 * unitHeightValue),
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
    Visits(),
  ];

  Future<List<CustomersModel>> getCustomers() async {
    print("JSONJSON" + await StoreShared.getJson(Globalvireables.CustomerJson));

    List<dynamic> body =
        jsonDecode(await StoreShared.getJson(Globalvireables.CustomerJson));
    List<CustomersModel> users = body
        .map(
          (dynamic item) => CustomersModel.fromJson(item),
        )
        .toList();

    print("thisisiteeem : " + users.first.customerId.toString());

    return users;
  }

  Future<List<CustomersModel>> getCustomersOnline() async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    Uri apiUrl = Uri.parse(Globalvireables.customerAPI);

    try {
      var map = new Map<String, dynamic>();
      map['EXCEPTION'] = 'true';
      map['ManId'] = Loginprovider.getid();

      print("Input" + map.toString());

      http.Response res = await http.post(
        apiUrl,
        body: map,
      );

      if (res.statusCode == 200) {
        print("Invoices" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<CustomersModel> Invoices = body
            .map(
              (dynamic item) => CustomersModel.fromJson(item),
            )
            .toList();

        return Invoices;
      } else {
        throw "Unable to retrieve Invoices." + res.statusCode.toString();
      }
    } catch (e) {}

    throw "Unable to retrieve Invoices.";
  }

  GetDistance(String latCustomer, String longCustomer) async {
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

    print(
        (distanceInMeters / 1000).toStringAsFixed(2).toString() + " DISTANCE");
    if ((distanceInMeters / 1000) < 100000) active = true;
    setState(() {});
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

  Future<List<OpenRoundModel>> GetRounddata() async {
    print("JSONJSON" + await StoreShared.getJson(Globalvireables.OpenRound));

    List<dynamic> body =
    jsonDecode(await StoreShared.getJson(Globalvireables.OpenRound));
    List<OpenRoundModel> users = body
        .map(
          (dynamic item) => OpenRoundModel.fromJson(item),
    )
        .toList();


    if(users[0].starttime.toString().length>7){
      IsOpen=true;
    }

    dateinput.text=users[0].englishName.toString();
    if(users[0].employeeType.toString()=='1'){
      check=true;
    }
    if(users[0].roundType.toString()=='1'){
      check2=true;
    }
setState(() {

});
    return users;
  }

}
