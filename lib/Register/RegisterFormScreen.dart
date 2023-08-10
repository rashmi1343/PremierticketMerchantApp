import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ptk_merchant/Register/register_bloc/register_bloc.dart';
import 'package:ptk_merchant/login/view/login_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Events/models/eventsDetailResponse.dart';
import '../Response/CountryResponse.dart';
import '../Response/RegisterResponse.dart';
import '../Response/StatesResponse.dart';
import '../login/models/Loginresponse.dart';
import '../Events/models/events_model.dart';
import '../util/appConstant.dart';
import '../Response/CountryResponse.dart';
import '../Response/StatesResponse.dart';
import '../login/view/validation_provider.dart';
import '../repository/PtkmerchantRepository.dart';

class RegisterFormScreen extends StatefulWidget {
  late final RegisterBloc registerBloc;
  List<CountryResult> countrylist;

  RegisterFormScreen({required this.registerBloc, required this.countrylist})
      : super();

  RegisterFormScreenState createState() => RegisterFormScreenState();
}

class RegisterFormScreenState extends State<RegisterFormScreen> {
  List<StateArray> citylist = [];

  Future<List<StateArray>> stateslistapi(String countryid) async {
    try {
      final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
      final base64String = base64.encode(strBytes);
      print(base64String);

      Map statesParam = {
        "methodname": "statelist",
        "countryid": countryid,
        "Authkey": base64String
      };
      var body = utf8.encode(json.encode(statesParam));
      print("statesParam data:$statesParam");
      var response = await http.post(
          Uri.parse("${ApiConstant.url}BOOKINGAPI/customerregistration"),
          headers: {
            "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
            "Content-Type": "application/json",
          },
          body: body);

      print("${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        List<dynamic> data = res['result']['stateArray'];

        citylist = data.map((item) => StateArray.fromJson(item)).toList();

        return citylist;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String? countryname;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  var dropdownvalue;
  bool formIsValid = false;
  final _registerformKey = GlobalKey<FormState>();
  String? countryselectedValue = null;
  String? cityselectedValue = null;

  @override
  void initState() {
    super.initState();

    countryname = 'Country';
  }

  bool submit() {
    if (_firstnameController.text.isNotEmpty) {
      if (_lastnameController.text.isNotEmpty) {
        if (_emailController.text.isNotEmpty) {
          if (_mobileController.text.isNotEmpty) {
            if (_addressController.text.isNotEmpty) {
              if (_cityController.text.isNotEmpty) {
                if (_pincodeController.text.isNotEmpty) {
                  return true;
                }
                return true;
              }
              return true;
            }
            return true;
          }
          return true;
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  final List<String> countries = [
    'Country',
    'Australia',
    'Canada',
    'Dubai',
    'India',
    'Nea Zealand',
    'Singapore',
    'USA',
  ];
  final List<String> states = [
    'State1',
    'State2',
    'State3',
    'State4',
    'State5',
    'State6',
    'State7',
    'State8',
  ];

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

    final validationProvider = Provider.of<ValidationProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff9fdfe),
      // appBar: AppBar(
      //   centerTitle: false,
      //   toolbarHeight: 75,
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Colors.black,
      //     statusBarIconBrightness: Brightness.light,
      //     statusBarBrightness: Brightness.light,
      //   ),
      //   backgroundColor: const Color(0xfff9fdfe),
      //   elevation: 0,
      //   title: const Text(
      //     "Register",
      //     style: TextStyle(
      //       fontFamily: 'GraphikBold',
      //       fontSize: 17,
      //       color: Color(0xff243444),
      //     ),
      //   ),
      //   leading: Builder(
      //     builder: (context) => Container(
      //       margin: const EdgeInsets.only(left: 10),
      //       child: IconButton(
      //         alignment: Alignment.centerLeft,
      //         icon: Image.asset(
      //           "assets/images/back.png",
      //           color: const Color(0xff000000),
      //           height: 21,
      //           width: 24,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      body: Consumer<ValidationProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 50),
          child: Form(
              key: _registerformKey,
              onChanged: () => setState(() =>
                  formIsValid = _registerformKey.currentState!.validate()),
              child: Center(
                child: Container(
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontFamily: 'GraphikSemiBold',
                                  fontSize: 20,
                                  color: Color(0xff243444),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                "Please enter your information",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'GraphikRegular',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _firstnameController,
                                keyboardType: TextInputType.name,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter
                                //       .digitsOnly,
                                //   LengthLimitingTextInputFormatter(20),
                                // ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) =>
                                    validationProvider.validateFirstName(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'First Name',
                                    errorText: validationProvider.fname.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _lastnameController,
                                keyboardType: TextInputType.name,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter
                                //       .digitsOnly,
                                //   LengthLimitingTextInputFormatter(20),
                                // ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) =>
                                    validationProvider.validateLastName(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'Last Name',
                                    errorText: validationProvider.lname.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter
                                //       .digitsOnly,
                                //   LengthLimitingTextInputFormatter(50),
                                // ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) =>
                                    validationProvider.validateEmail(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'Email',
                                    errorText: validationProvider.email.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _mobileController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) => validationProvider
                                    .validateMobileNumber(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'Mobile No',
                                    errorText: validationProvider.mobile.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _addressController,
                                keyboardType: TextInputType.streetAddress,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter
                                //       .digitsOnly,
                                //   LengthLimitingTextInputFormatter(50),
                                // ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) =>
                                    validationProvider.validateAddress(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'Address',
                                    errorText: validationProvider.address.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                textAlign: TextAlign.start,
                                controller: _cityController,
                                keyboardType: TextInputType.streetAddress,
                                // inputFormatters: <TextInputFormatter>[
                                //   FilteringTextInputFormatter
                                //       .digitsOnly,
                                //   LengthLimitingTextInputFormatter(40),
                                // ],
                                // validator: myProvider.validateAddress,
                                onChanged: (value) =>
                                    validationProvider.validateCity(value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'City/Subrub',
                                    errorText: validationProvider.city.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              //height: 40,
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.start,
                                controller: _pincodeController,

                                // validator: myProvider.validatePincode,
                                onChanged: (value) =>
                                    validationProvider.validatePincode(value),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                // Only numbers can be entered
                                // maxLength: 6,

                                // maxLengthEnforced: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Email Id',
                                    contentPadding: edgeInsets,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'GraphikRegular'),
                                    hintText: 'Post Code/Zip Code',
                                    errorText: validationProvider.pincode.error,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff254fd5),
                                            width: 1.5)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red))),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Country',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'GraphikRegular',
                                          color: Colors.black54,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: widget.countrylist
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.countryid,
                                          child: Text(
                                            item.countryname.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'GraphikRegular',
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    countryselectedValue = value;
                                    stateslistapi(countryselectedValue!);
                                  });
                                },
                                value: countryselectedValue,
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 328,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  padding: EdgeInsets.all(10),
                                  direction: DropdownDirection.textDirection,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  offset: const Offset(120, -0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'State/Province',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'GraphikRegular',
                                          color: Colors.black54,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: citylist
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item.stateId,
                                  child: Text(
                                    item.stateName.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'GraphikRegular',
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: cityselectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    cityselectedValue = value as String;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 328,
                                  padding: const EdgeInsets.only(left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.black,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  padding: EdgeInsets.all(10),
                                  direction: DropdownDirection.textDirection,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  offset: const Offset(120, -50),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all<double>(6),
                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 45,
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 30),
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
                                onPressed: submit() ? RegisterButton : null,
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'GraphikMedium',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }

  RegisterButton() {
    final bool? isValid = _registerformKey.currentState?.validate();

    print("isvalid$isValid");
    if (isValid == true) {
      widget.registerBloc.add(RegisterButtonPressed(
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          email: _emailController.text,
          mobile: _mobileController.text,
          address: _addressController.text,
          city: _cityController.text,
          postalCode: _pincodeController.text,
          country: countryselectedValue.toString(),
          state: stateValue));
      Fluttertoast.showToast(
          msg: "Register Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff254fd5),
          textColor: Colors.white,
          fontSize: 16.0);
      _firstnameController.clear();
      _lastnameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _addressController.clear();
      _cityController.clear();
      _pincodeController.clear();
    }
  }


}
