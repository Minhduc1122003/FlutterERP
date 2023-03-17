import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/login_model.dart';
import '../home/home_screen.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  Color gradientTop = const Color(0xFF4AB35E);
  Color gradientBottom = const Color(0xFF4AB35E);
  //Color mainColor = const Color(0xFF0181cc);
  Color mainColor = const Color(0xFF4AB35E);
  Color underlineColor = const Color(0xFFCCCCCC);

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUser() async {
    if (Platform.isAndroid) {
      SharedPreferencesAndroid.registerWith();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('user') ?? '';
  }

  saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        //appBar: AppBar(toolbarHeight: 0,elevation: 0,backgroundColor: gradientTop,),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red[300],
                textColor: Colors.white,
              );
            }
            if (state is LoginWaiting) {
               FocusScope.of(context).unfocus();
              // _globalFunction.showProgressDialog(context);
            }
            if (state is LoginSuccess) {
              //Navigator.pop(context);
              User.name = state.loginData.profile['name'];
              User.no_ = state.loginData.profile['userName'];
              User.site = state.loginData.profile['site'];
              User.token = state.loginData.accessToken;
              saveUser();
              // ignore: use_build_context_synchronously
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomeScreen()),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: Platform.isIOS
                ? SystemUiOverlayStyle.light
                : const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light),
            child: Stack(
              children: <Widget>[
                // top blue background gradient
                Container(
                  height: height / 3.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [gradientTop, gradientBottom],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                // set your logo here
                Container(
                  margin: EdgeInsets.fromLTRB(0, height / 14, 0, 0),
                  alignment: Alignment.topCenter,
                  //child: Image.asset('assets/images/logo_dark.png', height: 120),
                  child: Image.network(
                      "http://kiena.vietgoat.com:8080/Resources/Documents/logo.jpg",
                      height: height / 7),
                  // child: Text(
                  //   'CRM',
                  //   style: GoogleFonts.gotu(
                  //     textStyle:const TextStyle(color: Colors.white),
                  //     fontSize: 35,
                  //     fontWeight: FontWeight.w700,
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  // ),
                ),
                Column(
                  children: <Widget>[
                    // create form login
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(32, height / 4, 32, 0),
                      color: Colors.white,
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 40),
                              Center(
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600]!)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underlineColor),
                                    ),
                                    labelText: 'Email',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                obscureText: _obscureText,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[600]!)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underlineColor),
                                  ),
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[700]),
                                  suffixIcon: IconButton(
                                      icon: Icon(_iconVisible,
                                          color: Colors.grey[700], size: 20),
                                      onPressed: () {
                                        _toggleObscureText();
                                      }),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    // Fluttertoast.showToast(
                                    //     msg: 'Click forgot password',
                                    //     toastLength: Toast.LENGTH_SHORT);
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) =>
                                            mainColor,
                                      ),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                    ),
                                    onPressed: () {
                                      var user =
                                          emailController.text.split(".");
                                      if (user.length != 2) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Incorrect account or password",
                                            toastLength: Toast.LENGTH_LONG,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 13);
                                        return;
                                      }
                                      User.site = emailController.text
                                          .split("@")[1]
                                          .split(".")[0]
                                          .toUpperCase();
                                      String password = convertPassword(
                                          passwordController.text);
                                      String no_ =
                                          emailController.text.split("@")[0];
                                      loginBloc.add(
                                          Login(no_, password, User.site, ''));
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           const HomeScreen()),
                                      // );
                                      // Fluttertoast.showToast(
                                      //     msg: 'Click login',
                                      //     toastLength: Toast.LENGTH_SHORT);
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 50),
                    // create sign up link
                    Center(
                      child: Wrap(
                        children: <Widget>[
                          const Text('New User? '),
                          GestureDetector(
                            onTap: () {
                              // Fluttertoast.showToast(
                              //     msg: 'Click signup',
                              //     toastLength: Toast.LENGTH_SHORT);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  String convertPassword(String s) {
    return s;
    String pw = "";
    List<int> bytes = utf8.encode(s);
    bytes = sha1.convert(bytes).bytes;
    for (var item in bytes) {
      pw += item.toString();
    }
    return pw;
  }
}
