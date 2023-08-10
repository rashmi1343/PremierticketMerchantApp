part of 'login_bloc.dart';




abstract class loginstate extends Equatable {
  const loginstate();

}

class initialloginstate extends loginstate {

  @override
  List<Object?> get props => [];
}


class loginSuccessState extends loginstate {
    final LoginResponse loginresponse;
    loginSuccessState({required this.loginresponse});

    @override
  List<Object> get props => [loginresponse];
}


class LoginFailureState extends loginstate {
  final String error;

  const LoginFailureState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}