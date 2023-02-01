import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/hrm/on_leave/bloc/on_leave_bloc.dart';
import 'pages/hrm/request_management/bloc/request_management_bloc.dart';
import 'pages/hrm/salary/bloc/salary_caculate_bloc.dart';
import 'pages/hrm/shift_calendar/bloc/shift_calendar_bloc.dart';
import 'pages/hrm/timekeeping/bloc/timekeeping_bloc.dart';
import 'pages/hrm/timekeeping_offset/bloc/timekeeping_offset_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimekeepingBloc>(
          create: (BuildContext context) => TimekeepingBloc(),
        ),
        BlocProvider<ShiftCalendarBloc>(
          create: (BuildContext context) => ShiftCalendarBloc(),
        ),
        BlocProvider<TimekeepingOffsetBloc>(
          create: (BuildContext context) => TimekeepingOffsetBloc(),
        ),
        BlocProvider<OnLeaveBloc>(
          create: (BuildContext context) => OnLeaveBloc(),
        ),
        BlocProvider<RequestManagementBloc>(
          create: (BuildContext context) => RequestManagementBloc(),
        ),
          BlocProvider<SalaryCaculateBloc>(
          create: (BuildContext context) => SalaryCaculateBloc(),
        ),
      ],
      child: MaterialApp(
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
        supportedLocales: const [
          Locale('vi', 'VN'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}
