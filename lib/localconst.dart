import 'dart:convert';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:manjha/services/apiconst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

// import '../main.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String sessionCookie = "COOKIE";

class Common {
  static const CONST_MapBoxTokenKey =
      'pk.eyJ1IjoiZGl2eWFtZ2wyNyIsImEiOiJja2pzNmxsNjYyZms1MzBtancyaHh6OHYzIn0.jAm9YQFTmfCus68C1HtvHw';
  static const PAYTM_MID =
      "EJpcwX73628126041744"; //EJpcwX73628126041744 // LbYfaI85555014779522
  // static const PAYTM_MID = "LbYfaI85555014779522";
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final isIOS = Platform.isIOS;

  // static Uri getURL(methodName) {
  //   String requestUrl = api_url + methodName;
  //   print(requestUrl);
  //   return Uri.parse(requestUrl) ;
  // }

  static Map<String, String> headers = {};
  static getCookie() {
    if (headers.containsKey("cookie")) return headers["cookie"];
    return "";
  }

  static void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  static void updateCookieRaw(String rawCookie) {
    // String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = -1; //rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
      setSession(sessionCookie, rawCookie);
    }
  }

  static Future<String> getRawCookie() {
    return getSession(sessionCookie);
  }

  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      if (value == null) return 0.0;
      return value * 1.0;
    }
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static Color getHaxColor(color) {
    var hexColor = color.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Colors.transparent;
  }



  static Uri getURL(methodName) {
    String requestUrl = baseUrl + methodName;
    print(requestUrl);
    return Uri.parse(requestUrl) ;
  }

  static Future<String> getSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setSession(String key, String value) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(key, value);
  }

  static Future<bool> clearSession(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    return prefs.remove(key);
  }

  /* ----------------------------------------------------------- */
  static var textFormFieldRegular = TextStyle(
      fontSize: 16,
      fontFamily: "Helvetica",
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static var textFormFieldLight =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

  static var textFormFieldMedium =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

  static var textFormFieldSemiBold =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

  static var textFormFieldBold =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

  static var textFormFieldBlack =
  textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);

  static FadeInImage fadeImage(imageUrl, {double? height, double? width}) {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/no-photo.png',
        height: height,
        width: width,
        fadeInDuration: Duration(milliseconds: 100),
        image: imageUrl);
  }

  static DecorationImage containerImage(imageUrl) {
    return DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        imageUrl,
      ),
    );
  }

  // static String profile_url =
  //     "https://cdn1.iconfinder.com/data/icons/user-pictures/100/boy-128.png";
  static var cartCount = 0;
  static var cartTotal = 0;
  // static Future<Void> setCartCount(int total) {
  //   cartCount = total;
  //   setState
  // }

  static Widget getCartButton(BuildContext context,
      {Color color = Colors.white, Function()? refreshCallback}) {
    return new FutureBuilder(
        future: Future.value(cartCount),
        builder: (context, snapshot) {
          return IconButton(
              icon: Stack(children: [
                Container(
                  // margin: EdgeInsets.only(right: 8),
                  // decoration: BoxDecoration(
                  //   color: kColorAppDefault,
                  //   borderRadius: BorderRadius.circular(100),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       blurRadius: 2.0,
                  //       color: Colors.black,
                  //     )
                  //   ],
                  // ),
                    padding: EdgeInsets.only(top: 8, right: 8),
                    child: Icon(Icons.shopping_cart, color: color)),
                Visibility(
                  visible: (Common.cartCount > 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(Common.cartCount.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black)),
                    ),
                  ),
                ),
              ]),
              onPressed: () async {
                // dynamic result = await Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => StoreCartPage()),
                // );
                // print('helloworld...');
                // if (refreshCallback != null && result != null && result == true)
                //   refreshCallback.call();
                // print('helloworld...2');
              });
        });
  }

  static Widget getSupportButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.call),
        onPressed: () {
          // this._login();
          launch("tel:+917071270718");
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return StoreProfilePage();
          // }));
        });
  }

  /* ----------------------------------------------------------- */

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  /* ----------------------------------------------------------- */

}


