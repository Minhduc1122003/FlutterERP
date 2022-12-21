import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'pages/login/login_screen.dart';
import 'pages/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [],
      title: 'CRM',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        //fontFamily: 'Gilroy',
        //fontFamily: 'Be VietNam',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      locale: const Locale('vn'),
      supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US'),],
    );
  }
}
