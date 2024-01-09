import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cashvanmobile/Providers/PrintProvider.dart';
import 'package:cashvanmobile/Sqlite/GettAllData.dart';
import 'package:cashvanmobile/Sqlite/PostAllData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icon_forest/amazingneoicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/CustomersModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/OpenRoundModel.dart';
import '../Models/PaymentCheckModel.dart';
import '../Models/PriceModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/PrintProvider.dart';
import '../Providers/PrintProvider.dart';
import '../Providers/RoundProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../widget/Widgets.dart';
import 'Home.dart';
import 'Print.dart';

import 'Settings.dart';
import 'package:http/http.dart' as http;

class voucher extends StatefulWidget {
  @override
  State<voucher> createState() => _voucherState();
}

class _voucherState extends State<voucher> {
  String CustomerId = '';
  String CustomerName = '';
  String CustomerLimite = '';


  String CheckSum = '0';
  String SUM = '0';


  var total = 0.0;

  @override
  void initState() {
    getRoundData();
    super.initState();
  }

  List<PaymentCheckModel>? CashList = [];

  TextEditingController sumCashController = TextEditingController();

  Future<int> GetMax() async {
    max = await GettAllData.GetMaxVoucher(context);
    print("vouchermAX : " + max.toString());

    return max;
  }

  bool newInv = true;
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  var max = 0;
  TextEditingController checknoCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController namepersionCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(max.toString() + "mmmmxmmx");

    // getCustomerData();
    var roundpr = Provider.of<RoundProvider>(context, listen: false);

    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00118;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    var PrintProviderr = Provider.of<PrintProvider>(context, listen: false);

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
                    onTap: () {
                      getRoundData();
                    },
                    child: Container(
                      width: 66,
                      color: HexColor(ThemP.color),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.next_plan, color: Colors.white),
                          Text(LanguageProvider.Llanguage('newpassconfirm'),
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 90,
                      color: HexColor(ThemP.color),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.save_alt_sharp, color: Colors.white),
                          Text(LanguageProvider.Llanguage('save'),
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 90,
                    color: HexColor(ThemP.color),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cloud_upload_rounded, color: Colors.white),
                        Text(LanguageProvider.Llanguage('post'),
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: 90,
                    color: HexColor(ThemP.color),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.print, color: Colors.white),
                        Text(LanguageProvider.Llanguage('print'),
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
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
      backgroundColor: Colors.transparent,


     /*    floatingActionButton: Align(
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
                LanguageProvider.Llanguage('receiptvoucher'),
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
                              onTap: () {},
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Center(
                                        child: Text(
                                          LanguageProvider.Llanguage(
                                              'vouchersid'),
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
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        roundpr
                                                                .getCustomerId()
                                                                .toString() +
                                                            max.toString(),
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
                                                roundpr
                                                        .getCustomerId()
                                                        .toString() +
                                                    max.toString(),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_drop_down_circle,
                                              color: HexColor(ThemP.getcolor()),
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
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 15 * unitHeightValue,
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
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 15 * unitHeightValue,
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
                                        LanguageProvider.Llanguage('totalvoch'),
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
                                          SUM,
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 15 * unitHeightValue,
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
                                            'totalcheck'),
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
                                          CheckSum.toString(),
                                          style: ArabicTextStyle(
                                              arabicFont: ArabicFont.tajawal,
                                              fontSize: 15 * unitHeightValue,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                        LanguageProvider.Llanguage('totalcash'),
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
                                  child: TextField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white70,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.elliptical(
                                            MediaQuery.of(context).size.width / 15,
                                            18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: sumCashController,
                                    style: ArabicTextStyle(
                                      arabicFont: ArabicFont.tajawal,
                                      fontSize: 15 * unitHeightValue,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.center, // Center-align the text

                                    onChanged: (newValue) {


                                      SUM=(double.parse(sumCashController.text)+double.parse(CheckSum)).toString();

                                    /*  if(double.parse(newValue)>=double.parse(sumCashController.text))
                                      {
                                        SUM=(double.parse(sumCashController.text)+double.parse(newValue)).toString();
                                      }else{
                                        SUM=(double.parse(newValue)+double.parse(sumCashController.text)).toString();
                                      }
*/
                                      setState(() {
                                      });
                                      },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {

                              ShowCheckDialog();

                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor(ThemP.color),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0)),
                                ),
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 13,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add, color: Colors.white),
                                    Text(LanguageProvider.Llanguage('AddCHECK'),
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                        SizedBox(
                        height: MediaQuery.of(context).size.height / 2.05,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: ListView(
                          children: CashList!
                              .map((PaymentCheckModel v) => Dismissible(
                                    direction: DismissDirection.horizontal,
                                    // Only allow horizontal swiping
                                    resizeDuration: Duration(milliseconds: 500),
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
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: Text(
                                                  LanguageProvider.Llanguage(
                                                      'delete'),
                                                  style: ArabicTextStyle(
                                                      arabicFont:
                                                          ArabicFont.tajawal,
                                                      fontSize: 18 *
                                                          unitHeightValue)),
                                              content: Text(
                                                LanguageProvider.Llanguage(
                                                    "deletetxt"),
                                                style: ArabicTextStyle(
                                                    arabicFont:
                                                        ArabicFont.tajawal,
                                                    fontSize:
                                                        14 * unitHeightValue),
                                              ),
                                              actions: [
                                                TextButton(
                                                  //  textColor: Colors.black,
                                                  onPressed: () {


                                                    CheckSum=(double.parse(CheckSum)-double.parse(v.amnt.toString())).toString();
                                                    SUM=(double.parse(SUM)+double.parse(CheckSum)).toString();

                                                    Navigator.of(context)
                                                        .pop();
                                                    CashList!.removeWhere(
                                                            (item) =>
                                                        item.transid
                                                            .toString() ==
                                                            v.transid.toString());

                                                    setState(() {

                                                    });
                                                  },
                                                  child: Text(
                                                    LanguageProvider.Llanguage(
                                                        'delete'),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        color: Colors.redAccent,
                                                        fontSize: 15 *
                                                            unitHeightValue),
                                                  ),
                                                ),
                                                TextButton(
                                                  // textColor: Colors.black,
                                                  onPressed: () {
                                                    bool = false;
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    LanguageProvider.Llanguage(
                                                        'cancel'),
                                                    style: ArabicTextStyle(
                                                        arabicFont:
                                                            ArabicFont.tajawal,
                                                        color: Colors.black87,
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
                                    key: Key(v.id.toString()),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8),
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, bottom: 0),
                                                  color: Colors.black12,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {


                                                          },
                                                          child: Container(
                                                            color: HexColor(ThemP
                                                                .getcolor()),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                Icons.edit,
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
                                                            v.checkno.toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                fontSize: 14 *
                                                                    unitHeightValue,
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Spacer(),

                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              // This makes the container circular
                                                              color: HexColor(ThemP
                                                                  .getcolor()), // Container background color
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(7.0),
                                                              child: Center(
                                                                child: Text(
                                                                  v.amnt
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18),
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
          )),
    ]);
  }

  getRoundData() async {
    try {
      sumCashController.text='0';

      final handler = DatabaseHandler();

      ManVisitsModel manvisitsmodel = await handler.retrieveOpenManVisitss();
      if (manvisitsmodel != null) {
        CustomerName = manvisitsmodel.CusName.toString();
        CustomerId = manvisitsmodel.cusNo.toString();

        var customermodelId = await handler
            .retrievebrancheswithID(manvisitsmodel.cusNo.toString());

        CustomerLimite = customermodelId.discount_percent.toString();
        //CheckSum = customermodelId.pay_how.toString();

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

  updataScreen() {
    setState(() {});
    setState(() {});
  }


  ShowCheckDialog() {
    final handler = DatabaseHandler();


  /*  checknoCont.text="hgghgh";
    priceCont.text="hgghgh";
    namepersionCont.text="hgghgh";
    dateCont.text="hgghgh";
*/

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
                                height: 60,
                                width: MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: checknoCont,
                                  decoration: InputDecoration(
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
                                        top: 18, bottom: 18, right: 20, left: 20
                                    ),
                                    hintText: LanguageProvider.Llanguage("checknumber"),
                                    hintStyle: TextStyle(color: Colors.black), // Set the hint text color
                                  ),
                                  onTap: () async {

                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: priceCont,
                                  decoration: InputDecoration(
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
                                    hintText: LanguageProvider.Llanguage("amount"),
                                    hintStyle: TextStyle(color: Colors.black), // Set the hint text color

                                  ),
                                  onTap: () async {},
                                ),
                              ),
                            ),

                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width/1.1,
                                child: TextField(
                                  controller: namepersionCont,
                                  decoration: InputDecoration(
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
                                    hintText: LanguageProvider.Llanguage("persondispensing"),
                                    hintStyle: TextStyle(color: Colors.black), // Set the hint text color

                                  ),
                                  onTap: () async {},
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width/1.1,

                                child: TextField(
                                  controller: dateCont,
                                  decoration: InputDecoration(
fillColor: Colors.white,
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
                                    hintText: LanguageProvider.Llanguage("datecheck"),
                                    hintStyle: TextStyle(color: Colors.black), // Set the hint text color

                                  ),
                                  onTap: () async {

                                    _selectDate(context);

                                  }

                                  ,
                                ),
                              ),
                            ),


                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(HexColor(ThemP.getcolor()))),
                                  onPressed: () {


                                    CheckSum=(double.parse(CheckSum)+double.parse(priceCont.text)).toString();
                                    SUM=(double.parse(SUM)+double.parse(CheckSum)).toString();


                                    CashList!.add(new PaymentCheckModel(id: '0', 
                                        transid: 'transid', bankno: 'bankno', checkdate: 'checkdate',
                                        checkno: '566237', amnt: priceCont.text, userid: 'userid',
                                        transdate: 'transdate'));
                                    
                                    setState(() {

                                    });
                                    
                                  },
                                  child: Text(
                                    LanguageProvider.Llanguage('Add'),
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        color: Colors.white,
                                        fontSize: 15 * unitHeightValue),
                                  ),
                                ),
                              ),
                            ),

                           /* Padding(
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
                            ),*/


                          ])),
                    )),
              ));
        });
  }
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );


    dateCont.text="hgghgh";

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Do something with the selected date, like updating the text field
      setState(() {
        dateCont.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }


}
