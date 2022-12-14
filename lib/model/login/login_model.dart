import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginModel {
  final String name;
  final String userName;
  final String site;
  LoginModel({
    required this.name,
    required this.userName,
    required this.site,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        name: json['name'], userName: json['userName'], site: json['site']);
  }
}
