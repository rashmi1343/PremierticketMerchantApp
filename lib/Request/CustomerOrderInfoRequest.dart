// To parse this JSON data, do
//
//     final customerOrderInfoRequest = customerOrderInfoRequestFromJson(jsonString);

import 'dart:convert';

String customerOrderInfoRequestToJson(CustomerOrderInfoRequest data) =>
    json.encode(data.toJson());

class CustomerOrderInfoRequest {
  CustomerOrderInfoRequest({
    this.methodname,
    this.customersesid,
    this.eventId,
    this.ticketId,
    this.eventType,
    this.postcode,
    this.isSeatBooking,
    this.seatId,
    this.showId,
    this.ticketPrice,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.address,
    this.suburb,
    this.country,
    this.state,
    this.customerId,
    this.bookingTotalPrice,
    this.customerFee,
    this.promoterFee,
    this.plandetail,
    this.authkey,
  });

  String? methodname;
  String? customersesid;
  String? eventId;
  String? ticketId;
  String? eventType;
  String? postcode;
  String? isSeatBooking;
  String? seatId;
  String? showId;
  String? ticketPrice;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? suburb;
  String? country;
  String? state;
  String? customerId;
  String? bookingTotalPrice;
  String? customerFee;
  String? promoterFee;
  List<Plandetail>? plandetail;
  String? authkey;

  Map<String, dynamic> toJson() => {
        "methodname": methodname,
        "customersesid": customersesid,
        "EventId": eventId,
        "TicketId": ticketId,
        "EventType": eventType,
        "postcode": postcode,
        "IsSeatBooking": isSeatBooking,
        "seat_id": seatId,
        "show_id": showId,
        "ticket_price": ticketPrice,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Mobile": mobile,
        "Address": address,
        "Suburb": suburb,
        "Country": country,
        "State": state,
        "customerId": customerId,
        "bookingTotalPrice": bookingTotalPrice,
        "customerFee": customerFee,
        "promoterFee": promoterFee,
        "plandetail": plandetail == null
            ? []
            : List<dynamic>.from(plandetail!.map((x) => x.toJson())),
        "Authkey": authkey
      };
}

class Plandetail {
  Plandetail({
    this.planArray,
    this.cutomerFeePerBooking,
    this.organizerFee,
  });

  String? planArray;
  String? cutomerFeePerBooking;
  String? organizerFee;

  Map<String, dynamic> toJson() => {
        "planArray": "",
        "cutomerFeePerBooking": "0",
        "organizerFee": "0",
      };
}
