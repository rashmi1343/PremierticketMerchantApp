import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/PtkmerchantRepository.dart';
import '../models/Loginresponse.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, loginstate> {
  PtkmerchantRepository ptkrepository;

  //final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.ptkrepository}) : super(initialloginstate()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        try {
          LoginResponse loginresponsedata =
              await ptkrepository.loginApi(event.email, event.password);
            if(loginresponsedata.resultstatus=="1") {
              emit(loginSuccessState(loginresponse: loginresponsedata));
            }
            else {
              emit(LoginFailureState(error: loginresponsedata.msg.toString()));
            }
        } catch (error) {
          emit(LoginFailureState(error: error.toString()));
        }
      }
    });
  }

  @override
  initialloginstate get initialState => initialloginstate();
}
