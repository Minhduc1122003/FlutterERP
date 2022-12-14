// ignore_for_file: prefer_typing_uninitialized_variables

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;
  final String site;
  final apiToken;
  Login({required this.email, required this.password, required this.site, required this.apiToken});
}
