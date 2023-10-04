import 'dart:convert';
import 'package:cashvanmobile/SharedPrefrence/StoreShared.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:arabic_font/arabic_font.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../ColorsLanguage/GlobalVar.dart';
import '../ColorsLanguage/HexaColor.dart';
import '../Models/UsersModel.dart';
import '../Providers/LoginProvider.dart';
import '../Providers/Them.dart';
import '../Providers/languageProvider.dart';
import '../Sqlite/DatabaseHandler.dart';
import '../Sqlite/GettAllData.dart';
import 'Home.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _ipControler = TextEditingController();


  var check = false;

  @override
  void initState() {
    final handler = DatabaseHandler();

    handler.initDatabase();
    Getrememper();
    super.initState();
  }

  var Terms;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  var prefs;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  var Loginprovider;

  @override
  Widget build(BuildContext context) {
    _ipControler.text = '10.0.1.65:9999';
    double unitHeightValue = MediaQuery
        .of(context)
        .size
        .height * 0.00122;


    var ThemP = Provider.of<Them>(context, listen: false);
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    return Stack(children: <Widget>[
      Image.asset(
        "assets/background.png",
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Directionality(
          textDirection: LanguageProvider.getDirection(),
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        Container(
                        margin: EdgeInsets.only(top: 25),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1,
                        child: Column(
                            children: [
                        Center(
                        child: Container(
                        width: Globalvireables.getDeviceType() == 'tablet'
                            ? MediaQuery
                            .of(context)
                            .size
                            .width / 2
                            : MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        height: Globalvireables.getDeviceType() ==
                        'tablet' ? MediaQuery
                        .of(context)
                        .size
                        .width / 5 : MediaQuery
                        .of(context)
                        .size
                        .width / 2,

                    child: Image(
                        image: new AssetImage(
                            "assets/logo.png"))),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 0),
                  child: Text(
                      textAlign: TextAlign.center,
                      LanguageProvider.Llanguage("galaxycasgvan"),
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.tajawal,
                          color: HexColor(Globalvireables.black2),
                          fontSize: Globalvireables.getDeviceType()=='tablet'?40:28 * unitHeightValue,
                          fontWeight: FontWeight.w900)
                  )),
              SizedBox(
                height: 17,
              ),
              Container(
                width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2.5:
                MediaQuery.of(context).size.width/1.5,

                  margin: EdgeInsets.only(
                      left: 25, right: 25, top: 10),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.email, color: HexColor(ThemP.getcolor())),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(
                                  Globalvireables.black),
                              width: 0.0),
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(
                                  ThemP.getcolor()),
                              width: 1.0),
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.only(
                          top: 18,
                          bottom: 18,
                          right: 20,
                          left: 20),
                      fillColor:
                      HexColor(Globalvireables.white),
                      filled: true,
                      hintText: LanguageProvider.Llanguage(
                          "username"),
                    ),
                  )),
              Container(
                  width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2.5:
                  MediaQuery.of(context).size.width/1.5,
                  margin: EdgeInsets.only(
                      left: 25, right: 25, top: 44),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscured,
                    controller: _passController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.admin_panel_settings_sharp,
                        color: HexColor(ThemP.getcolor()),),
                      suffixIcon: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(_obscured
                              ? Icons.remove_red_eye_rounded
                              : Icons.lens_blur_outlined)),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(
                                  ThemP.getcolor()),
                              width: 0.0),
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor(
                                  ThemP.getcolor()),
                              width: 1.0),
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.only(
                          top: 18,
                          bottom: 18,
                          right: 20,
                          left: 20),
                      fillColor:
                      HexColor(Globalvireables.white),
                      filled: true,
                      hintText: LanguageProvider.Llanguage(
                          'password'),
                    ),
                  )),

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
                      LanguageProvider.Llanguage('login'),
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.tajawal,
                          color:
                          HexColor(Globalvireables.white),
                          fontSize: 13 * unitHeightValue),
                    ),
                    onPressed: () async {

                     // GettAllData.GetAllUser(context);


     Login(_emailController.text.toString(),
                          _passController.text.toString());
     /*                  Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Index(),
                                          ),Login
                                          (Route<dynamic> route) => false);*/
                    },
                  ),
                ),
              ),
              if (LanguageProvider.langg == "AR")
          Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(
                left: 25, right: 25, top: 0),
            child: Row(
              children: [
                Checkbox(
                    value: check,
                    //set variable for value
                    onChanged: (bool? value) async {
                      setState(() {
                        check = !check;

                        if (!check) {
                          prefs.setString('username', '');
                          prefs.setString('password', '');
                        }

                        //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                        //   saveREstate(check.toString());
                      });
                    }),
                Text(
                    LanguageProvider.Llanguage(
                        "RememberMe"),
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.tajawal,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:
                        12 * unitHeightValue)),
              ],
            ),
          ),
        )
        else
        Align(
        alignment: Alignment.topLeft,
        child: Container(

          margin: EdgeInsets.only(
           left: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context)
          .size.width/3:10, right: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context)
          .size.width/3:10, top: 0),
          child: Row(
            children: [
              Checkbox(
                  value: check,
                  //set variable for value
                  onChanged: (bool? value) async {
                    setState(() {
                      check = !check;

                      if (!check) {
                        prefs.setString('username', '');
                        prefs.setString('password', '');
                      }
                    });
                  }),
              Text(
                  LanguageProvider.Llanguage(
                      "RememberMe"),
                  style: ArabicTextStyle(
                      arabicFont: ArabicFont.tajawal,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize:
                      12 * unitHeightValue)),
            ],
          ),
        ),
      ),
      SizedBox(
        width: Globalvireables.getDeviceType()=='tablet'?MediaQuery.of(context).size.width/2.5:
        MediaQuery.of(context).size.width/1.2,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width:
            MediaQuery
                .of(context)
                .size
                .width / 1.2,
            margin: EdgeInsets.only(top: 10, bottom: 30),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:
                  HexColor(ThemP.getcolor()),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      LanguageProvider.Llanguage(
                          'finger'),
                      style: ArabicTextStyle(
                          arabicFont: ArabicFont.tajawal,
                          color: Colors.white,
                          fontSize: 12 * unitHeightValue),
                    ),
                    Spacer(),
                    Icon(
                      Icons.fingerprint,
                      color: Colors.white,
                    )
                  ],
                ),
                onPressed: () async {
                  try {
                    final bool didAuthenticate = await auth.authenticate(

                      localizedReason: 'Please authenticate to show account balance',
                      options: const AuthenticationOptions(
                          useErrorDialogs: true,
                          stickyAuth: false,
                          sensitiveTransaction: true
                      ),
                    );
                    if (didAuthenticate && check) {
                      prefs = await SharedPreferences.getInstance();
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text(
                                    LanguageProvider.Llanguage('login')),
                                content: Text(LanguageProvider.Llanguage(
                                    'loginerrorfinget')),
                              ));
                    }
                  } on PlatformException catch (e) {
                    print("errorlogiin " + e.message.toString());
                    /* if (e.code == auth_error.notEnrolled) {
                                              // Add handling of no hardware here.
                                            } else if (e.code == auth_error.lockedOut ||
                                                e.code == auth_error.permanentlyLockedOut) {
                                            } else {
                                             print("errorlogiin "+ e.message.toString());
                                            }*/
                  }
                }),
          ),
        ),
      ),
      SizedBox(height: 14),
      LanguageProvider.getLanguage() != 'AR' ?
      Center(
        child: Row(
          children: [
            Spacer(),
            Text(
              "Powered By",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.black)),
            ),
            SizedBox(width: 5,),
            Image.asset(
              "assets/logo.png",
              height: 25,
            ),
            Spacer()

          ],
        ),
      ) :
      Center(
        child: Row(
          children: [
            Spacer(),
            Image.asset(
              "assets/logo.png",
              height: 25,
            ),
            SizedBox(width: 5,),
            Text(
              "Powered By",
              style: ArabicTextStyle(
                  arabicFont: ArabicFont.tajawal,
                  color: HexColor(Globalvireables.black)),
            ),
            Spacer()
          ],
        ),
      )


    ],
    ),
    ),
    ]),
    ),
    ),
    ),
    ),
    ),
    ),
    ]);
  }


  cleanRemember(bool r) async {
    prefs = await SharedPreferences.getInstance();

    if (!r) {
      prefs.setString('username', '');
      prefs.setString('password', '');
    }
  }

  final LocalAuthentication auth = LocalAuthentication();

  Getrememper() async {
    prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('them') != null && prefs
          .getString('them')
          .toString()
          .length > 4) {
        Provider.of<Them>(context, listen: false).setcolor(
            prefs.getString('them').toString());
      }
    } catch (_) {

    }

    setState(() {
      Future<void> authinticate() async {

      }

      if (prefs
          .getString('password')
          .toString()
          .length > 1 && prefs.getString('password').toString() != 'null'
          && prefs.getString('password').toString() != null) {
        _passController.text = prefs.getString('password').toString();
        _emailController.text = prefs.getString('username').toString();

        check = true;
      } else {
        _passController.text = '';
        _emailController.text = '';
      }
    });
  }


  Future<List<UsersModel>> Login(String username, String passwor) async {
    var LanguageProvider = Provider.of<Language>(context, listen: false);

    var Loginprovider = Provider.of<LoginProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text(LanguageProvider.Llanguage('login')),
              content: Text(LanguageProvider.getLanguage() == "AR"
                  ? 'جار تسجيل الدخول ...'
                  : 'Logging in...'),
            ));


    Uri apiUrl = Uri.parse(Globalvireables.loginAPI);


    try {
      http.Response res = await http.post(
        apiUrl,
      );

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);


        StoreShared.SaveJson(Globalvireables.UsersJson, res.body.toString());

        List<UsersModel> users = body
            .map(
              (dynamic item) => UsersModel.fromJson(item),
        )
            .toList();


        List<UsersModel> login = users.where((element) =>
        element.password == passwor && element.loginName == username
        ).toList();

        print("LOGINJSON : " + login.length.toString());

        if (login.first.loginName == username) {
          prefs = await SharedPreferences.getInstance();

          if (check) {
            prefs.setString('username', username);
            prefs.setString('password', passwor);
          }


          Loginprovider.setnameA(login.first.arabicName.toString());
          Loginprovider.setnameE(login.first.englishName.toString());
          Loginprovider.setid(login.first.id.toString());

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
                  (Route<dynamic> route) => false);
        } else {
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(LanguageProvider.Llanguage('login')),
                    content: Text(LanguageProvider.Llanguage('anerror')),
                  ));
        }


        return users;
      } else {
        throw "Unable to retrieve Doctors. orrr";
      }
    } catch (e) {
      print("CATCH  + " + e.toString());
      print(
          "SHARED  + " + await StoreShared.getJson(Globalvireables.UsersJson));


      if (await StoreShared.checkNetwork()) {
        await showDialog(
          context: context,
          builder: (context) =>
          new AlertDialog(
            title: new Text(LanguageProvider.Llanguage('anerrortitle')),
            content: Text(LanguageProvider.Llanguage('anerror')),

            actions: <Widget>[],
          ),
        );
      } else {
        List<dynamic> body = jsonDecode(
            await StoreShared.getJson(Globalvireables.UsersJson));

        List<UsersModel> users = body
            .map(
              (dynamic item) => UsersModel.fromJson(item),
        )
            .toList();


        List<UsersModel> login = users.where((element) =>
        element.password == passwor && element.loginName == username
        ).toList();

        if (login.first.loginName == username) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
                  (Route<dynamic> route) => false);
        } else {
          showDialog(
              context: context,
              builder: (_) =>
                  AlertDialog(
                    title: Text(LanguageProvider.Llanguage('login')),
                    content: Text(LanguageProvider.Llanguage('anerror')),
                  ));
        }
      }
    }

    throw "Unable to retrieve Doctors.";
  }


}
