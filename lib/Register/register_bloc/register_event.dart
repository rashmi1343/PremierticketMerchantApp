part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class GetInitialRegisterEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingEvent extends RegisterEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String address;
  final String city;
  final String postalCode;
  final String country;
  final String state;

  RegisterButtonPressed({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.state,
  });

  @override
  List<Object> get props => [
        firstname,
        lastname,
        email,
        mobile,
        address,
        city,
        postalCode,
        country,
        state
      ];
}

class CountryEvent extends RegisterEvent {


  CountryResult() {

  }

  @override
  // TODO: implement props
  List<Object?> get props => [];


}
