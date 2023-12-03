import 'dart:convert';
import 'dart:typed_data';
import 'package:arabic_font/arabic_font.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io';

import 'package:flutter/services.dart';
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


import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io';
class Print extends StatefulWidget {
  const Print({Key? key}) : super(key: key);

  @override
  State<Print> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Print> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  String base64Image = '';

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';
  List<LineText> list = [];

  setdata() {
    var PrintProviderr = Provider.of<PrintProvider>(context, listen: false);
    cart = PrintProviderr.getcart();
    cartHdr = PrintProviderr.getcartHdr();
  }

  @override
  void initState() {
    super.initState();
    setdata();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  var max = 0;
  TextEditingController dateinputC = TextEditingController();
  TextEditingController unitcontroller = TextEditingController();

  bool IncludeTex = true;
  bool Cash = true;
  PriceModel? selectedObjecttest;

  List<PriceModel> myObjects = [];
  int selectedIndex = -1;

  List<SalesInvoiceDModel>? cart = [];

  List<SalesInvoiceHModel>? cartHdr = [];
  ScreenshotController screenshotController = ScreenshotController();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Connect'),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: RefreshIndicator(
            onRefresh: () =>
                bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(tips),
                      ),
                    ],
                  ),
                  Divider(),
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: bluetoothPrint.scanResults,
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data!
                          .map((d) => ListTile(
                                title: Text(d.name ?? ''),
                                subtitle: Text(d.address ?? ''),
                                onTap: () async {
                                  setState(() {
                                    _device = d;
                                  });
                                },
                                trailing: _device != null &&
                                        _device!.address == d.address
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null,
                              ))
                          .toList(),
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlinedButton(
                              child: Text('connect'),
                              onPressed: _connected
                                  ? null
                                  : () async {
                                try {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'connecting...';
                                    });
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips = 'please select device';
                                    });
                                    print('please select device');
                                  }
                                }catch(e){
                                  print('printerrorr' + e.toString());

                                }
                                    },
                            ),
                            SizedBox(width: 10.0),
                            OutlinedButton(
                              child: Text('disconnect'),
                              onPressed: _connected
                                  ? () async {
                                      setState(() {
                                        tips = 'disconnecting...';
                                      });
                                      await bluetoothPrint.disconnect();
                                    }
                                  : null,
                            ),
                          ],
                        ),
                        Divider(),
                        OutlinedButton(
                          child: Text('print receipt(esc)'),
                          onPressed: () async {
                            try {

                              Map<String, dynamic> config = Map();

                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content:
                                    'Galaxy International Group',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,

                                content: PrintProviderr.CusName
                                    .toString()+'اسم العميل : ',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                fontZoom: 2,
                                linefeed: 1));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,

                                  content: PrintProviderr.CusName
                                      .toString()+'اسم العميل : ',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  fontZoom: 2,
                                  linefeed: 1));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,

                                  content: PrintProviderr.CusName
                                      .toString()+'اسم العميل : ',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  fontZoom: 2,
                                  linefeed: 1));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,

                                  content: PrintProviderr.CusName
                                      .toString()+'اسم العميل : ',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  fontZoom: 2,
                                  linefeed: 1));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,

                                  content: PrintProviderr.CusName
                                      .toString()+'اسم العميل : ',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  fontZoom: 2,
                                  linefeed: 1));






                           /* list.add(LineText(linefeed: 1));
                              ByteData data = await rootBundle.load("assets/logo.png");
                              List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                              String base64Image = base64Encode(imageBytes);
                              list.add(LineText(type: LineText.TYPE_IMAGE,  content: base64Image,));

*/
  await bluetoothPrint.printReceipt(config, list);
}catch(e){
  print("printerrorr : "+e.toString());

}                      },
                        ),
                        Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(0.0)),
                            ),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                  child: Screenshot(
                                    controller: screenshotController,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, bottom: 20),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Center(
                                                child: Image(
                                                    image: new AssetImage(
                                                        "assets/logo.png")),
                                              ),
                                            ),
                                          ),
                                          Text(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                              'Galaxy International Group'),
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
                                              Spacer(),
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
                                                      'البونص')),
                                              Spacer(),
                                            ],
                                          ),
                                          for (int i = 0; i < cart!.length; i++)
                                            Row(
                                              children: [
                                                Spacer(),
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
                                                            5,
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
                                                            5,
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
                                                            5,
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
                                                            5,
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
                                                            5,
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
                                                            .Bounce
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
                               /* Container(
                                  color: Colors.redAccent,
                                  height: MediaQuery.of(context).size.height/1.7,
                                  child: Image.memory(
                                    base64Decode(base64Image),
                                  ),
                                ),
*/

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
                                      onPressed: () async {



                                        oldprint();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                        /*SizedBox(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.width/1.2,
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(list[index].content.toString()),
                                ),
                              );
                            },
                          ),
                        ),
          */

                        /*  OutlinedButton(
                          child: Text('print label(tsc)'),
                          onPressed:  _connected?() async {
                            Map<String, dynamic> config = Map();
                            config['width'] = 40; // 标签宽度，单位mm
                            config['height'] = 70; // 标签高度，单位mm
                            config['gap'] = 2; // 标签间隔，单位mm

                            // x、y坐标位置，单位dpi，1mm=8dpi
                            List<LineText> list = [];
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: 'A Title'));
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:40, content: 'this is content'));
                            list.add(LineText(type: LineText.TYPE_QRCODE, x:10, y:70, content: 'qrcode i\n'));
                            list.add(LineText(type: LineText.TYPE_BARCODE, x:10, y:190, content: 'qrcode i\n'));

                            List<LineText> list1 = [];
                            ByteData data = await rootBundle.load("assets/logo.png");
                            List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                            String base64Image = base64Encode(imageBytes);
                            list1.add(LineText(type: LineText.TYPE_IMAGE, x:10, y:10, content: base64Image,));

                            await bluetoothPrint.printLabel(config, list);
                            await bluetoothPrint.printLabel(config, list1);
                          }:null,
                        ),
                        OutlinedButton(
                          child: Text('print selftest'),
                          onPressed:  _connected?() async {
                            await bluetoothPrint.printTest();
                          }:null,
                        )*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                      bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }

oldprint() async {

  try {              Map<String, dynamic> config = Map();
    config['width'] = 40; // 标签宽度，单位mm
                                        config['height'] = 200; // 标签高度，单位mm
                                        config['gap'] = 2; // 标签间隔，单位mm



  List<LineText> list = [];


  Uint8List? uint8list = await screenshotController.capture();
  if (uint8list != null) {

   // List<int> imageBytes = uint8list.buffer.asUint8List(uint8list.offsetInBytes, uint8list.lengthInBytes);

  //  base64Image = base64Encode(imageBytes);

    ByteData data = await rootBundle.load("assets/logo.png");
    List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    String base64Image = base64Encode(imageBytes);
    list.add(LineText(type: LineText.TYPE_IMAGE, x:10, y:10, content: base64Image,));


   // list.add(LineText(type: LineText.TYPE_IMAGE, content: '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', align: LineText.ALIGN_CENTER, linefeed: 1));

    //    list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image,));

  //  await bluetoothPrint.printReceipt(config, data)
    await bluetoothPrint.printReceipt(config, list);
  } else {
    print("Error capturing screenshot.");
  }
  } catch (e) {
    print("Error capturing and converting to base64: $e");
  }
}

}
