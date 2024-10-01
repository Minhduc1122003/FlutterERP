import 'dart:convert';

import 'package:erp/config/mythemes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/hrm_model/employee_model.dart';
import '../../model/login_model.dart';
import '../../widget/dialog.dart';
import '../hrm/main_hrm_screen.dart';
import 'bloc/login_bloc.dart';
import 'widget/bezier_container.dart';
import 'widget/divider_widget.dart';
import 'widget/edit_text_widger.dart';
import 'widget/login_button_widget.dart';
import 'widget/title_widget.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Color gradientTop = const Color(0xFF4AB35E);
  Color gradientBottom = const Color(0xFF4AB35E);
  //Color mainColor = const Color(0xFF0181cc);
  Color mainColor = const Color(0xFF4AB35E);
  Color underlineColor = const Color(0xFFCCCCCC);

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    getUser();

    passwordController.text = '111';
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
    emailController.text = prefs.getString('user') ?? 'admin@REEME.com';
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
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: state.errorMessage,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red[300],
                textColor: Colors.white,
              );
            } else if (state is LoginWaiting) {
              FocusScope.of(context).unfocus();
              showProgressDialog(context);
            } else if (state is LoginSuccess) {
              Navigator.pop(context);

              User.name =
                  (state.loginData.profile['name'] != null) ? '' : 'Admin';
              User.name =
                  (state.loginData.profile['name'] != null) ? '' : 'Admin';
              User.no_ =
                  (state.loginData.profile['userName'] != null) ? '' : 'Admin';
              User.site =
                  (state.loginData.profile['site'] != null) ? '' : 'REEME';
              UserModel.siteName =
                  (state.loginData.profile['site'] != null) ? '' : 'REEME';
              print('site: ${User.site}');
              print('token: ${state.loginData.accessToken}');
              User.token = state.loginData.accessToken;
              UserModel.id = (state.loginData.profile['id'] != null)
                  ? int.parse(state.loginData.profile['id'].toString())
                  : 5;

              // User.name = state.loginData.name!;
              // User.no_ = state.loginData.no_!;
              // User.site = state.loginData.site ?? 'REEME';
              // User.token = state.loginData.jwTtoken!;flu
              // UserModel.id = (state.loginData.id != null)
              //     ? int.parse(state.loginData.id.toString())
              //     : 10088;

              saveUser();
              print('token: ${User.token}');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainHRMScreen()),
              );
            }
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: Platform.isIOS
                  ? SystemUiOverlayStyle.light
                  : const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: -height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: const BezierContainer()),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: height * .18),
                            const TitleWidget(),
                            const SizedBox(height: 50),
                            _emailPasswordWidget(),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () {
                                  var list1 = emailController.text.split("@");
                                  if (list1.length != 2) {
                                    Fluttertoast.showToast(
                                        msg: "Tài khoản không đúng",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red[300],
                                        textColor: Colors.white,
                                        fontSize: 13);
                                    return;
                                  }
                                  var list2 = list1[1].split(".");
                                  if (list2.length != 2) {
                                    Fluttertoast.showToast(
                                        msg: "Tài khoản không đúng",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.red[300],
                                        textColor: Colors.white,
                                        fontSize: 13);
                                    return;
                                  }

                                  User.site = list2[0].toUpperCase();
                                  String password =
                                      convertPassword(passwordController.text);
                                  String no_ = list1[0];
                                  print('NO: $no_');
                                  print('password: $password');
                                  print('Site: ${User.site}');
                                  loginBloc.add(Login(no_,
                                      passwordController.text, User.site, ''));
                                },
                                child: const LoginButtonWidget(text: 'Login')),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: const Text('Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const DividerWidget(),
                            //_facebookButton(),
                            SizedBox(height: height * .055),
                            _createAccountLabel(),
                          ],
                        ),
                      ),
                    ),
                    //const Positioned(top: 40, left: 0, child: BackButtonWidget()),
                  ],
                ),
              )),
        ));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EditTextWidget(
          title: "Email",
          isPassword: false,
          controller: emailController,
        ),
        EditTextWidget(
          title: "Password",
          isPassword: true,
          controller: passwordController,
        ),
      ],
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: mainColor2, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  String convertPassword(String s) {
    // return s;
    String pw = "";
    List<int> bytes = utf8.encode(s);
    bytes = sha1.convert(bytes).bytes;
    for (var item in bytes) {
      pw += item.toString();
    }
    return pw;
  }
}
