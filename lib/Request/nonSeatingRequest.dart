// To parse this JSON data, do
//
//     final nonSeatingRequest = nonSeatingRequestFromJson(jsonString);

import 'dart:convert';

String nonSeatingRequestToJson(NonSeatingRequest data) =>
    json.encode(data.toJson());

class NonSeatingRequest {
  NonSeatingRequest({
    this.method,
    this.customersesid,
    this.eventId,
    this.ticketId,
    this.attendeeDetail,
    this.ticketQuantity,
    this.authkey,
  });

  String? method;
  String? customersesid;
  String? eventId;
  String? ticketId;
  String? attendeeDetail;
  List<String>? ticketQuantity;
  String? authkey;

  Map<String, dynamic> toJson() => {
        "methodname": method,
        "customersesid": customersesid,
        "EventId": eventId,
        "TicketId": ticketId,
        "attendeeDetail": attendeeDetail,
        "TicketQuantity": ticketQuantity == null
            ? []
            : List<dynamic>.from(ticketQuantity!.map((x) => x)),
        "Authkey": authkey,
      };
}
