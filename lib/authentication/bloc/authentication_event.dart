


import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../login/models/Loginresponse.dart';

abstract class AuthenticationEvent  extends Equatable{
  const AuthenticationEvent([List props = const []]):super();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => ['AppStarted'];
}
class LoggedIn extends AuthenticationEvent {
  final String token;
  LoggedIn({required this.token}): super([token]);


  @override
  List<Object> get props => [token];
}



class LoggedOut extends AuthenticationEvent {

  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object?> get props => ['LoggedOut'];
}



