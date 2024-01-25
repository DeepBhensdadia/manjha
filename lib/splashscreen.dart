import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manjha/screens/authscreens/loginscreen.dart';
import 'package:manjha/services/apiconst.dart';

import 'screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animateBg = true;
  // void _changeAlignment() {
  //   setState(() {
  //     _animateBg = false;
  //   });
  // }

  int speedFactor = 1;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: kheader,
    //   systemNavigationBarColor: kheader,
    //   statusBarIconBrightness: Brightness.dark,
    // ));
    return Scaffold(
      // backgroundColor: korange,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/bg-1.png"),
          //     fit: BoxFit.contain,
          //     alignment: Alignment.topRight,
          //   ),
          // ),
            child: Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/bg-2.png"),
              //     fit: BoxFit.contain,
              //     alignment: Alignment.bottomRight,
              //   ),
              // ),
              child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // getHeader(context),
                  // getFooter(context),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        // BoldText("Aight",35.0,kdarkBlue),
                        // Padding(
                        // padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                        // child:
                        ScaleTransition(
                          scale: CurvedAnimation(
                            parent: _controller,
                            curve: Curves.easeInOutCubic,
                          ),
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage('assets/logo.png'),
                            fit: BoxFit.contain,
                            width: 225, //_animate ? 225 : 10,
                          ),
                        ),
                        //),
                        SizedBox(height: 20),
                        // TypewriterAnimatedTextKit(
                        //   text: ["Loading...!"],
                        //   textStyle: TextStyle(
                        //       fontSize: 18.0,
                        //       color: Colors.black38,
                        //       // color: kwhite,
                        //       fontFamily: "nunito"),
                        //   speed: Duration(milliseconds: 100),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  double durationFast = 0.6;
  // Widget getFooter(BuildContext context) {
  //   print(_animateBg);
  //   return new Positioned(
  //       child: Stack(
  //     alignment: Alignment.center,
  //     fit: StackFit.expand,
  //     children: [
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         left: 0,
  //         bottom: _animateBg ? -200 : 0,
  //         curve: Curves.easeOutCubic,
  //         duration: Duration(milliseconds: 500 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgfooter-1.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.bottomLeft,
  //           height: 275,
  //         ),
  //       ),
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         left: _animateBg ? -250 : 0,
  //         bottom: 0.0,
  //         curve: Curves.easeInOutCubic,
  //         duration: Duration(milliseconds: 1500 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgfooter-12.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.bottomLeft,
  //           height: 275,
  //         ),
  //       ),
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         left: _animateBg ? 400 : 0,
  //         bottom: 0.0,
  //         curve: Curves.easeInOutCubic,
  //         duration: Duration(milliseconds: 1000 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgfooter-11.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.bottomLeft,
  //           height: 275,
  //         ),
  //       ),
  //       // Center(
  //       //   child: ElevatedButton(
  //       //     style: ElevatedButton.styleFrom(primary: Colors.black),
  //       //     onPressed: () => _changeAlignment(),
  //       //     child: Text('START'),
  //       //   ),
  //       // )
  //     ],
  //   ));
  // }

  // Widget getHeader(BuildContext context) {
  //   return new Positioned(
  //       child: Stack(
  //     alignment: Alignment.center,
  //     fit: StackFit.expand,
  //     children: [
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         left: 0,
  //         top: _animateBg ? -200 : 0,
  //         curve: Curves.easeOutCubic,
  //         duration: Duration(milliseconds: 500 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgheader-1.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.topRight,
  //           height: 275,
  //         ),
  //       ),
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         right: _animateBg ? -200 : 0,
  //         top: 0.0,
  //         curve: Curves.easeInOutCubic,
  //         duration: Duration(milliseconds: 1000 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgheader-12.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.topRight,
  //           height: 275,
  //         ),
  //       ),
  //       AnimatedPositioned(
  //         // alignment: _geometry,
  //         right: _animateBg ? 300 : 0,
  //         top: 0.0,
  //         curve: Curves.easeInOutCubic,
  //         duration: Duration(milliseconds: 1000 * speedFactor),
  //         child: Image.asset(
  //           'assets/bgheader-11.png',
  //           fit: BoxFit.contain,
  //           alignment: Alignment.topRight,
  //           height: 275,
  //         ),
  //       )
  //     ],
  //   ));
  // }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _animateBg = false;
    // Timer(Duration(milliseconds: 750 * speedFactor), () => _changeAlignment());
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000 * speedFactor),
      // TickerProvider: this,
      vsync: this,
    )..forward();

    Future.delayed(Duration(milliseconds: 1000 * speedFactor), () async {
      // bool selected = await Pref.getLanguageConfigured();
      // String language = selected ? await Pref.getLanguageCode() : "en";
      // Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return (selected) ? LocationScreen() : LanguageScreen();
      // }));
         saveUser() == null ? Get.to(LoginMobilePage()) : Get.to(MainScreens());
      // return LandingPage();
    });
  }
}
