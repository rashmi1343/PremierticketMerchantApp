import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ptk_merchant/Register/RegisterFormScreen.dart';
import 'package:ptk_merchant/Register/register_bloc/register_bloc.dart';
import 'package:ptk_merchant/Response/RegisterResponse.dart';
import 'package:ptk_merchant/repository/PtkmerchantRepository.dart';

import '../Response/CountryResponse.dart';
import '../login/bloc/login_bloc.dart';
import '../login/view/login_page.dart';
// import '../util/pref.dart';

class RegisterPage extends StatefulWidget {
  final PtkmerchantRepository ptkmerchantRepository;

  const RegisterPage({
    super.key,
    required this.ptkmerchantRepository,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc registerBloc;
  RegisterResponse? objregisterresponse;

  PtkmerchantRepository get _Repository => widget.ptkmerchantRepository;

  BuildContext? buildContext;
  var countryid;
  List<CountryResult> countrylist = [];

  @override
  void initState() {
    registerBloc = RegisterBloc(
      ptkrepository: _Repository,
    );
    registerBloc.add(CountryEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: registerBloc,
          builder: (BuildContext context, RegisterState state) {
            if (state is RegisterInitial) {
              print("RegisterInitialState");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CountryState) {
              countrylist = state.countryResult;

              print("countrylist:$countrylist");
            }

            if (state is RegisterSuccessState) {
              objregisterresponse = state.registerResponse;

              print("objregisterresponse :${state.registerResponse}");

              _onWidgetDidBuild(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        LoginBloc(ptkrepository: PtkmerchantRepository()),
                    child: LoginPage(Repository: PtkmerchantRepository()),
                  );
                }));
              });
            }

            return RegisterFormScreen(
                registerBloc: registerBloc, countrylist: countrylist);
          }),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
