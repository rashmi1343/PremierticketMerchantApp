part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final RegisterResponse registerResponse;

  RegisterSuccessState({required this.registerResponse});

  @override
  List<Object> get props => [registerResponse];
}

class CountryState extends RegisterState {
  List<CountryResult> countryResult;

  CountryState({required this.countryResult});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
