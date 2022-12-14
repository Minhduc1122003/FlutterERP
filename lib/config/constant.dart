// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const String APP_NAME = 'DevKit';

// color for apps
const Color PRIMARY_COLOR = Color(0xFF0181cc);
const Color ASSENT_COLOR = Color(0xFFe75f3f);

const Color backgroundColor=Color(0xFFB3C0E0);

const Color BLACK21 = Color(0xFF212121);
const Color BLACK55 = Color(0xFF555555);
const Color BLACK77 = Color(0xFF777777);
const Color SOFT_GREY = Color(0xFFaaaaaa);
const Color SOFT_BLUE = Color(0xff01aed6);
Color mainColor = const Color(0xFF4AB35E);

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;


const String ERROR_OCCURED = 'Error occured, please try again later';

const int LIMIT_PAGE = 8;

const String GLOBAL_URL = 'https://ijtechnology.net/assets/images/api/devkit';
//const String GLOBAL_URL = 'http://192.168.0.4/devkit/assets/images/';

const String SERVER_URL = 'http://api2.khangthanh.com/';
//const String SERVER_URL = 'http://192.168.0.4/devkit/api';

const String LOGIN_API = "${SERVER_URL}erp/Users/weblogin";
const String PRODUCT_API = "$SERVER_URL/example/getProduct";