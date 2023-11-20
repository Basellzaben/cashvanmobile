import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
import '../Models/StockModel.dart';
import '../Models/SalesInvoiceHModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/OpenRoundModel.dart';
import '../Models/PriceModel.dart';
import '../Models/StockModel.dart';
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

class CustomerInventory extends StatefulWidget {
  @override
  State<CustomerInventory> createState() => _CustomerInventory();
}






class _CustomerInventory extends State<CustomerInventory> {
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


  var max;

  Future<int> GetMax() async {
    max = await GettAllData.GetMaxStock(context);
    print("iReurnAX : " + max.toString());

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

  TextEditingController dateinputC = TextEditingController();
  TextEditingController unitcontroller = TextEditingController();

  bool IncludeTex = true;
  bool Cash = true;
  PriceModel? selectedObjecttest;



  List<PriceModel> myObjects = [];
  List<StockModel> Stock = [];



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
                  onTap: () {



                  },
                  child: GestureDetector(
                    onTap: () {

                      newInv=true;
                      getRoundData();
                      Stock.clear();
                      setState(() {

                      });

                    },
                    child: 1 > 0
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
                    PostAllData.PostStock(context,max.toString());
                  //  SaveInvoice();
                  },
                  child: Stock!.length > 0
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
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    SaveStock();
                    //  SaveInvoice();
                  },
                  child: Stock!.length > 0
                      ? Container(
                    width: 90,
                    color: HexColor(ThemP.color),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.save_alt_sharp,
                            color: Colors.white),
                        Text(LanguageProvider.Llanguage('save'),
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  )
                      : Container(),
                ),
                Expanded(
                  child:  Container(
                    color: Colors.transparent,
                    height: 50,
                    child:  GestureDetector(
                      onTap: () {
                        try {
                          if (Stock[0].posted.toString() != '1')
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


                          print("StockLength : "+Stock.length.toString());

                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(

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
                  ),
                ),
              ],
            ),
          ),

          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 800.0,
            elevation: 4.0,
            title: Widgets.Appbar(
                context,
                LanguageProvider.Llanguage('CustomerInventory'),
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
                                                  'Inventoryid'),
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.05,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: ListView(
                          children: Stock!
                              .map((StockModel v) => Dismissible(
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
                                              Stock!.removeWhere(
                                                      (item) =>
                                                  item.ItemNo
                                                      .toString() ==
                                                      v.ItemNo.toString());
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
                            key: Key(v.ItemNo.toString()),
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
                                                        Stock,
                                                        v.ItemNo.toString(),
                                                        v.Qty
                                                            .toString(),
                                                        v.unitname
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
                                                    v.itemname.toString(),
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
                                                          v.Qty
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
                                                if (checkexisitItemInStock(
                                                    Stock,
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
                                  onTap: () async {


                                    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);



                                    Stock.add(new StockModel(
                                        TransNo: max.toString(),
                                        TransDate: DateTime.now().toString().substring(0, 10).replaceAll('-', '/'),
                                        CustId: CustomerId,
                                        ManId:Loginprovider.id.toString(),
                                        ItemNo: no,
                                        Qty:count.toString(),
                                        OrderQty: '0',
                                        ExpiryDate: '',
                                        posted:'0',
                                        VisitOrderNo: await StoreShared.getJson('VisitId'),
                                      unit: double.parse(myObjects[index].Unitno.toString()).toInt().toString(),

                                      unitname: myObjects[index].UnitName,
                                      itemname: name,
                                      customername: CustomerName,


                                    ));
                                    updataScreen();

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


  updataScreen() {
    setState(() {});
    setState(() {});
  }

  checkexisitItemInStock(List<StockModel>? Stock, String itemId) {
    bool exit = false;
    for (int i = 0; i < Stock!.length; i++) {
      if (Stock[i].ItemNo.toString() == itemId) {
        exit = true;
        break;
      }
    }

    return exit;
  }

  ShowEditItems(List<StockModel>? Stocknew, String itemid, String qt,
      String unitname) {
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


    qtController.text = qt.toString();
    unitnamec.text = unitname.toString();

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
                                          i < Stocknew!.length;
                                          i++) {
                                            if (Stocknew![i].ItemNo.toString() ==
                                                itemid.toString()) {
                                              print(itemid.toString());
                                              print(Stocknew![i].ItemNo.toString());

                                              Stocknew![i].Qty =
                                                  qtController.text.toString();

                                                  dicountController.text.toString();

                                              Stock = Stocknew;
                                            }
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
                                AsyncSnapshot<List<StockModel>>
                                snapshot) {
                              if (snapshot.hasData) {
                                List<StockModel>? Search =
                                    snapshot.data;

                                return ListView(
                                  children: Search!
                                      .map((StockModel v) =>
                                      GestureDetector(
                                        onTap: () {
                                          GetInvData(v.TransNo.toString());
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
                                                        v.TransDate.toString(),
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
                                                        v.TransNo
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
                                                        v.CustId
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

  Future<List<StockModel>> getIDS() async {
    final handler = DatabaseHandler();

    return await handler.retrieveStockIDS();
  }

  GetInvData(String OrederNo) async {


    final handler = DatabaseHandler();
   // Stock = await handler.retrieveSingleDTL(OrederNo);

  //  StockHdr!.clear();
   // Stock!.clear();
    newInv=false;


    Stock = await handler.retrieveStock(OrederNo).whenComplete(() => {



    });

    max=Stock[0].TransNo;
   CustomerName=Stock[0].customername.toString();



  /*  for(int i=0;i<Stock.length;Stock.length){
      Stock!.add(
        new StockModel(
        Bounce: '',
        Dis_Amt:'',
        Discount: '',
        ItemOrgPrice: '',
        Operand: '',
        ProBounce:'',
        Pro_amt:'',
        Pro_bounce: '',
        Pro_dis_Per: '',
        Unite: Stock[i].unit.toString(),
        no: Stock[i].ItemNo.toString(),
        price: '',
        pro_Total: '',
        qty: Stock[i].Qty.toString(),
        tax: '',
        tax_Amt: '',
        total: '',
        orderno: '',
        name: '',
        unitname: '',
        ));
    }*/

    Navigator.of(context).pop();

updataScreen();
    /*StockHdr!.add(await handler.retrieveSingleHDR(OrederNo));


    print("ststeeee : "+StockHdr![0].posted.toString());

    if (StockHdr![0].include_Tax.toString() == '1') {
      IncludeTex=true;
    } else {
      IncludeTex=false;
    }

    if (StockHdr![0].inovice_type.toString() == '1') {
      Cash=true;
    } else {
      Cash=false;
    }

    CustomersModel CM=await  handler.retrieveSingelbranches(StockHdr![0].Cust_No.toString());
    CalculateTaxAllItem(Stock);

    max=int.parse(OrederNo) ;
    CustomerId= StockHdr![0].Cust_No.toString();
    CustomerName = CM.branchname.toString();
    CustomerLimite = CM.discount_percent.toString();
    Receivables = CM.pay_how.toString();

    Navigator.of(context).pop();

    setState(() {
      //  print("xxx " + Stock![0].unitname.toString());
      // print("ordergettter " + OrederNo.toString());
    });*/
  }



  SaveStock() async {
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    final handler = DatabaseHandler();
   int res=await handler.addStock(Stock,newInv,max.toString());


    print("res.toString()"+res.toString());
    print("res.toString()"+res.toString());

if(int.parse(res.toString())>0){
  //Stock!.clear();
  Stock.clear();
setState(() {
  
});
}

  }


}
