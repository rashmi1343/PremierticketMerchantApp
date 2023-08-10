

import 'package:equatable/equatable.dart';
import 'package:ptk_merchant/login/models/Loginresponse.dart';

abstract class AuthenticationState extends Equatable {

  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final LoginResponse userloginresponse;
  AuthenticationAuthenticated({required this.userloginresponse});

  @override
  List<Object> get props => [userloginresponse];


}

class AuthenticationUnauthenticated extends  AuthenticationState {
  final String message;
    AuthenticationUnauthenticated({required this.message});

  @override
  List<Object> get props => [message];

}

class AuthenticationLoading extends AuthenticationState {}