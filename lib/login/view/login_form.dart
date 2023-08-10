import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:ptk_merchant/login/bloc/login_bloc.dart';
import 'package:ptk_merchant/login/view/validation_provider.dart';

import '../../Register/RegisterPage.dart';
import '../../Register/RegisterFormScreen.dart';
import '../../Register/register_bloc/register_bloc.dart';
import '../../repository/PtkmerchantRepository.dart';

class LoginForm extends StatefulWidget {
  late final LoginBloc loginBloc;

  //final AuthenticationBloc authenticationBloc;

  LoginForm({required this.loginBloc
      //  required this.authenticationBloc,
      })
      : super();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();
  final _resetemailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  //bool submit = false;

  LoginBloc get _loginBloc => widget.loginBloc;
  bool passwordHidden = true;
  final _passwordformKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  bool submit() {
    if (_emailController.text.isNotEmpty) {
      if (_passwordController.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool formIsValid = false;
  @override
  Widget build(BuildContext context) {
    final validationProvider = Provider.of<ValidationProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'GraphikSemiBold',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/ptk_icon_new.png",
                  height: 100, width: double.infinity, fit: BoxFit.fitWidth),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "Enter you Premier Tickets Credentials",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'GraphikRegular',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  onChanged: () => setState(
                      () => formIsValid = _formKey.currentState!.validate()),
                  child: Column(
                    children: [
                      Container(
                        //  height: 50,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          //textcapitalization
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          // validator: validationProvider.validateUserName(value),
                          //onChanged: (value) => _userName = value,
                          onChanged: (String value) {
                            validationProvider.validateEmail(value);
                          },

                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Email Id',
                              hintStyle: TextStyle(
                                  fontSize: 14, fontFamily: "GraphikRegular"),
                              hintText: 'Enter Organiser/Promoter Email Id',
                              errorText: validationProvider.email.error,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff254fd5), width: 1.5)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red))

                              // errorText: texterror
                              //     ? "Username length must be 7 or greater"
                              //     : null,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        //   height: 50,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: _passwordController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: passwordHidden,
                          onChanged: (String value) {
                            validationProvider.validatePassword(value);
                          },
                          enableSuggestions: false,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordHidden = !passwordHidden;
                                  });
                                },
                                child: Icon(
                                  passwordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xff747881),
                                  size: 23,
                                ),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff254fd5), width: 1.5)),
                              hintStyle: const TextStyle(
                                  fontSize: 14, fontFamily: "GraphikRegular"),
                              hintText: 'Enter your Password',
                              errorText: validationProvider.password.error,
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 28, right: 28),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              elevation: 3,
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal),
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(10)),
                          // onPressed: (!validationProvider.isValid)?null:validationProvider.sumbitData ,
                          onPressed: submit() ? loginButton : null,

                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                        text: "Already have an Account? ",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "GraphikRegular"),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Register",
                              style: const TextStyle(
                                  color: Color(0xff254fd5),
                                  decoration: TextDecoration.underline,
                                  fontFamily: "GraphikRegular"),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BlocProvider(
                                      create: (context) => RegisterBloc(
                                          ptkrepository:
                                              PtkmerchantRepository()),
                                      child: RegisterPage(
                                          ptkmerchantRepository:
                                              PtkmerchantRepository()),
                                    );
                                  }));
                                }),
                        ],
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Reset Password ?",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff254fd5),
                              decoration: TextDecoration.underline,
                              fontFamily: "GraphikRegular"),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _showResetPasswordDialog,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  loginButton() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      print(_emailController.text);
      print(_passwordController.text);

      widget.loginBloc.add(LoginButtonPressed(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  Future<void> _showResetPasswordDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final validationProvider = Provider.of<ValidationProvider>(context);
        const edgeInsets = EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontFamily: 'GraphikSemiBold',
                        fontSize: 18,
                        color: Color(0xff243444),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Please enter your information",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'GraphikRegular',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                //height: 40,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: _resetemailController,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(50),
                  ],
                  // validator: myProvider.validateAddress,
                  onChanged: (value) => validationProvider.validateEmail(value),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Email Id',
                      contentPadding: edgeInsets,
                      hintStyle:
                          TextStyle(fontSize: 14, fontFamily: 'GraphikRegular'),
                      hintText: 'Email',
                      errorText: validationProvider.email.error,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff254fd5), width: 1.5)),
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 3,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontStyle: FontStyle.normal),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(5)),
                  onPressed: () async {
                    final bool? isValid =
                        _passwordformKey.currentState?.validate();

                    print("isvalid$isValid");
                    if (isValid == true) {}
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'GraphikMedium',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'GraphikRegular',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
