

import 'package:bloc/bloc.dart';
import 'package:ptk_merchant/authentication/bloc/authentication_event.dart';
import 'package:ptk_merchant/authentication/bloc/authentication_state.dart';
import 'package:ptk_merchant/repository/PtkmerchantRepository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final PtkmerchantRepository ptkmerchantRepository;

  AuthenticationBloc({required this.ptkmerchantRepository}):super(AuthenticationUninitialized()) {

    /* on<InitialLoginEvent>((event, emit) async {
      if(event is LoginButtonPressed) {
        LoginResponse loginresponsedata = await ptkrepository.loginApi(
            event.username, event.password);

        emit(AuthenticationAuthenticated(userloginresponse: loginresponsedata));
      }
    });*/


  }

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();




}

