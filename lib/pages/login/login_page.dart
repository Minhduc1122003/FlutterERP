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
import '../../network/api_provider.dart';
import '../../widget/dialog.dart';
import '../hrm/main_hrm_screen.dart';
import 'bloc/login_bloc.dart';
import 'widget/bezier_container.dart';
import 'widget/divider_widget.dart';
import 'widget/edit_text_widger.dart';
import 'widget/login_button_widget.dart';
import 'widget/title_widget.dart';

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
    passwordController.text = 'chi@2023';
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
              User.name = state.loginData.profile['name'];
              User.no_ = state.loginData.profile['userName'];
              User.site = state.loginData.profile['site'];
              User.token = state.loginData.accessToken;
              UserModel.id =
                  int.parse(state.loginData.profile['id'].toString());
              saveUser();
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
                                  loginBloc
                                      .add(Login(no_, password, User.site, ''));
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
    return s;
    // String pw = "";
    // List<int> bytes = utf8.encode(s);
    // bytes = sha1.convert(bytes).bytes;
    // for (var item in bytes) {
    //   pw += item.toString();
    // }
    // return pw;
  }
}
