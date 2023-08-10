import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ptk_merchant/Response/seatlayoutmodel.dart';
import '../Events/models/eventsDetailResponse.dart';
import '../Request/CustomerOrderInfoRequest.dart';
import '../Request/cartinformationRequest.dart';
import '../Request/nonSeatingRequest.dart';
import '../Response/CartinformationResponse.dart';
import '../Response/CountryResponse.dart';
import '../Response/RegisterResponse.dart';
import '../Response/StatesResponse.dart';
import '../login/models/Loginresponse.dart';
import '../Events/models/events_model.dart';
import '../util/appConstant.dart';

class PtkmerchantRepository {
  @override
  Future<LoginResponse> loginApi(String username, String password) async {
    try {
      Map loginparam = {
        "methodname": "login",
        "userlogin": username,
        "userpassword": password
      };

      print('loginparam:' + loginparam.toString());

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(ApiConstant.url + "SCANAPI/authentication"));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(loginparam)));
      HttpClientResponse response = await request.close();

      String reply = await response.transform(utf8.decoder).join();

      print(reply);
      var loginForMapjsonReply = json.decode(reply);
      print("loginForMapjsonReply:$loginForMapjsonReply");
      httpClient.close();

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(loginForMapjsonReply);
        // loginResponse.msg == 'OK'
        //     ? Fluttertoast.showToast(
        //         msg: "Login Successfully",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.BOTTOM,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Color(0xff254fd5),
        //         textColor: Colors.white,
        //         fontSize: 16.0)
        //     : Fluttertoast.showToast(
        //         msg: loginResponse.msg.toString(),
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.BOTTOM,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Color(0xff254fd5),
        //         textColor: Colors.white,
        //         fontSize: 16.0);
        return loginResponse;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  Future<List<Eventlist>> fetchEventsData() async {
    final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
    final base64String = base64.encode(strBytes);
    print(base64String);

    Map eventsdata = {"methodname": "geteventslist", "Authkey": base64String};

    print("EventsData:$eventsdata");
    // var body = utf8.encode(json.encode(eventsdata));
    HttpClient httpClient = new HttpClient();

    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse(ApiConstant.url + "BOOKINGAPI/events"));

    request.headers.set('content-type', 'application/json');

    // request.headers.set('Authorizationkey', accesstoken!);
    //  request.headers.set('accesskey', accesskey!);

    request.add(utf8.encode(json.encode(eventsdata)));

    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();

    var jsonReply = json.decode(reply);

    print(jsonReply);

    httpClient.close();

    // final eventresponse = Eventlist.fromJson(json.decode(reply));
    //
    // return eventresponse.result;
    if (response.statusCode == 200) {
      print('response:$response.body');

      //
      // var data = json.decode(response.body);
      // List<Eventlist> eventlist = Result.fromJson(data).eventlist;
      // return eventlist;
      Map decoded = jsonReply;
      List<Eventlist> eventlist = [];
      for (var objeventlist in decoded["result"]["eventlist"]) {
        eventlist.add(Eventlist(
          eventId: objeventlist['eventId'],
          eventTitle: objeventlist['eventTitle'],
          eventDscription: objeventlist['eventDscription'],
          eventDate: objeventlist['eventDate'],
          eventDay: objeventlist['eventDay'],
          eventDayName: objeventlist['eventDayName'],
          eventTime: objeventlist['eventTime'],
          eventMonth: objeventlist['eventMonth'],
          venueAddress: objeventlist['venueAddress'],
          eventImage: objeventlist['eventImage'],
          eventLink: objeventlist['eventLink'],
          eventImageSmall: objeventlist['eventImageSmall'],
          eventViewCounter: objeventlist['eventViewCounter'],
        ));
      }

      return eventlist;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<EventsDetailResponse> eventdetailapi(String eventid) async {
    final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
    final base64String = base64.encode(strBytes);
    print(base64String);

    Map eventsdetail = {
      "methodname": "geteventdetail",
      "eventid": eventid,
      "Authkey": base64String
    };
    print("EventsDetail:$eventsdetail");
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("${ApiConstant.url}BOOKINGAPI/eventdetail"));
    request.headers.set('content-type', 'application/json');
    // request.headers
    //     .set('Authorizationkey', "20A0751C-9FEE-47F8-A6A9-335BE39834");
    request.add(utf8.encode(json.encode(eventsdetail)));
    HttpClientResponse response = await request.close();
    String jsonDetailReply = await response.transform(utf8.decoder).join();

    print("jsonDetailReply:$jsonDetailReply");
    httpClient.close();

    var eventdetailForMapjsonReply = json.decode(jsonDetailReply);
    print("eventdetailForMapjsonReply:$eventdetailForMapjsonReply");

    final geteventdetailresponse =
        EventsDetailResponse.fromJson(eventdetailForMapjsonReply);
    print("geteventdetailresponse:$EventsDetailResponse");

    return geteventdetailresponse;
  }

  Future<List<CountryResult>> countrylistapi() async {
    try {
      final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
      final base64String = base64.encode(strBytes);
      print(base64String);
      Map countryParam = {
        "methodname": "storecountry",
        "Authkey": base64String
      };
      var body = utf8.encode(json.encode(countryParam));
      print("countryParam data:$countryParam");
      var response =
          await http.post(Uri.parse("${ApiConstant.url}BOOKINGAPI/events"),
              headers: {
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
                "Content-Type": "application/json",
              },
              body: body);

      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        List<dynamic> data = res['result'];
        List<CountryResult> countrylist = [];

        countrylist = data.map((item) => CountryResult.fromJson(item)).toList();

        return countrylist;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  Future<RegisterResponse> registerapi(
      String fname,
      String lname,
      String email,
      String mobile,
      String address,
      String city,
      String pincode,
      String country,
      String state) async {
    try {
      final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
      final base64String = base64.encode(strBytes);
      print(base64String);
      Map registerParam = {
        "FirstName": fname,
        "LastName": lname,
        "Mobile": email,
        "Email": mobile,
        "user_street_num": "12",
        "user_street_name": "Mayur Vihar",
        "user_city": city,
        "user_post_code": pincode,
        "user_countryId": country,
        "user_stateId": state,
        "device_type": "1",
        "methodname": "registration",
        "customersesid": "v96gekg06l7qhhf0a6befcsp76",
        "Authkey": base64String
      };
      print("registerParam:$registerParam");
      var body = utf8.encode(json.encode(registerParam));

      var response = await http
          .post(Uri.parse("${ApiConstant.url}BOOKINGAPI/customer"),
              headers: {
                "Content-Type": "application/json",
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
              },
              body: body)
          .timeout(const Duration(seconds: 500));
      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        final registerResponse = RegisterResponse.fromJson(res);
        return registerResponse;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  Future<List<TicketDetail>> getseatlayoutdata(
      String methodname, String eventid, String ticketid) async {
    try {
      final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
      final base64String = base64.encode(strBytes);
      print(base64String);
      List<TicketDetail> _list = [];
      List<CatSeat> _seatlist = [];
      List<SeatDetail> _seatinfo = [];
      Map seatlayoutparam = {
        'methodname': 'getseatlayout',
        'eventid': eventid,
        'Authkey': base64String,
        'ticketcatid': ticketid
      };
      print("seatlayoutparam:$seatlayoutparam");
      var body = utf8.encode(json.encode(seatlayoutparam));

      var response = await http
          .post(Uri.parse("${ApiConstant.url}BOOKINGAPI/eventdetail"),
              headers: {
                "Content-Type": "application/json",
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
              },
              body: body)
          .timeout(const Duration(seconds: 500));
      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        String responseapi = response.body.toString().replaceAll("\n", "");
        Map<String, dynamic> res = jsonDecode(responseapi);

        res["result"]["ticketDetail"].forEach((e) {
          _seatlist = [];
          e["catSeats"].forEach((ticketdata) {
            _seatinfo = [];
            ticketdata["SeatDetail"].forEach((tktinfo) {
              /*    print("seatid : " +tktinfo["seatid"].toString());
            var rowname = ticketdata["rowName"].toString();
            print("rowname "+ ticketdata["rowName"].toString());
*/
              _seatinfo.add(SeatDetail(
                  seatid: tktinfo["seatid"],
                  rowName: ticketdata["rowName"].toString(),
                  seatno: tktinfo["seatno"],
                  seattype: tktinfo["seattype"],
                  originaltype: tktinfo["originaltype"],
                  seatPrice: tktinfo["seat_price"],
                  discountPrice: tktinfo["discount_price"],
                  seatBlockName: tktinfo["seatBlockName"],
                  status: tktinfo["status"],
                  blockedTime: tktinfo["blockedTime"]));
            });
            _seatlist.add(CatSeat(
                rowName: ticketdata["rowName"].toString(),
                seatDetail: _seatinfo));
            _list.add(TicketDetail(
                ticketCatId: e["ticketCatId"],
                selcatid: e["selcatid"],
                ticketCatName: e["ticketCatName"],
                ticketCatPrice: e["ticketCatPrice"],
                maxBookingPerCustomer: e["maxBookingPerCustomer"],
                catSeats: _seatlist));
          });
        });

        //      print("seatlist len"+_list.length.toString());
        return _list;
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e);

      throw Exception('Failed to load $e');
    }
  }

  Future<bool> nonSeatingAddToCartApi(
      NonSeatingRequest nonSeatingRequest) async {
    try {
      // Map data = {
      //   'method': 'nonseatingaddcart',
      //   "customersesid": "go8b1hfsl32v9s9h1217vsoqu7",
      //   "EventId": "11418",
      //   "TicketId": "3819,3820",
      //   "attendeeDetail": "MjBBMDc1MUMtOUZFRS00N0Y4LUE2QTktMzM1QkUzOTgzNA==",
      //   "TicketQuantity": ["3819###4", "3820###2"],
      //   "Authkey": ApiConstant.getAuthKeyBaseString()
      // };

      //encode Map to JSON
      // var body = utf8.encode(json.encode(data));

      var body = utf8.encode(json.encode(nonSeatingRequest));

      print(
          "nonSeatingRequest in api:${nonSeatingRequestToJson(nonSeatingRequest)}");

      var response = await http
          .post(Uri.parse("${ApiConstant.url}BOOKINGAPI/eventdetail"),
              headers: {
                "Content-Type": "application/json",
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
              },
              body: body)
          .timeout(const Duration(seconds: 500));
      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        Map decoded = json.decode(response.body);
        return true;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  Future<bool> customerOrderInfoApi(
      CustomerOrderInfoRequest customerOrderInfoRequest) async {
    try {
      var body = utf8.encode(json.encode(customerOrderInfoRequest));

      print(
          "CustomerOrderInfoRequest in api:${customerOrderInfoRequestToJson(customerOrderInfoRequest)}");

      var response = await http
          .post(Uri.parse("${ApiConstant.url}BOOKINGAPI/customer"),
              headers: {
                "Content-Type": "application/json",
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
              },
              body: body)
          .timeout(const Duration(seconds: 500));
      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        Map decoded = json.decode(response.body);
        return true;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }

  Future<CartinformationResponse> customerCartinformationApi(
      CartinformationRequest cartinformationRequest) async {
    try {
      var body = utf8.encode(json.encode(cartinformationRequest));

      print(
          "cartinformationRequestToJson in api:${cartinformationRequestToJson(cartinformationRequest)}");

      var response = await http
          .post(Uri.parse("${ApiConstant.url}BOOKINGAPI/checking"),
              headers: {
                "Content-Type": "application/json",
                "Authorizationkey": "20A0751C-9FEE-47F8-A6A9-335BE39834",
              },
              body: body)
          .timeout(const Duration(seconds: 500));
      print("${response.statusCode}");
      print(response.body);
      if (response.statusCode == 200) {
        final cartinformationResponse =
            cartinformationResponseFromJson(response.body);
        return cartinformationResponse;
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
  }
}
