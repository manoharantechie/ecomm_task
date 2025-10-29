import 'package:e_comm/src/features/data/login_model.dart';
import 'package:equatable/equatable.dart';


abstract class LoginState extends Equatable {}

class LoginInit extends LoginState {
  @override
  List<Object> get props => [];
}


class LoginLoading extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginSucceed extends LoginState {
  LoginSucceed({required this.response});

  final LoginModel response;

  @override
  List<Object> get props => [response];
}


class LoginFailed extends LoginState {

  LoginFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

