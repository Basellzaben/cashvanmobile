import 'dart:convert';
import 'dart:math';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/PriceModel.dart';
import '../Models/ReturnedDtlModel.dart';
import '../Models/ReturnedHlModel.dart';
import '../Models/SalesInvoiceDModelReturned.dart';
import '../Models/SalesInvoiceHModelReturned.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/GettAllData.dart';
import '../Sqlite/PostAllData.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Invoice.dart';
import 'Settings.dart';
import 'package:http/http.dart' as http;

class ReturnedItems extends StatefulWidget {
  @override
  State<ReturnedItems> createState() => _ReturnedItemsState();
}

class _ReturnedItemsState extends State<ReturnedItems> {
  @override
  void initState() {
    getRoundData();

    super.initState();
  }

  TextEditingController unitController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  var max;

  Future<int> GetMax() async {
    max = await GettAllData.GetMaxReturnInv(context);
    print("iReurnAX : " + max.toString());

    return max;
  }

  bool newInv = true;

  double total = 0.0;

  var hdr_dis_value = '1';
  var Cust_No = '1';
  var bounce_Total = '1';
  var V_OrderNo = '1';
  var IncludeTex = '1';
  var TaxTotal = '1';
  bool Cash = true;

  String CustomerId = '';
  String CustomerName = '';
  String CustomerLimite = '';
  String Receivables = '';

  List<PriceModel> myObjects = [];

  String InvId = '';
  List<SalesInvoiceDModelReturned>? cart = [];
  List<ReturnedHlModel>? HDR = [];
  List<ReturnedDtlModel>? DTL = [];

  final dateinputC = TextEditingController();
  final _phoneController = TextEditingController();

  var handler = DatabaseHandler();

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
          bottomNavigationBar: Container(
            color: HexColor(ThemP.color).withOpacity(0.8),
            height: 70,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {},
                    child: cart!.length > 0
                        ? Container(
                            width: 66,
                            color: HexColor(ThemP.color),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.next_plan, color: Colors.white),
                                Text(
                                    LanguageProvider.Llanguage(
                                        'newpassconfirm'),
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ),

                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {

                    SaveInvoice();
                    },
                  child: cart!.length > 0
                      ? Container(
                          width: 90,
                          color: HexColor(ThemP.color),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.cloud_upload_rounded,
                                  color: Colors.white),
                              Text(LanguageProvider.Llanguage('post'),
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      : Container(),
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
                          total.toStringAsFixed(3),
                          style: ArabicTextStyle(
                              arabicFont: ArabicFont.tajawal,
                              fontSize: 15 * unitHeightValue,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' : ',
                          style: ArabicTextStyle(
                              arabicFont: ArabicFont.tajawal,
                              fontSize: 20 * unitHeightValue,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          LanguageProvider.Llanguage('Total'),
                          style: ArabicTextStyle(
                              arabicFont: ArabicFont.tajawal,
                              fontSize: 15 * unitHeightValue,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('ReturnedItems'),
                unitHeightValue,
                LanguageProvider.langg,
                LanguageProvider.getDirection()),
          ),
          backgroundColor: HexColor(ThemP.getcolor()),
          // backgroundColor: Colors.transparent,

          body: Container(
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
            child: Directionality(
              textDirection: LanguageProvider.getDirection(),
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
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // Adjust the top left radius as needed
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                    // Adjust the top left radius as needed
                                    bottomRight: Radius.circular(
                                        10.0), // Adjust the bottom left radius as needed
                                  ),
                                ),
                                elevation: 2,
                                color: HexColor(ThemP.getcolor()),
                                child: GestureDetector(
                                  onTap: () {
                                //    showReturnIDSDialog(context);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Text(
                                              LanguageProvider.Llanguage(
                                                  'returnedid'),
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.tajawal,
                                                  fontSize:
                                                      15 * unitHeightValue,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.elliptical(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        15,
                                                    18.0)),
                                          ),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              if (newInv)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Center(
                                                    child: FutureBuilder(
                                                      future: GetMax(),
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            max.toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                fontSize: 15 *
                                                                    unitHeightValue,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          );
                                                        } else {
                                                          return CircularProgressIndicator();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                )
                                              else
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Center(
                                                      child: Text(
                                                    max.toString(),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        fontSize: 15 *
                                                            unitHeightValue,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )),
                                                ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: HexColor(
                                                      ThemP.getcolor()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // Adjust the top left radius as needed
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                    // Adjust the top left radius as needed
                                    bottomRight: Radius.circular(
                                        10.0), // Adjust the bottom left radius as needed
                                  ),
                                ),
                                elevation: 2,
                                color: HexColor(ThemP.getcolor()),
                                child: GestureDetector(
                                  onTap: () {
                                    showIDSDialog(context);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Text(
                                              LanguageProvider.Llanguage(
                                                  'Invoicesid'),
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.tajawal,
                                                  fontSize:
                                                      15 * unitHeightValue,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.elliptical(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        15,
                                                    18.0)),
                                          ),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Center(
                                                    child: Text(
                                                  InvId,
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: HexColor(
                                                      ThemP.getcolor()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // Adjust the top left radius as needed
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                    // Adjust the top left radius as needed
                                    bottomRight: Radius.circular(
                                        10.0), // Adjust the bottom left radius as needed
                                  ),
                                ),
                                elevation: 2,
                                color: HexColor(ThemP.getcolor()),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text(
                                            LanguageProvider.Llanguage(
                                                'customerid'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 15 * unitHeightValue,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.elliptical(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      15,
                                                  18.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Text(
                                              CustomerId,
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.tajawal,
                                                  fontSize:
                                                      15 * unitHeightValue,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // Adjust the top left radius as needed
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                    // Adjust the top left radius as needed
                                    bottomRight: Radius.circular(
                                        10.0), // Adjust the bottom left radius as needed
                                  ),
                                ),
                                elevation: 2,
                                color: HexColor(ThemP.getcolor()),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text(
                                            LanguageProvider.Llanguage(
                                                'customername'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 15 * unitHeightValue,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.elliptical(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      15,
                                                  18.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Text(
                                              CustomerName,
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.tajawal,
                                                  fontSize:
                                                      15 * unitHeightValue,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // Adjust the top left radius as needed
                                    bottomLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                    // Adjust the top left radius as needed
                                    bottomRight: Radius.circular(
                                        10.0), // Adjust the bottom left radius as needed
                                  ),
                                ),
                                elevation: 2,
                                color: HexColor(ThemP.getcolor()),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Center(
                                          child: Text(
                                            LanguageProvider.Llanguage(
                                                'Receivables'),
                                            style: ArabicTextStyle(
                                                arabicFont: ArabicFont.tajawal,
                                                fontSize: 15 * unitHeightValue,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.elliptical(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      15,
                                                  18.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Text(
                                              Receivables.toString(),
                                              style: ArabicTextStyle(
                                                  arabicFont:
                                                      ArabicFont.tajawal,
                                                  fontSize:
                                                      15 * unitHeightValue,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 22
                                              : 15)),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  ShowItems();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor(ThemP.color),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height:
                                      MediaQuery.of(context).size.width / 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.add, color: Colors.white),
                                      Text(LanguageProvider.Llanguage('Add'),
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.05,
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: ListView(
                              children: cart!
                                  .map(
                                      (SalesInvoiceDModelReturned v) =>
                                          Dismissible(
                                            direction:
                                                DismissDirection.horizontal,
                                            // Only allow horizontal swiping
                                            resizeDuration:
                                                Duration(milliseconds: 500),
                                            background: Container(
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 40 * unitHeightValue,
                                              ),
                                            ),
                                            secondaryBackground: Container(
                                              color: Colors.red,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 40 * unitHeightValue,
                                              ),
                                            ),

                                            confirmDismiss: (DismissDirection
                                                dismissDirection) async {
                                              var bool = false;
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Expanded(
                                                    child: AlertDialog(
                                                      title: Text(
                                                          LanguageProvider
                                                              .Llanguage(
                                                                  'delete'),
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                                  ArabicFont
                                                                      .tajawal,
                                                              fontSize: 22 *
                                                                  unitHeightValue)),
                                                      content: Text(
                                                        LanguageProvider
                                                            .Llanguage(
                                                                "deletetxt"),
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                                ArabicFont
                                                                    .tajawal,
                                                            fontSize: 14 *
                                                                unitHeightValue),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          //  textColor: Colors.black,
                                                          onPressed: () {
                                                            setState(() {
                                                              bool = true;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              cart!.removeWhere(
                                                                  (item) =>
                                                                      item.no
                                                                          .toString() ==
                                                                      v.no.toString());
                                                              //CalculateTaxAllItem(cart);
                                                            });
                                                          },
                                                          child: Text(
                                                            LanguageProvider
                                                                .Llanguage(
                                                                    'delete'),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                color: Colors
                                                                    .redAccent,
                                                                fontSize: 15 *
                                                                    unitHeightValue),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            bool = false;
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            LanguageProvider
                                                                .Llanguage(
                                                                    'cancel'),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 15 *
                                                                    unitHeightValue),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );

                                              return bool;
                                            },
                                            key: Key(v.no.toString()),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: SizedBox(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 8),
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0,
                                                                  bottom: 0),
                                                          color: Colors.black12,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    //  var  uname=  await  getUnitName(v.no.toString(),v.unite.toString());
                                                                    print("UUU1" +
                                                                        v.uname
                                                                            .toString());

                                                                    ShowEditItems(
                                                                        cart,
                                                                        v.no
                                                                            .toString(),
                                                                        v.qty
                                                                            .toString(),
                                                                        v.uname
                                                                            .toString(),
                                                                        v.bounce
                                                                            .toString(),
                                                                        v.discount
                                                                            .toString(),
                                                                        v.tax
                                                                            .toString(),
                                                                        v.tax_Amt
                                                                            .toString(),
                                                                        v.newqty
                                                                            .toString(),
                                                                        v.total
                                                                            .toString(),
                                                                        v.unite
                                                                            .toString());
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: HexColor(
                                                                        ThemP
                                                                            .getcolor()),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Colors
                                                                            .white,
                                                                        size: 27 *
                                                                            unitHeightValue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    maxLines: 2,
                                                                    v.itemname
                                                                        .toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        fontSize:
                                                                            14 *
                                                                                unitHeightValue,
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  'الكميه',
                                                                  style: ArabicTextStyle(
                                                                      arabicFont:
                                                                          ArabicFont
                                                                              .tajawal,
                                                                      fontSize: 12 *
                                                                          unitHeightValue,
                                                                      color: HexColor(
                                                                          ThemP
                                                                              .getcolor()),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      // This makes the container circular
                                                                      color: HexColor(
                                                                          ThemP
                                                                              .getcolor()), // Container background color
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          7.0),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          v.newqty
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 18),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.8,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                5,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                              color: HexColor(ThemP
                                                                  .getcolor()),
                                                              // Border color
                                                              width:
                                                                  1.0, // Border width
                                                            )),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Spacer(),
                                                                      Text(
                                                                        'البونص :',
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Text(
                                                                        v.bounce
                                                                            .toString(),
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                        'الوحده :',
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Text(
                                                                        v.uname
                                                                            .toString(),
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Spacer(),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Spacer(),
                                                                      Text(
                                                                        'الخصم :',
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Text(
                                                                        v.discount.toString() +
                                                                            '%',
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Spacer(),
                                                                      Text(
                                                                        'السعر :',
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Text(
                                                                        v.price
                                                                            .toString(),
                                                                        style: ArabicTextStyle(
                                                                            arabicFont: ArabicFont
                                                                                .tajawal,
                                                                            fontSize: 12 *
                                                                                unitHeightValue,
                                                                            color:
                                                                                HexColor(ThemP.getcolor()),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Spacer(),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 9.0,
                                                                  right: 9),
                                                          child: Center(
                                                            child: SizedBox(
                                                                child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.8,
                                                                  child: Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    'السعر الاجمالي',
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        fontSize:
                                                                            14 *
                                                                                unitHeightValue,
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.8,
                                                                  child: Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    v.total!
                                                                        .toString(),
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        fontSize:
                                                                            20 *
                                                                                unitHeightValue,
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.8,
                                                                  child: Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                    'دينار',
                                                                    style: ArabicTextStyle(
                                                                        arabicFont:
                                                                            ArabicFont
                                                                                .tajawal,
                                                                        fontSize:
                                                                            12 *
                                                                                unitHeightValue,
                                                                        color: HexColor(ThemP
                                                                            .getcolor()),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                  .toList(),
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

  getRoundData() async {
    try {
      final handler = DatabaseHandler();

      ManVisitsModel manvisitsmodel = await handler.retrieveOpenManVisitss();
      if (manvisitsmodel != null) {
        CustomerName = manvisitsmodel.CusName.toString();
        CustomerId = manvisitsmodel.cusNo.toString();

        var customermodelId = await handler
            .retrievebrancheswithID(manvisitsmodel.cusNo.toString());

        CustomerLimite = customermodelId.discount_percent.toString();
        Receivables = customermodelId.pay_how.toString();

        setState(() {});

        return manvisitsmodel;
      } else {
        print("errrrrrrororor");
      }
    } catch (e) {
      print("errrrrrrororor   " + e.toString());
    }

    return null;
  }



  showIDSDialog(
    BuildContext context,
  ) {
    var count = 1;
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    showDialog(
        context: context,
        builder: (context) {
          String contentText = "Content of Dialog";
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(20),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: Colors.transparent,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'التاريخ',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900))),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: Colors.transparent,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'رقم الفاتوره',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900))),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: getIDS(context),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<SalesInvoiceHModelReturned>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                List<SalesInvoiceHModelReturned>? Search =
                                    snapshot.data;

                                return ListView(
                                  children: Search!
                                      .map((SalesInvoiceHModelReturned v) =>
                                          GestureDetector(
                                            onTap: () {
                                              IncludeTex =
                                                  v.include_Tax.toString();
                                              TaxTotal = v.tax_Total.toString();
                                              InvId = v.orderNo.toString();
                                              V_OrderNo =
                                                  v.v_OrderNo.toString();
                                              bounce_Total =
                                                  v.bounce_Total.toString();
                                              Cust_No = v.cust_No.toString();
                                              hdr_dis_value =
                                                  v.hdr_dis_value.toString();
                                              setState(() {});
                                              Navigator.pop(context);
                                              updatescreen();
                                              // GetInvData(v.OrderNo.toString());
                                            },
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            v.date
                                                                .toString()
                                                                .substring(
                                                                    0, 10),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                fontSize: 14 *
                                                                    unitHeightValue,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      )),
                                                  Spacer(),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            v.orderNo
                                                                .toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                fontSize: 14 *
                                                                    unitHeightValue,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )),
                    ],
                  ),
                ));
          });
        });
  }

  Future<List<SalesInvoiceHModelReturned>> getIDS(BuildContext context) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    Uri postsURL = Uri.parse(Globalvireables.invforReturnedsURL);
    try {
      var map = new Map<String, dynamic>();
      map['ManId'] = '2';
      map['Cust_No'] = CustomerId;




      http.Response res = await http.post(
        postsURL,
        body: map,
      );
      print("SalesInvoiceHModelReturneds" + res.statusCode.toString());

      if (res.statusCode == 200) {
        print("SalesInvoiceHModelReturneds" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<SalesInvoiceHModelReturned> SalesInvoiceHModelReturneds = body
            .map(
              (dynamic item) => SalesInvoiceHModelReturned.fromJson(item),
            )
            .toList();

        return SalesInvoiceHModelReturneds;
      } else {
        throw "Unable to retrieve SalesInvoiceHModelReturneds. " +
            res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('بيانات الأطباء'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve SalesInvoiceHModelReturneds.";
  }

  updatescreen() {
    setState(() {});
  }

  ShowItems() {
    final handler = DatabaseHandler();

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    showModalBottomSheet(
        // backgroundColor: HexColor(ThemP.getcolor()),
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                    textDirection: LanguageProvider.getDirectionPres(),
                    child: Container(
                      // color: HexColor(ThemP.getcolor()),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: TextField(
                              controller: dateinputC,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: HexColor(ThemP.getcolor()),
                                  size: 27 * unitHeightValue,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      print("ex 1");
                                      setState(() {
                                        dateinputC.text =
                                            LanguageProvider.Llanguage(
                                                'Search');
                                      });
                                    },
                                    child: Icon(
                                        color: Colors.redAccent,
                                        dateinputC.text.isEmpty ||
                                                dateinputC.text.toString() ==
                                                    LanguageProvider.Llanguage(
                                                        'Search')
                                            ? null
                                            : Icons.cancel)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(ThemP.getcolor()),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor(ThemP.getcolor()),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                contentPadding: EdgeInsets.only(
                                    top: 18, bottom: 18, right: 20, left: 20),
                                fillColor: HexColor(Globalvireables.white),
                                filled: true,
                                hintText: LanguageProvider.Llanguage("Search"),
                              ),
                              //set it true, so that user will not able to edit text
                              onTap: () async {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: FutureBuilder(
                            future: getItems(context, InvId),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<SalesInvoiceDModelReturned>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                List<SalesInvoiceDModelReturned>? Visits =
                                    snapshot.data;

                                List<SalesInvoiceDModelReturned>? Search =
                                    Visits!;
                                return ListView(
                                  children: Search!
                                      .map((SalesInvoiceDModelReturned v) =>
                                          Column(
                                            children: [
                                              Card(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    // Adjust the top left radius as needed
                                                    bottomLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                    // Adjust the top left radius as needed
                                                    bottomRight: Radius.circular(
                                                        10.0), // Adjust the bottom left radius as needed
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    bool exisit = false;
                                                    for (int i = 0;
                                                        i < cart!.length;
                                                        i++) {
                                                      if (v.no.toString() ==
                                                          cart![i]
                                                              .no
                                                              .toString()) {
                                                        exisit = true;
                                                        break;
                                                      }
                                                    }

                                                    if (exisit) {
                                                      Navigator.pop(context);
                                                    } else {
                                                      cart!.add(
                                                          SalesInvoiceDModelReturned(
                                                        bounce:
                                                            v.bounce.toString(),
                                                        dis_Amt: v.dis_Amt
                                                            .toString(),
                                                        discount: v.discount
                                                            .toString(),
                                                        unite:
                                                            v.unite.toString(),
                                                        no: v.no.toString(),
                                                        price:
                                                            v.price.toString(),
                                                        orgPrice: v.orgPrice
                                                            .toString(),
                                                        newqty: '1',
                                                        qty: double.parse(
                                                                v.newqty ??
                                                                    '0.0')
                                                            .toStringAsFixed(0),
                                                        tax: v.tax.toString(),
                                                        tax_Amt: v.tax_Amt
                                                            .toString(),
                                                        total: (double.parse(v
                                                                    .price
                                                                    .toString()) *
                                                                1)
                                                            .toString(),
                                                        itemname: v.itemname
                                                            .toString(),
                                                        uname:
                                                            v.uname.toString(),
                                                      ));

                                                      total += 1 *
                                                          double.parse(v.price
                                                              .toString());

                                                      Navigator.pop(context);
                                                      updataScreen();
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                        child: Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              6.5,
                                                          child: Text(
                                                            v.no.toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: Globalvireables
                                                                            .getDeviceType() ==
                                                                        'tablet'
                                                                    ? 18 *
                                                                        unitHeightValue
                                                                    : 13 *
                                                                        unitHeightValue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                          child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            v.itemname
                                                                .toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: Globalvireables
                                                                            .getDeviceType() ==
                                                                        'tablet'
                                                                    ? 20 *
                                                                        unitHeightValue
                                                                    : 15 *
                                                                        unitHeightValue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
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
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            // textColor: Colors.black,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              LanguageProvider.Llanguage('cancel'),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color: Colors.black,
                                  fontSize: 15 * unitHeightValue),
                            ),
                          ),
                        ),
                      ])),
                    )),
              ));
        });
  }

/*  checkexisitItemInCart(List<SalesInvoiceDModel>? cart, String itemId) {
    bool exit = false;
    for (int i = 0; i < cart!.length; i++) {
      if (cart[i].no.toString() == itemId) {
        exit = true;
        break;
      }
    }

    return exit;
  }*/
  getUnitName(String no, String unit) async {
    myObjects = await handler.getsaleUnit(no.toString(), unit.toString());
    return (myObjects.first.UnitName.toString());
  }

  Future<List<SalesInvoiceDModelReturned>> getItems(
      BuildContext context, String Order_No) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    Uri postsURL = Uri.parse(Globalvireables.invdtlforReturnedsURL);
    try {
      var map = new Map<String, dynamic>();
      map['ManId'] = '2';
      map['Order_No'] = Order_No;

      http.Response res = await http.post(
        postsURL,
        body: map,
      );
      print("SalesInvoiceHModelReturneds" + res.statusCode.toString());

      if (res.statusCode == 200) {
        print("SalesInvoiceHModelReturneds" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        List<SalesInvoiceDModelReturned> SalesInvoiceHModelReturneds = body
            .map(
              (dynamic item) => SalesInvoiceDModelReturned.fromJson(item),
            )
            .toList();

        return SalesInvoiceHModelReturneds;
      } else {
        throw "Unable to retrieve SalesInvoiceHModelReturneds. " +
            res.statusCode.toString();
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('بيانات الأطباء'),
          content: Text(e.toString()),
          actions: <Widget>[],
        ),
      );
    }

    throw "Unable to retrieve SalesInvoiceHModelReturneds.";
  }

  updataScreen() {
    setState(() {});
  }

  ShowEditItems(
      List<SalesInvoiceDModelReturned>? cartnew,
      String itemid,
      String qt,
      String unitname,
      String boun,
      String dis,
      String tax,
      String taxamt,
      String newqt,
      String itemtotal,
      String uno) {
    final handler = DatabaseHandler();

    print("uuuu : " + unitname);

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    TextEditingController bounceController = TextEditingController();
    TextEditingController qtController = TextEditingController();
    TextEditingController unitnamec = TextEditingController();
    TextEditingController taxController = TextEditingController();
    var maxbounce = Loginprovider.getMaxBounce();
    var maxdis = Loginprovider.getMaxDiscount();
    bounceController.text = boun.toString();
    unitController.text = unitname.toString();

    qtController.text = qt.toString();
    unitnamec.text = unitname.toString();
    taxController.text = "% " + tax.toString() + "  -  " + taxamt + ' JD';
    qtController.text = '1';
    var count = int.parse(qtController.text.toString());
    showModalBottomSheet(
        //  backgroundColor: HexColor(ThemP.getcolor()),
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            {
              return FractionallySizedBox(
                  heightFactor: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                        textDirection: LanguageProvider.getDirectionPres(),
                        child: Container(
                          //color: HexColor(ThemP.getcolor()),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Center(
                                  child: Text(
                                LanguageProvider.Llanguage('edititem'),
                                style: TextStyle(
                                    color: HexColor(ThemP.getcolor()),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.black87,
                                height: 2,
                                width: MediaQuery.of(context).size.width / 1.02,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          // Adjust the top left radius as needed
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          // Adjust the top left radius as needed
                                          bottomRight: Radius.circular(
                                              10.0), // Adjust the bottom left radius as needed
                                        ),
                                      ),
                                      elevation: 2,
                                      color: HexColor(ThemP.getcolor()),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Center(
                                                child: Text(
                                                  LanguageProvider.Llanguage(
                                                      'bounce'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.elliptical(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                15,
                                                            18.0)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Center(
                                                    child: TextField(
                                                  textAlign: TextAlign.center,
                                                  controller: bounceController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,

                                                    // Hide the underline
                                                  ),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          // Adjust the top left radius as needed
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          // Adjust the top left radius as needed
                                          bottomRight: Radius.circular(
                                              10.0), // Adjust the bottom left radius as needed
                                        ),
                                      ),
                                      elevation: 2,
                                      color: HexColor(ThemP.getcolor()),
                                      child: GestureDetector(
                                        onTap: () {
                                          getUnit(
                                              context, itemid, itemtotal, uno);
                                          updataScreen();
                                          print("dfsgdfgdfsgdfgfd");
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Center(
                                                  child: Text(
                                                    LanguageProvider.Llanguage(
                                                        'unit'),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        fontSize: 15 *
                                                            unitHeightValue,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                          Radius.elliptical(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  15,
                                                              18.0)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Center(
                                                      child: TextField(
                                                    enabled: false,
                                                    textAlign: TextAlign.center,
                                                    controller: unitController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        fontSize: 15 *
                                                            unitHeightValue,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          // Adjust the top left radius as needed
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          // Adjust the top left radius as needed
                                          bottomRight: Radius.circular(
                                              10.0), // Adjust the bottom left radius as needed
                                        ),
                                      ),
                                      elevation: 2,
                                      color: HexColor(ThemP.getcolor()),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Center(
                                                child: Text(
                                                  LanguageProvider.Llanguage(
                                                      'tax'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.elliptical(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                15,
                                                            18.0)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Center(
                                                    child: TextField(
                                                  enabled: false,
                                                  textAlign: TextAlign.center,
                                                  controller: taxController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          // Adjust the top left radius as needed
                                          bottomLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(0.0),
                                          // Adjust the top left radius as needed
                                          bottomRight: Radius.circular(
                                              10.0), // Adjust the bottom left radius as needed
                                        ),
                                      ),
                                      elevation: 2,
                                      color: HexColor(ThemP.getcolor()),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Center(
                                                child: Text(
                                                  LanguageProvider.Llanguage(
                                                      'qt'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize:
                                                          15 * unitHeightValue,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.elliptical(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                15,
                                                            18.0)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: 70,
                                                      child: TextField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        enabled: false,
                                                        controller:
                                                            qtController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                                ArabicFont
                                                                    .tajawal,
                                                            fontSize: 15 *
                                                                unitHeightValue,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 70,
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        unitname,
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                                ArabicFont
                                                                    .tajawal,
                                                            fontSize: 14 *
                                                                unitHeightValue,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //  if(count+1<int.parse(qt)){
                                                count += 1;
                                                qtController.text =
                                                    count.toString();
                                                // }
                                              });
                                            },
                                            child: Icon(Icons.add_circle,
                                                size: 46,
                                                color: HexColor(
                                                    ThemP.getcolor()))),
                                        Spacer(),
                                        Text(
                                          '$count',
                                          style: TextStyle(
                                              color: HexColor(ThemP.getcolor()),
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            if (count > 1)
                                              setState(() {
                                                count -= 1;
                                                qtController.text =
                                                    count.toString();
                                              });
                                          },
                                          child: Container(
                                            width: 44 * unitHeightValue,
                                            height: 44 * unitHeightValue,
                                            child: SvgPicture.asset(
                                              "assets/min.svg",
                                              color: HexColor(ThemP.getcolor()),
                                              height: 40 * unitHeightValue,
                                              width: 40 * unitHeightValue,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor(ThemP.getcolor()),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    child: Text(
                                      LanguageProvider.Llanguage('save'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color:
                                              HexColor(Globalvireables.white),
                                          fontSize:
                                              Globalvireables.getDeviceType() ==
                                                      'tablet'
                                                  ? 21 * unitHeightValue
                                                  : 16 * unitHeightValue),
                                    ),
                                    onPressed: () async {
                                      /*   TextEditingController bounceController = TextEditingController();
                                      TextEditingController dicountController = TextEditingController();
*/
                                      /*       if(double.parse(bounceController.text.toString())>double.parse(maxbounce.toString()))
{
  showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text(LanguageProvider.Llanguage('anerrortitle')),
            content: Text(maxbounce.toString()+'لا يمكن تجاوز الحد الاعلى للبونص وهو '),
          ));
}else  if(double.parse(dicountController.text.toString())>double.parse(maxdis.toString()))
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                AlertDialog(
                                                  title: Text(LanguageProvider.Llanguage('anerrortitle')),
                                                  content: Text(maxdis.toString()+'لا يمكن تجاوز الحد الاعلى للخصم وهو '),
                                                ));
                                      }else{*/

                                      total = 0.0;

                                      for (int i = 0; i < cart!.length; i++) {
                                        if (cart![i].no.toString() ==
                                            itemid.toString()) {
                                          print(itemid.toString());
                                          print(cart![i].no.toString());

                                          cart![i].newqty =
                                              qtController.text.toString();
                                          cart![i].bounce =
                                              bounceController.text.toString();
                                          cart![i].discount =
                                              unitController.text.toString();

                                          cart![i].total = (double.parse(
                                                      cart![i]
                                                          .newqty
                                                          .toString()) *
                                                  double.parse(cart![i]
                                                      .price
                                                      .toString()))
                                              .toString();

                                          // cart = cart;
                                        }
                                        total += double.parse(
                                            cart![i].total.toString());
                                      }
                                      Navigator.pop(context);
                                      updataScreen();
                                      //  }
                                    },
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    child: Text(
                                      LanguageProvider.Llanguage('cancel'),
                                      style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,
                                          color:
                                              HexColor(Globalvireables.white),
                                          fontSize:
                                              Globalvireables.getDeviceType() ==
                                                      'tablet'
                                                  ? 21 * unitHeightValue
                                                  : 16 * unitHeightValue),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            )
                          ])),
                        )),
                  ));
            }
          });
        });
  }

  showunitDialog(
      BuildContext context, String no, String itemtotal, String uno) {
    var count = 1;
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    showDialog(
        context: context,
        builder: (context) {
          String contentText = "Content of Dialog";
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                content: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 3.3,
                    child: ListView.builder(
                      itemCount: myObjects.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: GestureDetector(
                          onTap: () {
                            unitController.text =
                                myObjects[index].UnitName.toString();
                            // total-=double.parse(itemtotal);

                            print("UNNNOOOO : " + uno.toString());

                            var opearan = '1';
                            for (int i = 0; i < myObjects.length; i++) {
                              if (double.parse(
                                      myObjects[i].Unitno.toString()) ==
                                  double.parse(uno.toString())) {
                                opearan = myObjects[i].Operand.toString();

                                print(
                                    "selected operand : " + opearan.toString());
                                print("Unitno : " +
                                    myObjects[i].Unitno.toString());
                                print("uno  : " + uno.toString());
                              }
                            }

                            if (double.parse(uno.toString()) <
                                double.parse(
                                    myObjects[index].Unitno.toString())) {
                              print("Case : 1");

                              for (int i = 0; i < cart!.length; i++) {
                                if (cart![i].no.toString() == no.toString()) {
                                  cart![i].unite =
                                      myObjects[index].Unitno.toString();
                                  cart![i].uname =
                                      myObjects[index].UnitName.toString();
                                  print("Operand :" + opearan);

                                  print(
                                      "lastqty :" + cart![i].newqty.toString());

                                  cart![i].newqty = (double.parse(
                                              cart![i].newqty.toString()) *
                                          double.parse(opearan))
                                      .toString();
                                  print(
                                      "newqty :" + cart![i].newqty.toString());

                                  cart![i].price = ((double.parse(
                                              cart![i].price.toString()) /
                                          double.parse(opearan)))
                                      .toString();
                                  //cart![i].total=(double.parse(cart![i].total.toString())+double.parse(cart![i].price.toString())*double.parse(cart![i].newqty.toString())).toString();

                                  print("TOTAL : " + cart![i].total.toString());
                                }
                              }
                            } else {
                              print("Case : 2");

                              for (int i = 0; i < cart!.length; i++) {
                                if (cart![i].no.toString() == no.toString()) {
                                  cart![i].unite =
                                      myObjects[index].Unitno.toString();
                                  cart![i].uname =
                                      myObjects[index].UnitName.toString();

                                  print("Operand :" + opearan);

                                  cart![i].price = ((double.parse(
                                              cart![i].price.toString())) *
                                          double.parse(
                                              cart![i].newqty.toString()))
                                      .toString();

                                  cart![i].newqty = ((double.parse(opearan) /
                                              double.parse(
                                                  cart![i].newqty.toString())) *
                                          double.parse(
                                              cart![i].newqty.toString()))
                                      .toString();
                                  // cart![i].qty=(double.parse(cart![i].newqty.toString())/double.parse(opearan)).toString();
                                  print(
                                      "newqty :" + cart![i].newqty.toString());

                                  // cart![i].total=(double.parse(cart![i].total.toString())+double.parse(cart![i].price.toString())*double.parse(cart![i].newqty.toString())).toString();

                                  print("TOTAL : " + cart![i].total.toString());
                                }
                              }
                            }

                            Navigator.pop(context, 'update');
                            Navigator.pop(context, 'update');
                            updataScreen();
                            updataScreen();
                          },
                          child: Row(
                            children: [
                              Text(myObjects[index].UnitName.toString()),
                              Spacer(),
                              Text(myObjects[index].Operand.toString()),
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ));
          });
        });
  }

  getUnit(BuildContext context, String itemId, String Total, String uno) async {
    var handler = DatabaseHandler();
    myObjects.clear();

    myObjects = await handler
        .getUnitOfItemFromUnitItem(itemId)
        .whenComplete(() => showunitDialog(context, itemId, Total, uno));
  }

  SaveInvoice() async {

    HDR!.clear();
    DTL!.clear();

    SaveHdr();
    SaveDTL();

    var jsonH = jsonEncode(HDR!.map((e) => e.toJson()).toList());
    var jsonD = jsonEncode(DTL!.map((e) => e.toJson()).toList());

    print("jsonH : "+jsonH.toString());
    print("jsonD : "+jsonD.toString());

    String jsonUser = jsonEncode(HDR![0]);
    String jsonUser2 = jsonEncode(DTL);
    var json=jsonUser+jsonUser2;

    PostAllData.PostReturnInvoice(context, json);

    print('json : '+jsonUser+jsonUser2);

  //  HDR!.clear();
   // DTL!.clear();
    //cart!.clear();
  }

  SaveHdr() {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    HDR!.add(new ReturnedHlModel(
      Net_Total: total.toStringAsFixed(3).toString(),
      Cust_No: Cust_No,
      OrderNo: max.toString(),
      Date: DateTime.now().toString().substring(0, 10).replaceAll('-', '/'),
      bounce_Total: bounce_Total,
      CashCustNm: '',
      V_OrderNo: V_OrderNo,
      Tax_Total: TaxTotal,
      bill: InvId,
      include_Tax: IncludeTex,
      return_type: Cash ? '1' : '0',
      Total: total.toStringAsFixed(3).toString(),
      UserID: Loginprovider.getid().toString(),
    ));

    var handler = DatabaseHandler();

    /*handler.addReturnH(HDR!).then((value) => {

      HDR!.clear()
    });*/
  }

  SaveDTL() {
    for (int i = 0; i < cart!.length; i++) {
      DTL!.add(new ReturnedDtlModel(
        Bounce: cart![i].bounce.toString(),
        Note: '',
        Damaged: '',
        Unite: cart![i].unite.toString(),
        no: cart![i].no.toString(),
        price: cart![i].price.toString(),
        ItemOrgPrice: cart![i].orgPrice.toString(),
        Qty: cart![i].newqty.toString(),
        Tax: cart![i].tax.toString(),
        Tax_Amt: cart![i].tax_Amt.toString(),
        Total: cart![i].total.toString(),
      ));
    }

   /* var handler = DatabaseHandler();

    handler.addReturnD(DTL!).then((value) => {

    DTL!.clear()
    });*/
  }
  showReturnIDSDialog(
      BuildContext context,
      ) {
    var count = 1;
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;

    showDialog(
        context: context,
        builder: (context) {
          String contentText = "Content of Dialog";
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(20),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: Colors.transparent,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'التاريخ',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900))),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  color: Colors.transparent,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'رقم الفاتوره',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900))),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: getReturnIDS(context),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ReturnedHlModel>>
                                snapshot) {
                              if (snapshot.hasData) {
                                List<ReturnedHlModel>? Search =
                                    snapshot.data;

                                return ListView(
                                  children: Search!
                                      .map((ReturnedHlModel v) =>
                                      GestureDetector(
                                        onTap: () {

                                        //  newInv=false;
                                          max=v.OrderNo;
                                          InvId=v.bill.toString();
                                          Cash=v.return_type.toString()=='1'?true:false;
                                          total=double.parse(v.Total.toString());




getSelectInvdtl(v.OrderNo.toString());








                                          Navigator.pop(context);
                                          updatescreen();
                                          // GetInvData(v.OrderNo.toString());
                                        },
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Text(
                                                        textAlign: TextAlign
                                                            .center,
                                                        v.Date
                                                            .toString()
                                                            .substring(
                                                            0, 10),
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                            ArabicFont
                                                                .tajawal,
                                                            fontSize: 14 *
                                                                unitHeightValue,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500)),
                                                  )),
                                              Spacer(),
                                              Container(
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      3,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Text(
                                                        textAlign: TextAlign
                                                            .center,
                                                        v.OrderNo
                                                            .toString(),
                                                        style: ArabicTextStyle(
                                                            arabicFont:
                                                            ArabicFont
                                                                .tajawal,
                                                            fontSize: 14 *
                                                                unitHeightValue,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500)),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )),
                    ],
                  ),
                ));
          });
        });
  }
  Future<List<ReturnedHlModel>> getReturnIDS(BuildContext context) async {
    final handler = DatabaseHandler();

    return await handler.retrieveReturnIDS();
  }

  getSelectInvdtl(String orderno) async {

    final handler = DatabaseHandler();

    DTL= await handler.retrieveSingleReturnDTL(orderno);

    /*Bounce: json['Bounce'],
    Note: json['Note'],
    Damaged: json['Damaged'],
    Unite: json['Unite'],
    no: json['no'],
    price: json['price'],
    ItemOrgPrice: json['ItemOrgPrice'],
    Qty: json['Qty'],
    Tax: json['Tax'],
    Tax_Amt: json['Tax_Amt'],
    Total: json['Total'],*/


    for(int i=0;i<DTL!.length;i++){

      cart!.add(new SalesInvoiceDModelReturned(
        bounce: DTL![i].Bounce.toString(),
        dis_Amt: '',
        discount: '',
        unite: DTL![i].Unite.toString(),
        no: DTL![i].no.toString(),
        price: DTL![i].price.toString(),
        orgPrice: DTL![i].ItemOrgPrice.toString(),
        qty: DTL![i].Qty.toString(),
        newqty: DTL![i].Qty.toString(),
        tax: DTL![i].Tax.toString(),
        tax_Amt: DTL![i].Tax_Amt.toString(),
        total: DTL![i].Total.toString(),
        itemname: await handler.getItemName( DTL![i].no.toString()).toString(),
        uname: '',
      ));


    }


  }

}
