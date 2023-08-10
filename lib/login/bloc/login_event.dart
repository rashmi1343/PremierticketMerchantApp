part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
   LoginEvent();
}


class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

   LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginButtonPressed { username: $email, password: $password }';

}

