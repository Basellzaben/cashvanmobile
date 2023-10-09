import 'dart:async';
import 'dart:convert';

import 'package:arabic_font/arabic_font.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemModel.dart';
import '../Models/ItemsCartModel.dart';
import '../Models/ManVisitsModel.dart';
import '../Models/OpenRoundModel.dart';
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
var total=0.0;
  @override
  void initState() {

    getRoundData();
    timer = Timer.periodic(Duration(seconds: 7),
            (Timer t) => getRoundData());

    // getCustomerData();
    super.initState();
  }

  List<ItemsCartModel>? cart =[];



/*  getCustomerData() async {


    CustomerName=await StoreShared.getJson(Globalvireables.CustomerName);
    CustomerId=await StoreShared.getJson(Globalvireables.CustomerId);
    CustomerLimite=await StoreShared.getJson(Globalvireables.CustomerLimite);
    Receivables=await StoreShared.getJson(Globalvireables.Receivables);

    print(CustomerName + "   CustomerName");
  }*/
  @override
  void dispose() {
    super.dispose();
  }
  TextEditingController dateinputC = TextEditingController();

  bool IncludeTex = true;
  bool Cash = true;


  @override
  Widget build(BuildContext context) {
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
    onTap: ()
            {

           
            },
                  
                  
                  
                  
                  child:    GestureDetector(
    onTap: () {

      ShowItems
        ();

    },


                    child: Container(
                      width: 66,
                      color: HexColor(ThemP.color),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.add, color: Colors.white), Text(LanguageProvider.Llanguage('Add'), style: TextStyle(color: Colors.white))],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3,),
                Container(
                  width: 90,
                  color: HexColor(ThemP.color),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.all_inclusive, color: Colors.white), Text(LanguageProvider.Llanguage('allInvoices'), style: TextStyle(color: Colors.white))],
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
                      total.toString(),style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                        color: Colors.white,fontWeight: FontWeight.w600),),

                    Text(
                      ' : ',style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                        color: Colors.white,fontWeight: FontWeight.w900),),


                  Text(
                  LanguageProvider.Llanguage('Total'),style: ArabicTextStyle(
                    arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                    color: Colors.white,fontWeight: FontWeight.w500),),



              ],),
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
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.only(
                                      bottomLeft: Radius.circular(80)),
                                  // if you need this
                                  side: BorderSide(
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height,
                                    //  color: HexColor(ThemP.getcolor())12.withOpacity(0.1),
                                  ),
                                ),

                                child:Container(
                                  width: MediaQuery.of(context).size.width,

                                  child: Column(children: [

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Invoicesid'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        roundpr.getCustomerId()+"7534",style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('customerid'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        CustomerId,style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),
                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('customername'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        CustomerName,style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Clientceiling'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                        CustomerLimite,style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

                                    Row(children: [

                                      Text(
                                        LanguageProvider.Llanguage('Receivables'),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),),
                                      Text(
                                       Receivables.toString(),style: ArabicTextStyle(
                                          arabicFont: ArabicFont.tajawal,fontSize: 15*unitHeightValue,
                                          color: Colors.black,fontWeight: FontWeight.w600),)

                                    ],),

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
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.width > 600?22:15)),
                                        Spacer(),
                                        Checkbox(
                                            value: IncludeTex,
                                            //set variable for value
                                            onChanged: (bool? value) {
                                              setState(() {
                                                IncludeTex =
                                                !IncludeTex;
                                              });
                                            }),
                                        Text("شامل الضريبه",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize:MediaQuery.of(context).size.width > 600?22: 15)),



                                        Spacer()
,Spacer()
,Spacer()


                                      ],
                                    ),

                                  ],),

                                )

                            ),
                          ),



                          SizedBox(
                            height: MediaQuery.of(context).size.height/3,
                            width: MediaQuery.of(context).size.width/1.4,
                            child: ListView(
                              children: cart
                              !.map((ItemsCartModel v) => SizedBox(
                                child: Card(
                                  color: Colors.white,
                                  child:   Row(
                                    children: [
                                      SizedBox(
                                            child: Text(
                                              v.Ename.toString(),
                                            ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        child: Text(
                                          v.qt.toString(),
                                        ),
                                      ),
                                    ],
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
    try{
      final handler = DatabaseHandler();




      ManVisitsModel manvisitsmodel=await handler.retrieveOpenManVisitss();
      if(manvisitsmodel!=null){

        CustomerName = manvisitsmodel.CusName.toString();
        CustomerId = manvisitsmodel.cusNo.toString();

        var customermodelId=await handler.retrievebrancheswithID(manvisitsmodel.cusNo.toString());


        CustomerLimite = customermodelId.discount_percent.toString();
        Receivables = customermodelId.pay_how.toString();






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

  
  
  ShowItems(){
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    showDialog(
        context: context,
        builder: (BuildContext context) {

          return Expanded(
              child: AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.2,
                    child: Directionality(
                        textDirection: LanguageProvider.getDirectionPres(),
                            child: SingleChildScrollView(
                                    child: Column(
                                        children: [



                                          SizedBox(
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
                                                    child: Icon(color: Colors.redAccent,dateinputC.text.isEmpty ||
                                                        dateinputC.text.toString() ==
                                                            LanguageProvider.Llanguage(
                                                                'Search')
                                                        ? null
                                                        : Icons.cancel)),
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                        HexColor(ThemP.getcolor()),
                                                        width: 1.0),
                                                    borderRadius: BorderRadius.circular(10.0)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                        HexColor(ThemP.getcolor()),
                                                        width: 2.0),
                                                    borderRadius: BorderRadius.circular(10.0)),
                                                contentPadding: EdgeInsets.only(
                                                    top: 18, bottom: 18, right: 20, left: 20),
                                                fillColor: HexColor(Globalvireables.white),
                                                filled: true,
                                                hintText:
                                                LanguageProvider.Llanguage("Search"),
                                              ),
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {

                                              },
                                            ),
                                          ),
SizedBox(height: 10,),
                                          SizedBox(
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .height /
                                                1.48,
                                            width: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                1.1,
                                            child: FutureBuilder(
                                              future: getItems(),
                                              builder: (BuildContext
                                              context,
                                                  AsyncSnapshot<
                                                      List<ItemModel>>
                                                  snapshot) {
                                                if (snapshot
                                                    .hasData) {
                                                  List<ItemModel>?
                                                  Visits =
                                                      snapshot
                                                          .data;

                                                  List<ItemModel>? Search = Visits!
                                                      .where((element) =>
                                                  element
                                                      .Item_Name
                                                      .toString()
                                                      .contains(dateinputC.text
                                                      .toString()) ||
                                                      element
                                                          .Ename
                                                          .toString()
                                                          .contains(dateinputC.text.toString())

                                                      ||
                                                      element
                                                      .Item_No
                                                          .toString()
                                                          .contains(dateinputC.text.toString())
                                                  )
                                                      .toList();

                                                  return ListView(
                                                    children: Search!
                                                        .map((ItemModel v) => Column(
                                                      children: [
                                                        Card(
                                                          child: GestureDetector(
                                                            onTap: () {

                                                              var exiet=0;


                                                              for(int i=0;i<cart!.length;i++){
                                                                var staticprice;
                                                                try {
                                                                   staticprice = double
                                                                      .parse(
                                                                      cart![i]
                                                                          .Price
                                                                          .toString()) /
                                                                      double
                                                                          .parse(
                                                                          cart![i]
                                                                              .qt
                                                                              .toString());
                                                                }catch(_){
                                                                  staticprice = double
                                                                      .parse(
                                                                      cart![i]
                                                                          .Price
                                                                          .toString()) /
                                                                      double
                                                                          .parse('1');
                                                                }
                                                                if(cart![i].Item_No==v.Item_No.toString()){
                                                                  cart![i].qt   =   int.parse(cart![i].qt.toString())+1;
                                                                  cart![i].Price=(double.parse(cart![i].Price.toString())+ staticprice);
                                                                  total+=double.parse(staticprice.toString());

                                                                  exiet=1;
                                                                }
                                                              }
                                                              if(exiet==0){
                                                                cart!.add( ItemsCartModel(Item_Name: v.Item_Name.toString(),
                                                                    Item_No: v.Item_No.toString()
                                                                    ,Price:v.Price,
                                                                    qt:1,
                                                                    Ename: v.Ename, Unit: v.Unit
                                                                  ));
                                                                setState(() {

                                                                });

                                                                total+=double.parse(v.Price.toString());

                                                              }

                                                              setState(() {

                                                              });






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
                                                                          v.Item_No.toString(),
                                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 18 * unitHeightValue : 13 * unitHeightValue, fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),

                                                                      Spacer(),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width / 2.5,
                                                                        child: Text(
                                                                          textAlign: TextAlign.center,
                                                                          v.Item_Name.toString(),
                                                                          style: ArabicTextStyle(arabicFont: ArabicFont.tajawal, color: Colors.black, fontSize: Globalvireables.getDeviceType() == 'tablet' ? 20 * unitHeightValue : 15 * unitHeightValue, fontWeight: FontWeight.w700),
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


                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white60)),
                                              // textColor: Colors.black,
                                              onPressed: () {
                                                Navigator.of(context).pop();


                                              },
                                              child: Text(
                                                LanguageProvider.Llanguage('cancel'),
                                                style: ArabicTextStyle(
                                                    arabicFont: ArabicFont.tajawal,
                                                    color: Colors.black87,
                                                    fontSize: 15 *
                                                        unitHeightValue),
                                              ),
                                            ),
                                          ),


                                        ])
                            )),
                  )
              ));});
  }

  Future<List<ItemModel>> getItems() async {
    var handler = DatabaseHandler();
    List<ItemModel> users=[];
    try {
      users = await handler.reterveInvf();


      print(users.first.Item_Name.toString() + "   branchnameBBBB");

      return users;
    } catch (e) {
      print(e.toString() + " ERRORSQKKL");
    }
    return users;
  }
  
}
