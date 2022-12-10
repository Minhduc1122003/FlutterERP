import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:erp/pages/splash/splash_screen.dart';
import 'package:erp/pages/visit/bloc/check_in_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CheckInBloc>(
            create: (BuildContext context) => CheckInBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'CRM',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //fontFamily: 'Gilroy',
            fontFamily: 'Be VietNam',
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          // supportedLocales: const [Locale('vi', 'VN')],
        ));
  }
}
