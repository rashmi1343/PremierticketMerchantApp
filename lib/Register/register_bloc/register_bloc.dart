import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Response/CountryResponse.dart';
import '../../Response/CountryResponse.dart';
import '../../Response/CountryResponse.dart';
import '../../Response/CountryResponse.dart';
import '../../Response/CountryResponse.dart';
import '../../Response/RegisterResponse.dart';
import '../../repository/PtkmerchantRepository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  PtkmerchantRepository ptkrepository;

  late List<CountryResult> countryResponse;

  RegisterBloc({
    required this.ptkrepository,
  }) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterButtonPressed) {
        RegisterResponse registerResponse= await ptkrepository.registerapi(
            event.firstname,
            event.lastname,
            event.email,
            event.mobile,
            event.address,
            event.city,
            event.postalCode,
            event.country,
            event.state);
        emit(RegisterSuccessState(registerResponse: registerResponse));
      } else if (event is CountryEvent) {
        countryResponse = await ptkrepository.countrylistapi();
        emit(CountryState(countryResult: countryResponse));
      }
    });
  }
}
