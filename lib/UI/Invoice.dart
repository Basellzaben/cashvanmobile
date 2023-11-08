import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cashvanmobile/Models/SalesInvoiceDModelPost.dart';
import 'package:cashvanmobile/Models/SalesInvoiceHModelPost.dart';
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

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/CustomersModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/SalesInvoiceDModel.dart';
import '../Models/SalesInvoiceHModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/OpenRoundModel.dart';
import '../Models/PriceModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/RoundProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../SharedPrefrence/StoreShared.dart';
import '../Sqlite/DatabaseHandler.dart';
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
  var timer;
  var total = 0.0;
  var inittotal = 0.0;
  var taxtotal = 0.0;
  var distotal = 0.0;
  var bouncetotal = 0.0;

  @override
  void initState() {
    getRoundData();

    myObjects.clear();
    super.initState();
  }

  Future<int> GetMax() async {
    max = await GettAllData.GetMaxInvoiceV(context);
    print("invoicemAX : " + max.toString());

    return max;
  }
bool newInv=true;
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
  TextEditingController dateinputC = TextEditingController();
  TextEditingController unitcontroller = TextEditingController();

  bool IncludeTex = true;
  bool Cash = true;
  PriceModel? selectedObjecttest;

  List<SalesInvoiceDModel>? cart = [];

  List<SalesInvoiceHModel>? cartHdr = [];

  List<PriceModel> myObjects = [];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    print(max.toString() + "mmmmxmmx");

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
                GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () {

                      getRoundData();

                      cartHdr!.clear();
                      cart!.clear();
newInv=true;
                      setState(() {

                      });

                    },
                    child: cart!.length>0 ? Container(
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
                    ):Container(),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    try {
                      if (cartHdr![0].posted.toString() != '1' && cart!.length>0) {
                        SaveInvoice(cart);
                      }
                      else {
                        showDialog(
                          context: context,
                          builder: (context) =>
                          new AlertDialog(
                            title: new Text(
                                LanguageProvider.Llanguage('Invoices')),
                            content: Text(LanguageProvider.Llanguage(
                                'Invoicesnotupdateposted')),
                            actions: <Widget>[],
                          ),
                        );
                      }
                    }catch(_){
                      SaveInvoice(cart);


                    }
                  },
                  child: cart!.length>0 ?Container(
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
                  ):Container(),
                ),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
try {
  if (cartHdr![0].posted.toString() != '1')
    PostInv(max.toString());
  else
    showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text(LanguageProvider.Llanguage('Invoices')),
        content: Text(LanguageProvider.Llanguage('Invoicesnotupdateposted')),
        actions: <Widget>[],
      ),
    );
}catch(_){

  PostInv(max.toString());

}
                  },
                  child: cart!.length>0 ? Container(
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
                  ):Container(),
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
                                          if(newInv)
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                              child: FutureBuilder(
                                                future: GetMax(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<dynamic>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      roundpr
                                                              .getCustomerId()
                                                              .toString() +
                                                          max.toString(),
                                                      style: ArabicTextStyle(
                                                          arabicFont: ArabicFont
                                                              .tajawal,
                                                          fontSize: 15 *
                                                              unitHeightValue,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w900),
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
    padding: const EdgeInsets.all(3.0),
    child: Center(
    child:  Text(
    roundpr
        .getCustomerId()
        .toString() +
    max.toString(),
    style: ArabicTextStyle(
    arabicFont: ArabicFont
        .tajawal,
    fontSize: 15 *
    unitHeightValue,
    color: Colors.black,
    fontWeight:
    FontWeight.w900),
    )
    ),
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
                                        LanguageProvider.Llanguage(
                                            'Clientceiling'),
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
                                          CustomerLimite,
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
                                      MediaQuery.of(context).size.width > 600
                                          ? 22
                                          : 15)),
                          Spacer(),
                          Checkbox(
                              value: IncludeTex,
                              //set variable for value
                              onChanged: (bool? value) {
                                setState(() {
                                  IncludeTex = !IncludeTex;
                                });
                                CalculateTaxAllItem(cart);
                              }),
                          Text("شامل الضريبه",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 22
                                          : 15)),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              try {
                                if (cartHdr![0].posted.toString() != '1')
                                  ShowItems();
                                else
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                    new AlertDialog(
                                      title: new Text(
                                          LanguageProvider.Llanguage('Invoices')),
                                      content: Text(LanguageProvider.Llanguage(
                                          'Invoicesnotupdateposted')),
                                      actions: <Widget>[],
                                    ),
                                  );
                              }catch(_){
                                ShowItems();

                              }
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
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.width/10,
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
                              .map((SalesInvoiceDModel v) => Dismissible(
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
                                                      fontSize: 22 *
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
                                                    setState(() {
                                                      bool = true;
                                                      Navigator.of(context)
                                                          .pop();
                                                      cart!.removeWhere(
                                                          (item) =>
                                                              item.no
                                                                  .toString() ==
                                                              v.no.toString());
                                                      CalculateTaxAllItem(cart);
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
                                    key: Key(v.no.toString()),
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
                                                            ShowEditItems(
                                                                cart,
                                                                v.no.toString(),
                                                                v.qty
                                                                    .toString(),
                                                                v.unitname
                                                                    .toString(),
                                                                v.Bounce
                                                                    .toString(),
                                                                v.Discount
                                                                    .toString(),
                                                                v.tax
                                                                    .toString(),
                                                                v.tax_Amt
                                                                    .toString());
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
                                                            v.name.toString(),
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
                                                        Text(
                                                          'الكميه',
                                                          style: ArabicTextStyle(
                                                              arabicFont:
                                                                  ArabicFont
                                                                      .tajawal,
                                                              fontSize: 12 *
                                                                  unitHeightValue,
                                                              color: HexColor(ThemP
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
                                                              color: HexColor(ThemP
                                                                  .getcolor()), // Container background color
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(7.0),
                                                              child: Center(
                                                                child: Text(
                                                                  v.qty
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
                                            Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                      color: HexColor(
                                                          ThemP.getcolor()),
                                                      // Border color
                                                      width:
                                                          1.0, // Border width
                                                    )),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Text(
                                                                'البونص :',
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
                                                              Text(
                                                                v.Bounce
                                                                    .toString(),
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
                                                              Spacer(),
                                                              Text(
                                                                'الوحده :',
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
                                                              Text(
                                                                v.unitname
                                                                    .toString(),
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
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              Text(
                                                                'الخصم :',
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
                                                              Text(
                                                                v.Discount
                                                                        .toString() +
                                                                    '%',
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
                                                              Spacer(),
                                                              Text(
                                                                'السعر :',
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
                                                              Text(
                                                                v.price
                                                                    .toString(),
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
                                                              Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 9.0, right: 9),
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
                                                                TextAlign.right,
                                                            'السعر الاجمالي',
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
                                                                        .w600),
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
                                                                TextAlign.right,
                                                            v.total.toString(),
                                                            style: ArabicTextStyle(
                                                                arabicFont:
                                                                    ArabicFont
                                                                        .tajawal,
                                                                fontSize: 20 *
                                                                    unitHeightValue,
                                                                color: HexColor(
                                                                    ThemP
                                                                        .getcolor()),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
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
                                                                TextAlign.right,
                                                            'دينار',
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
          )),
    ]);
  }

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
                            future: getItems(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ItemModel>> snapshot) {
                              if (snapshot.hasData) {
                                List<ItemModel>? Visits = snapshot.data;

                                List<ItemModel>? Search = Visits!
                                    .where((element) =>
                                        element.Item_Name.toString().contains(
                                            dateinputC.text.toString()) ||
                                        element.Ename.toString().contains(
                                            dateinputC.text.toString()) ||
                                        element.Item_No.toString().contains(
                                            dateinputC.text.toString()))
                                    .toList();

                                return ListView(
                                  children: Search!
                                      .map((ItemModel v) => Column(
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
                                                    if (checkexisitItemInCart(
                                                        cart,
                                                        v.Item_No.toString())) {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        LanguageProvider.Llanguage(
                                                                            'additem')),
                                                                    content: Text(
                                                                        LanguageProvider.Llanguage(
                                                                            'itemexisit')),
                                                                  ));
                                                    } else {
                                                      myObjects.clear();

                                                      getUnit(
                                                          context,
                                                          v.Item_No.toString(),
                                                          '1',
                                                          v.tax.toString(),
                                                          v.Ename.toString());
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
                                                            v.Item_No
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
                                                            v.Item_Name
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

  Future<List<ItemModel>> getItems() async {
    var handler = DatabaseHandler();
    List<ItemModel> users = [];
    try {
      users = await handler.reterveInvf();

      print(users.first.Item_Name.toString() + "   branchnameBBBB");

      return users;
    } catch (e) {
      print(e.toString() + " ERRORSQKKL");
    }
    return users;
  }

  getUnit(BuildContext context, String itemId, String cat, String tax,
      String name) async {
    var handler = DatabaseHandler();
    myObjects.clear();

    var no = itemId;

    myObjects = await handler
        .getUnitOfItem(itemId, cat)
        .whenComplete(() => showunitDialog(context, no, tax, name));
  }

  showunitDialog(
    BuildContext context,
    String no,
    String tax,
    String name,
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
                            var ItemOrgPricewithoutTax;

                            double Dis_Amt = ((double.parse(
                                        myObjects[index].price.toString()) *
                                    count) *
                                (double.parse(myObjects[index].dis.toString()) /
                                    100));
                            double temp = ((double.parse(
                                    myObjects[index].price.toString())) /
                                ((double.parse(tax.toString()) / 100) + 1));
                            double tax_Amt = (double.parse(
                                    myObjects[index].price.toString())) -
                                temp;
                            tax_Amt = tax_Amt * count;
                            print(" tax_Amt1 : " + tax_Amt.toString());

                            double innertotal = (double.parse(
                                        myObjects[index].price.toString()) -
                                    Dis_Amt) +
                                tax_Amt;

                            var ItemOrgPrice;
                            if (!IncludeTex) {
                              bouncetotal+=double.parse(myObjects[index].bounce.toString());
                              ItemOrgPrice = ((double.parse(myObjects[index]
                                              .price
                                              .toString()) *
                                          count) +
                                      (tax_Amt) -
                                      (Dis_Amt))
                                  .toString();
                              ItemOrgPricewithoutTax = ItemOrgPrice;
                              innertotal =
                                  double.parse(ItemOrgPrice.toString());
                            } else {
                              bouncetotal+=double.parse(myObjects[index].bounce.toString());

                              ItemOrgPrice = myObjects[index].price.toString();
                              ItemOrgPrice =
                                  (double.parse(ItemOrgPrice) * count) -
                                      tax_Amt;

                              print(" ItemOrgPrice1 : " +
                                  ItemOrgPrice.toString());
                              ItemOrgPricewithoutTax = ItemOrgPrice;

                              Dis_Amt = (double.parse(ItemOrgPrice.toString()) *
                                  (double.parse(
                                          myObjects[index].dis.toString()) /
                                      100));
                              //  Dis_Amt=Dis_Amt*count;

                              print(" Dis_Amt : " + Dis_Amt.toString());

                              ItemOrgPrice -= Dis_Amt;

                              // tax_Amt = (ItemOrgPrice * double.parse(tax.toString())/100 );

                              temp = (ItemOrgPrice) /
                                  ((double.parse(tax.toString()) / 100) + 1);

                              tax_Amt =
                                  double.parse(ItemOrgPrice.toString()) - temp;

                              print(" tax_Amt2 : " + tax_Amt.toString());

                              // tax_Amt=tax_Amt*count;

                              innertotal =
                                  ((double.parse(ItemOrgPrice.toString()))) +
                                      tax_Amt;
                            }
                            cart!.add(SalesInvoiceDModel(
                              Bounce: myObjects[index].bounce.toString(),
                              Dis_Amt: Dis_Amt.toStringAsFixed(3),
                              //C
                              Discount: myObjects[index].dis.toString(),
                              ItemOrgPrice: double.parse(
                                      ItemOrgPricewithoutTax.toString())
                                  .toStringAsFixed(3),
                              Operand: myObjects[index].Operand.toString(),
                              ProBounce: '0',
                              //N
                              Pro_amt: '0',
                              Pro_bounce: '0',
                              Pro_dis_Per: '0',
                              Unite: myObjects[index].Unitno.toString(),
                              no: no,
                              price: myObjects[index].price,
                              pro_Total: '0.0',
                              qty: count.toString(),
                              tax: tax,
                              tax_Amt: tax_Amt.toStringAsFixed(3),
                              //C
                              total: innertotal.toStringAsFixed(3),
                              orderno: max.toString(),
                              name: name,
                              unitname: myObjects[index].UnitName.toString(),
                            ));

                            total += innertotal;
                            Navigator.pop(context);
                            Navigator.pop(context, 'update');
                            updataScreen();
                          },
                          child: Row(
                            children: [
                              Text(myObjects[index].UnitName.toString()),
                              Spacer(),
                              Text(myObjects[index].price.toString()),
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                  Card(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count += 1;
                                  });
                                },
                                child: Icon(Icons.add_circle,
                                    size: 46,
                                    color: HexColor(ThemP.getcolor()))),
                            Spacer(),
                            Text(
                              '$count',
                              style: TextStyle(
                                  color: HexColor(ThemP.getcolor()),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  if (count > 1)
                                    setState(() {
                                      count -= 1;
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
                                )),
                            Spacer(),
                          ],
                        )),
                  )
                ],
              ),
            ));
          });
        });
  }

  CalculateTaxAllItem(List<SalesInvoiceDModel>? cart) {
    total = 0;
    inittotal = 0;
    distotal = 0;
    taxtotal = 0;
bouncetotal=0;
    var ItemOrgPricewithoutTax;
    for (int index = 0; index < cart!.length; index++) {
      int count = int.parse(cart![index].qty.toString());

      double Dis_Amt = ((double.parse(cart![index].price.toString())) *
          (double.parse(cart![index].Discount.toString()) / 100));

      Dis_Amt = Dis_Amt * count;

      double temp = (double.parse(cart![index].price.toString()) /
          ((double.parse(cart![index].tax.toString()) / 100) + 1));
      double tax_Amt = double.parse(cart![index].price.toString()) - temp;

      tax_Amt = tax_Amt * count;

      print(" tax_Amt1 : " + tax_Amt.toString());

      double innertotal =
          ((double.parse(cart![index].price.toString()) * count) - Dis_Amt) +
              tax_Amt;

      var ItemOrgPrice;
      if (!IncludeTex) {
        ItemOrgPrice = ((double.parse(cart![index].price.toString()) * count) +
                tax_Amt -
                Dis_Amt)
            .toString();
        ItemOrgPricewithoutTax = ItemOrgPrice;
        total += double.parse(ItemOrgPricewithoutTax);
        inittotal += double.parse(ItemOrgPrice.toString());
        distotal += double.parse(Dis_Amt.toString());
        taxtotal += double.parse(tax_Amt.toString());
      } else {
        ItemOrgPrice = cart![index].price.toString();
        ItemOrgPrice =
            (double.parse(ItemOrgPrice.toString()) * count) - tax_Amt;

        print(" ItemOrgPrice1 : " + ItemOrgPrice.toString());
        ItemOrgPricewithoutTax = ItemOrgPrice;

        Dis_Amt = (double.parse(ItemOrgPrice.toString()) *
            (double.parse(cart![index].Discount.toString()) / 100));

        Dis_Amt = Dis_Amt * count;
        print(" Dis_Amt : " + Dis_Amt.toString());

        ItemOrgPrice -= Dis_Amt;

        // tax_Amt = (ItemOrgPrice * double.parse(tax.toString())/100 );

        temp = (ItemOrgPrice) /
            ((double.parse(cart![index].tax.toString()) / 100) + 1);

        tax_Amt = double.parse(ItemOrgPrice.toString()) - temp;
        print(" tax_Amt2 : " + tax_Amt.toString());

        tax_Amt = tax_Amt * count;

        innertotal = (double.parse(ItemOrgPrice.toString())) + tax_Amt;
        total += innertotal;
      }

      cart![index].Dis_Amt = Dis_Amt.toStringAsFixed(3);
      cart![index].ItemOrgPrice =
          double.parse(ItemOrgPricewithoutTax.toString()).toStringAsFixed(3);
      cart![index].tax_Amt = tax_Amt.toStringAsFixed(2);
      cart![index].total = innertotal.toStringAsFixed(3);
      cart![index].qty = count.toString();
      inittotal += double.parse(ItemOrgPrice.toString());
      distotal += double.parse(Dis_Amt.toString());
      taxtotal += double.parse(tax_Amt.toString());
    }

    setState(() {});
  }

  updataScreen() {
    setState(() {});
    setState(() {});
  }

  checkexisitItemInCart(List<SalesInvoiceDModel>? cart, String itemId) {
    bool exit = false;
    for (int i = 0; i < cart!.length; i++) {
      if (cart[i].no.toString() == itemId) {
        exit = true;
        break;
      }
    }

    return exit;
  }

  ShowEditItems(List<SalesInvoiceDModel>? cartnew, String itemid, String qt,
      String unitname, String boun, String dis, String tax, String taxamt) {
    final handler = DatabaseHandler();

    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    TextEditingController bounceController = TextEditingController();
    TextEditingController dicountController = TextEditingController();
    TextEditingController qtController = TextEditingController();
    TextEditingController unitnamec = TextEditingController();
    TextEditingController taxController = TextEditingController();
    var maxbounce = Loginprovider.getMaxBounce();
    var maxdis = Loginprovider.getMaxDiscount();

    bounceController.text = boun.toString();
    dicountController.text = dis.toString();

    qtController.text = qt.toString();
    unitnamec.text = unitname.toString();
    taxController.text = "% " + tax.toString() + "  -  " + taxamt + ' JD';

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
                                                      'discount'),
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
                                                  controller: dicountController,
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
                                                count += 1;
                                                qtController.text =
                                                    count.toString();
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

                                      for (int i = 0;
                                          i < cartnew!.length;
                                          i++) {
                                        if (cartnew![i].no.toString() ==
                                            itemid.toString()) {
                                          print(itemid.toString());
                                          print(cartnew![i].no.toString());

                                          cartnew![i].qty =
                                              qtController.text.toString();
                                          cartnew![i].Bounce =
                                              bounceController.text.toString();
                                          cartnew![i].Discount =
                                              dicountController.text.toString();

                                          cart = cartnew;
                                        }
                                      }
                                      Navigator.pop(context);

                                      updataScreen();
                                      CalculateTaxAllItem(cart);
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

  SaveInvoice(List<SalesInvoiceDModel>? cart) async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);



    /*
    var total=0.0;
    var Nettotal=0.0;
    var Taxtotal=0.0;
    double hdr_dis_per=0.0;
    for(int i=0;i<cart!.length;i++) {
      hdr_dis_per += double.parse(cart![i].Discount.toString());
      total+=double.parse(cart![i].price.toString());
      Nettotal+=double.parse(cart![i].total.toString());
      Taxtotal+=double.parse(cart![i].tax_Amt.toString());

    }
    hdr_dis_per=hdr_dis_per/cart!.length;

    cartHdr!.add(new SalesInvoiceHModel(
      Cust_No: CustomerId,
      Date: DateTime.now().toString().substring(0, 10).toString(),
      UserID: Loginprovider.id.toString(),
      OrderNo: max.toString(),
      hdr_dis_per: hdr_dis_per.toString(),
      hdr_dis_value: distotal.toStringAsFixed(3),
      Total: total.toStringAsFixed(3),
      Net_Total: Nettotal.toStringAsFixed(3),
      Tax_Total: Taxtotal.toStringAsFixed(3),
      include_Tax: IncludeTex ? '1' : '0',
      inovice_type: Cash ? '1' : '0',
      V_OrderNo: Loginprovider.getVisitId().toString(),
      posted: '0',
    ));

    */
    double hdr_dis_per=0.0;
    for(int i=0;i<cart!.length;i++) {
      hdr_dis_per += double.parse(cart![i].Discount.toString());
    }
    hdr_dis_per=hdr_dis_per/cart!.length;

    cartHdr!.add(new SalesInvoiceHModel(
      Cust_No: CustomerId,
      Date: DateTime.now().toString().substring(0, 10).toString(),
      UserID: Loginprovider.id.toString(),
      OrderNo: max.toString(),
      hdr_dis_per: hdr_dis_per.toString(),
      hdr_dis_value: distotal.toStringAsFixed(3),
      Total: inittotal.toStringAsFixed(3),
      Net_Total: total.toStringAsFixed(3),
      Tax_Total: taxtotal.toStringAsFixed(3),
      include_Tax: IncludeTex ? '1' : '0',
      inovice_type: Cash ? '1' : '0',
      V_OrderNo: await StoreShared.getJson('VisitId'),
      posted: '0',
    ));

    final handler = DatabaseHandler();
    await Future.delayed(Duration(seconds: 1));
//srger
  var x1=await  handler.addSalesInvoiceH(max.toString(),cartHdr!,newInv);
    var x2=await handler.addSalesInvoiceD(max.toString(),cart!,newInv);

    print("ggggggg   "+x1.toString());

    if(int.parse(x2)>0 && int.parse(x1)>0 )
   cartHdr!.clear();
    cart!.clear();
    total=0.0;

    setState(() {
/*if(get)*/
    });
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
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.black12,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'التاريخ',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500))),
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.black12,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'رقم الفاتوره',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500))),
                            Container(
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.black12,
                                ),
                                child: Text(
                                    textAlign: TextAlign.center,
                                    'رقم العميل',
                                    style: ArabicTextStyle(
                                        arabicFont: ArabicFont.tajawal,
                                        fontSize: 14 * unitHeightValue,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: getIDS(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<SalesInvoiceHModel>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                List<SalesInvoiceHModel>? Search =
                                    snapshot.data;

                                return ListView(
                                  children: Search!
                                      .map((SalesInvoiceHModel v) =>
                                          GestureDetector(
                                            onTap: () {
                                              GetInvData(v.OrderNo.toString());
                                            },
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      /*   decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.transparent,

                                          ),*/
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            v.Date.toString(),
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
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      /*  decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.transparent,

                                          ),*/
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
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      /*decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            color: Colors.transparent,

                                          ),*/
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            v.Cust_No
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
                                                                        .w700)),
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

  Future<List<SalesInvoiceHModel>> getIDS() async {
    final handler = DatabaseHandler();

    return await handler.retrieveIDS();
  }

  GetInvData(String OrederNo) async {
    cartHdr!.clear();
    cart!.clear();
    newInv=false;

    final handler = DatabaseHandler();
    cart = await handler.retrieveSingleDTL(OrederNo);
    cartHdr!.add(await handler.retrieveSingleHDR(OrederNo));


    print("ststeeee : "+cartHdr![0].posted.toString());

    if (cartHdr![0].include_Tax.toString() == '1') {
      IncludeTex=true;
    } else {
      IncludeTex=false;
    }

    if (cartHdr![0].inovice_type.toString() == '1') {
      Cash=true;
    } else {
      Cash=false;
    }

    CustomersModel CM=await  handler.retrieveSingelbranches(cartHdr![0].Cust_No.toString());
    CalculateTaxAllItem(cart);

     max=int.parse(OrederNo) ;
     CustomerId= cartHdr![0].Cust_No.toString();
     CustomerName = CM.branchname.toString();
     CustomerLimite = CM.discount_percent.toString();
     Receivables = CM.pay_how.toString();

    Navigator.of(context).pop();

    setState(() {
    //  print("xxx " + cart![0].unitname.toString());
     // print("ordergettter " + OrederNo.toString());
    });
  }

  PostInv(String OrederNo) async {
   // GetInvData(v.OrderNo.toString());
    final handler = DatabaseHandler();

    List<SalesInvoiceDModelPost>? cartPost = [];

    List<SalesInvoiceHModelPost>? cartHdrPost = [];

    double totalbounce=0.0;


    cart = await handler.retrieveSingleDTL(OrederNo);
    cartHdr!.add(await handler.retrieveSingleHDR(OrederNo));


    for(int i=0;i<cart!.length;i++) {
      totalbounce += double.parse(cart![i].Bounce.toString());

    }




  cartHdrPost.add(new SalesInvoiceHModelPost(
      Net_Total:double.parse(cartHdr![0].Total.toString()),
      hdr_dis_value: double.parse(cartHdr![0].hdr_dis_value.toString()),
      Cust_No: double.parse(cartHdr![0].Cust_No.toString()),

      OrderNo:int.parse(cartHdr![0].OrderNo.toString()),
      Date: cartHdr![0].Date.toString(),
      bounce_Total: totalbounce,

      hdr_dis_per: double.parse(cartHdr![0].hdr_dis_per.toString()),
      disc_Total: double.parse(cartHdr![0].hdr_dis_value.toString()),

      Tax_Total: double.parse(cartHdr![0].Tax_Total.toString()),
      include_Tax: int.parse(cartHdr![0].include_Tax.toString()),

      inovice_type:int.parse(cartHdr![0].inovice_type.toString()) ,
      CashCustNm: '',
      Total: double.parse(cartHdr![0].Total.toString()),
      UserID: int.parse(cartHdr![0].UserID.toString()),
      V_OrderNo: double.parse(cartHdr![0].V_OrderNo.toString()),
      OrderDesc: '',



    ));

    for(int i=0;i<cart!.length;i++) {

     // print("Unit : "+int.parse(cart![i].Unite.toString()).toString());
double uu=double.parse(cart![i].Unite.toString());
      cartPost.add(new SalesInvoiceDModelPost(
        Bounce: double.parse(cart![i].Bounce.toString()),
        Dis_Amt: double.parse(cart![i].Dis_Amt.toString()),
        Discount: double.parse(cart![i].Discount.toString()),
        Unite: uu.toInt(),
        no: cart![i].no.toString(),
        price: double.parse(cart![i].price.toString()),
        ItemOrgPrice: double.parse(cart![i].ItemOrgPrice.toString()),
        Qty: double.parse(cart![i].qty.toString()),
        Tax: double.parse(cart![i].tax.toString()),
        Tax_Amt: double.parse(cart![i].tax_Amt.toString()),
        Total: double.parse(cart![i].total.toString()),
      ));
    }

    var jsonH = jsonEncode(cartHdrPost.map((e) => e.toJson()).toList());
    var jsonD = jsonEncode(cartPost.map((e) => e.toJson()).toList());

    print("jsonH : "+jsonH.toString());
    print("jsonD : "+jsonD.toString());



    var json=jsonH.toString()+jsonD.toString();


print("JSOOOON : "+json.toString());

PostAllData.PostInvoice(context, json,cartHdr![0].OrderNo.toString());


setState(() {
  cart!.clear();
  cartHdr!.clear();
});
  }


}
