import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:erp/config/constant.dart';
import 'package:erp/pages/login/login_screen.dart';
import 'package:universal_io/io.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  int _second = 3; // set timer for 3 second and then direct to next page

  void _startTimer() {
    const period = Duration(microseconds: 500);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelFlashsaleTimer();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  void _cancelFlashsaleTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      Platform.isIOS
          ? SystemUiOverlayStyle.light
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: BLACK21,
              systemNavigationBarIconBrightness: Brightness.light),
    );

    if (_second != 0) {
      _startTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashsaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        color: BLACK21,
        child: Center(
          //child: Image.asset('assets/images/logo_dark.png', height: 200),
          child: Text(
            'CRM',
            style: GoogleFonts.inknutAntiqua(
              textStyle: const TextStyle(color: Colors.white),
              fontSize: 40,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              shadows: [
                for (double i = 1; i < 5; i++)
                  BoxShadow(
                      spreadRadius: 1,
                      color: Colors.blue,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 5 * i),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
