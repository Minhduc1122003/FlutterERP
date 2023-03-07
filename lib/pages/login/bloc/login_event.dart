part of 'login_bloc.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final String no_;
  final String password;
  final String site;
  final apiToken;
  Login(this.no_, this.password, this.site, this.apiToken);
}
