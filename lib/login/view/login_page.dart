import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ptk_merchant/Events/view/EventsPageNew.dart';
import 'package:ptk_merchant/repository/PtkmerchantRepository.dart';

import '../../Events/event_bloc/events_bloc.dart';
import '../../authentication/bloc/AuthenticationBloc.dart';
import '../bloc/login_bloc.dart';
import '../../main.dart';
import 'login_form.dart';

class LoginPage extends StatefulWidget {
  final PtkmerchantRepository Repository;

  LoginPage({required this.Repository})
      : assert(Repository != null),
        super();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  // late AuthenticationBloc _authenticationBloc;

  PtkmerchantRepository get _Repository => widget.Repository;

  @override
  void initState() {
    // _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      ptkrepository: _Repository,
    );
    super.initState();
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          child: BlocListener<LoginBloc, loginstate>(
              listener: (context, state) {
                if (state is loginstate) {
                  CircularProgressIndicator(); // for splash screen
                }
                else if(state is loginSuccessState) {
                  print("navigate");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  MyHomePage(title: 'test')));
                }
              },
              child: BlocBuilder<LoginBloc, loginstate>(
              builder: (context, state) {
                if (state is initialloginstate) {
                  print("1"); // for loading login screen
                  return LoginForm(loginBloc: _loginBloc);
                }
                else if (state is loginSuccessState) {
                  print("2");
                  return Container(); // for loading next screen Event Screen
                }

                else if (state is loginfailureState) {
                  return _buildErrorUi(state.failuremessage);
                }
                print("4");
                return CircularProgressIndicator();
              }
          ),
        )
    ));
  }
*/
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return BlocBuilder<LoginBloc, loginstate>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        loginstate state,
      ) {
        if (state is loginSuccessState) {
          //  _loginBloc.dispatch(LoggedIn());

          print("navigate to Events page");
          _onWidgetDidBuild(() {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return BlocProvider(
            //     create: (context) => EventsBloc(
            //       ptkrepository: PtkmerchantRepository(),
            //       // accesstoken: state
            //       //     .loginresponse.result!.authDetail!.accessToken
            //       //     .toString(),
            //     ),
            //     child: EventsPageNew(
            //       eventRepo: PtkmerchantRepository(),
            //       accesstoken: state
            //           .loginresponse.result!.authDetail!.accessToken
            //           .toString(),
            //       accesskey: state.loginresponse.result!.authDetail!.accessKey
            //           .toString(),
            //     ),
            //   );
            // }));
            // _onWidgetDidBuild(() {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => EventsPageNew(
                eventRepo: PtkmerchantRepository(),
                accesstoken: state.loginresponse.result!.authDetail!.accessToken
                    .toString(),
                accesskey: state.loginresponse.result!.authDetail!.accessKey
                    .toString(),
              ),
            ));
            // });
          });
        }
        if (state is LoginFailureState) {
          //  _onWidgetDidBuild(() {
          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'GraphikRegular',
                        fontSize: 14)),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Scaffold(
            // appBar: AppBar(
            //   title: Text('Login'),
            // ),
            backgroundColor: Colors.white,
            body: LoginForm(loginBloc: _loginBloc));
      },
    );
  }
}

@override
void dispose() {
  // _loginBloc.dispose();
  // super.dispose();
}

Widget _buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

void _onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}
