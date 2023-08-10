import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:ptk_merchant/login/bloc/login_bloc.dart';
import 'package:ptk_merchant/login/view/validation_provider.dart';

import '../../Register/RegisterPage.dart';
import '../../Register/RegisterFormScreen.dart';
import '../../Register/register_bloc/register_bloc.dart';
import '../../repository/PtkmerchantRepository.dart';
import '../Response/CartinformationResponse.dart';
import '../Response/CartinformationResponse.dart' as paymentmethod;

enum PaymentType {
  creditcard,
  cash,
  none,
}

class PaymentForm extends StatefulWidget {
  final CartinformationResponse cartinformationResponse;
  const PaymentForm({
    super.key,
    required this.cartinformationResponse,
  });

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  paymentmethod.PaymentMethod? _selectedPaymentMethod;
  final TextEditingController _userNameController = TextEditingController();

  List<paymentmethod.PaymentMethod>? paymentDataArr;
  bool isTermsConditionChecked = false;

  CardFieldInputDetails? _card;
  TokenData? tokenData;

  var paymentType = PaymentType.none;

  @override
  void initState() {
    super.initState();

    paymentDataArr =
        (widget.cartinformationResponse.result?.paymentMethod ?? []);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleCreateTokenPress() async {
    if (_card == null) {
      return;
    }

    try {
      // 1. Gather customer billing information (ex. email)
      final address = const Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ); // mocked data for tests

      // 2. Create payment method
      final tokenData =
          await Stripe.instance.createToken(CreateTokenParams.card(
              params: CardTokenParams(
        type: TokenType.Card,
        name: _userNameController.text,
        address: address,
        currency: 'USD',
      )));
      setState(() {
        this.tokenData = tokenData;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Success: The token was created successfully!')));
      return;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xfff9fdfe),
        elevation: 0,
        title: Image.asset(
          'assets/images/logoptk.png',
          width: 110,
          height: 75,
        ),
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Image.asset(
                "assets/images/back.png",
                color: const Color(0xff000000),
                height: 21,
                width: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xffDDDDDD),
                blurRadius: 6.0,
                spreadRadius: 2.0,
                offset: Offset(0.0, 0.0),
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5.0),
                alignment: Alignment.topCenter,
                child: const Text(
                  "PAYMENT OPTION",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'MuliSemiBold',
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymentDataArr?.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Radio<paymentmethod.PaymentMethod>(
                          // contentPadding: EdgeInsets.zero,
                          value: paymentDataArr![index],
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              print(value!.methodName.toString());
                              _selectedPaymentMethod = value;

                              checkPaymentType(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPaymentMethod = paymentDataArr![index];
                              checkPaymentType(_selectedPaymentMethod!);
                            });
                          },
                          child: Transform.translate(
                            offset: const Offset(-15, 0),
                            child: Text(
                              paymentDataArr?[index].methodName ?? "",
                              style: const TextStyle(
                                height: 1,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MuliRegular',
                                color: Color.fromARGB(255, 91, 92, 93),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                margin: const EdgeInsets.all(5.0),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: paymentType == PaymentType.cash ? false : true,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 45,
                            margin: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: TextFormField(
                              controller: _userNameController,
                              textAlignVertical: TextAlignVertical.bottom,
                              keyboardType: TextInputType.name,
                              enableSuggestions: false,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 157, 157, 157),
                                          width: 0.5)),
                                  hintStyle: TextStyle(
                                      fontSize: 15, fontFamily: "MuliRegular"),
                                  hintText: 'Card Holder Name',
                                  // errorText: 'please enter valid discount code',
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 10, right: 10),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 157, 157, 157),
                                  width: 1),
                            ),
                            child: CardField(
                              style: const TextStyle(
                                height: 1.2,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'MuliRegular',
                                color: Color.fromARGB(255, 91, 92, 93),
                              ),
                              onCardChanged: (card) {
                                _card = card;
                                print(card?.validNumber);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 2,
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Transform.translate(
                          offset: const Offset(-15, 0),
                          child: const Text(
                            'By clicking Pay Now, you agree to our Terms & Conditions',
                            style: TextStyle(
                              height: 1.2,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'MuliRegular',
                              color: Color.fromARGB(255, 91, 92, 93),
                            ),
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: isTermsConditionChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isTermsConditionChecked = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff00a400))),
                        onPressed: () async {
                          if (_card?.complete ?? false) {
                            _handleCreateTokenPress();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill cards details'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'MuliRegular',
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.lock),
                        title: Transform.translate(
                          offset: const Offset(-20, 0),
                          child: const Text(
                            'Our app do not store any credit card details and card details are sent directly to the payment processor securely via SSL. We are fully PCI DSS Compliant.',
                            style: TextStyle(
                              height: 1.2,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'MuliRegular',
                              color: Color.fromARGB(255, 91, 92, 93),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkPaymentType(paymentmethod.PaymentMethod value) {
    if (value.methodName == "CASH" || value.methodName == "cash") {
      paymentType = PaymentType.cash;
    } else {
      paymentType = PaymentType.creditcard;
    }
  }
}
