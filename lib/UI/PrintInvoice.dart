import 'dart:async';
import 'dart:io';
import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/PriceModel.dart';
import '../Models/SalesInvoiceDModel.dart';
import '../Models/SalesInvoiceHModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/PrintProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../widget/Widgets.dart';



class PrintInvoice extends StatefulWidget {
  @override
  _PrintInvoice createState() => _PrintInvoice();
}

class _PrintInvoice extends State<PrintInvoice> {
  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  List<String> _options = ["permission bluetooth granted", "bluetooth enabled", "connection status", "update info"];


  List<PriceModel> myObjects = [];
  int selectedIndex = -1;

  List<SalesInvoiceDModel>? cart = [];

  List<SalesInvoiceHModel>? cartHdr = [];
  ScreenshotController screenshotController = ScreenshotController();


  String _selectSize = "2";
  final _txtText = TextEditingController(text: "");
  bool _progress = false;
  String _msjprogress = "";

 // String optionprinttype = "58 mm";
  String optionprinttype = "80 mm";
  List<String> options = ["58 mm", "80 mm"];
  setdata() {
    var PrintProviderr = Provider.of<PrintProvider>(context, listen: false);
    cart = PrintProviderr.getcart();
    cartHdr = PrintProviderr.getcartHdr();
  }
  @override
  void initState() {
    super.initState();
    setdata();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    var PrintProviderr = Provider.of<PrintProvider>(context, listen: false);
    var ThemP = Provider.of<Them>(context, listen: false);
    double unitHeightValue = MediaQuery.of(context).size.height * 0.00122;
    var stops = [0.0, 1.00];
    var LanguageProvider = Provider.of<Language>(context, listen: false);
    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* Text('info: $_info\n '),
                  Text(_msj),
                  Row(
                    children: [
                      Text("Type print"),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: optionprinttype,
                        items: options.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            optionprinttype = newValue!;
                          });
                        },
                      ),
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          this.getBluetoots();
                        },
                        child: Row(
                          children: [
                            Visibility(
                              visible: _progress,
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator.adaptive(strokeWidth: 1, backgroundColor: Colors.white),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(_progress ? _msjprogress : "Search"),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: connected ? this.disconnect : null,
                        child: Text("Disconnect"),
                      ),

                    ],
                  ),
                  Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: ListView.builder(
                        itemCount: items.length > 0 ? items.length : 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              String mac = items[index].macAdress;
                              this.connect(mac);
                            },
                            title: Text('Name: ${items[index].name}'),
                            subtitle: Text("macAddress: ${items[index].macAdress}"),
                          );
                        },
                      )),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white70.withOpacity(0.3),
                    ),
                    child: Column(children: [
                      /*Text("Text size without the library without external packets, print images still it should not use a library"),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _txtText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Text",
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          DropdownButton<String>(
                            hint: Text('Size'),
                            value: _selectSize,
                            items: <String>['1', '2', '3', '4', '5'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (String? select) {
                              setState(() {
                                _selectSize = select.toString();
                              });
                            },
                          )
                        ],
                      ),*/
                      Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                            child: Container(
                              color: Colors.white,
                              child: Screenshot(
                                controller: screenshotController,
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              Container(
                                                width:MediaQuery.of(context).size.width/3,
                                                child: Image(
                                                    image: new AssetImage(
                                                        "assets/logo.png")),
                                              ),
                                              Spacer(),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 18),
                                                  'مجموعه المجره'),
                                              Spacer(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18),
                                                  'فاتوره البيع'),
                                              Spacer(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              Text('اسم العميل : '),
                                              Text(PrintProviderr.CusName
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('رقم العميل : '),
                                              Text(cartHdr![0]
                                                  .Cust_No
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('رقم الفاتوره : '),
                                              Text(cartHdr![0]
                                                  .OrderNo
                                                  .toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      6.2,
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                  ),
                                                  child: Text(
                                                      textAlign:
                                                      TextAlign.center,
                                                      'اسم الماده')),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      6.2,
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                  ),
                                                  child: Text(
                                                      textAlign:
                                                      TextAlign.center,
                                                      'سعر الماده')),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      6.2,
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                  ),
                                                  child: Text(
                                                      textAlign:
                                                      TextAlign.center,
                                                      'الوحده')),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      6.2,
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                  ),
                                                  child: Text(
                                                      textAlign:
                                                      TextAlign.center,
                                                      'الضريبه')),

                                              Spacer(),
                                            ],
                                          ),
                                          for (int i = 0; i < cart!.length; i++)
                                            Row(
                                              children: [
                                                Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6.2,
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    child: Text(
                                                        textAlign:
                                                        TextAlign.center,
                                                        cart![i]
                                                            .name
                                                            .toString())),
                                                Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6.2,
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    child: Text(
                                                        textAlign:
                                                        TextAlign.center,
                                                        cart![i]
                                                            .price
                                                            .toString())),
                                                Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6.2,
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    child: Text(
                                                        textAlign:
                                                        TextAlign.center,
                                                        cart![i]
                                                            .unitname
                                                            .toString())),
                                                Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6.2,
                                                    height:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        6,
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    child: Text(
                                                        textAlign:
                                                        TextAlign.center,
                                                        cart![i]
                                                            .tax_Amt
                                                            .toString())),
                                                Spacer(),
                                              ],
                                            ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text('مجموع الضريبه : '),
                                              Text(cart![0].tax_Amt.toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('المجموع : '),
                                              Text(cart![0].total.toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),

                        ],
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          width: Globalvireables.getDeviceType() ==
                              'tablet'
                              ? MediaQuery.of(context).size.width /
                              2.5
                              : MediaQuery.of(context).size.width /
                              1.2,
                          margin: EdgeInsets.only(top: 40, bottom: 5),
                          color: HexColor(Globalvireables.white),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor(ThemP.getcolor()),
                            ),
                            child: Text(
                              LanguageProvider.Llanguage('print'),
                              style: ArabicTextStyle(
                                  arabicFont: ArabicFont.tajawal,
                                  color:
                                  HexColor(Globalvireables.white),
                                  fontSize: 13 * unitHeightValue),
                            ),
                            onPressed:  this.printTest
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    int porcentbatery = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      print("patformversion: $platformVersion");
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    print("bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
    } else {
      _msj = "Bluetooth not enabled";
    }

    setState(() {
      _info = platformVersion + " ($porcentbatery% battery)";
    });
  }

  Future<void> getBluetoots() async {
    setState(() {
      _progress = true;
      _msjprogress = "Wait";
      items = [];
    });
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    /*await Future.forEach(listResult, (BluetoothInfo bluetooth) {
      String name = bluetooth.name;
      String mac = bluetooth.macAdress;
    });*/

    setState(() {
      _progress = false;
    });

    if (listResult.length == 0) {
      _msj = "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msjprogress = "Connecting...";
      connected = false;
    });
    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) connected = true;
    setState(() {
      _progress = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printTest() async {
    try{
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    //print("connection status: $conexionStatus");
    if (conexionStatus) {
      List<int> ticket = await testTicket();
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("print test result:  $result");
    } else {
      //no conectado, reconecte
    }}catch(_){}
  }

  Future<void> printString() async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      String enter = '\n';
      await PrintBluetoothThermal.writeBytes(enter.codeUnits);
      //size of 1-5
      String text = "Hello";
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 1, text: text));
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 2, text: text + " size 2"));
      await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: 3, text: text + " size 3"));
    } else {
      //desconectado
      print("desconectado bluetooth $conexionStatus");
    }
  }

  Future<List<int>> testTicket() async {
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(optionprinttype == "58 mm" ? PaperSize.mm58 : PaperSize.mm80, profile);
    //bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();




    /*final ByteData data = await rootBundle.load('assets/logo.png');
    final Uint8List bytesImg = data.buffer.asUint8List();
    */
    final Uint8List? bytesImg = await screenshotController.capture();


    img.Image? image = img.decodeImage(bytesImg!);

    if (Platform.isIOS) {
      // Resizes the image to half its original size and reduces the quality to 80%
      final resizedImage = img.copyResize(image!, width: image.width ~/ 1.3, height: image.height ~/ 1.3, interpolation: img.Interpolation.nearest);
      final bytesimg = Uint8List.fromList(img.encodeJpg(resizedImage));
      //image = img.decodeImage(bytesimg);
    }

    //Using `ESC *`
    bytes += generator.image(image!);

   /* bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ', styles: PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød', styles: PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: PosStyles(align: PosAlign.right), linesAfter: 1);
*/
    /*bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
*/
    //barcode

  /*  final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));
*/
    //QR code
   /* bytes += generator.qrcode('example.com');

    bytes += generator.text(
      'Text size 50%',
      styles: PosStyles(
        fontType: PosFontType.fontB,
      ),
    );*/
  /*  bytes += generator.text(
      'Text size 100%',
      styles: PosStyles(
        fontType: PosFontType.fontA,
      ),
    );
    bytes += generator.text(
      'Text size 200%',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );*/

    bytes += generator.feed(2);
    //bytes += generator.cut();
    return bytes;
  }

  Future<void> printWithoutPackage() async {
    //impresion sin paquete solo de PrintBluetoothTermal
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      String text = _txtText.text.toString() + "\n";
      bool result = await PrintBluetoothThermal.writeString(printText: PrintTextSize(size: int.parse(_selectSize), text: text));
      print("status print result: $result");
      setState(() {
        _msj = "printed status: $result";
      });
    } else {
      //no conectado, reconecte
      setState(() {
        _msj = "no connected device";
      });
      print("no conectado");
    }
  }
}