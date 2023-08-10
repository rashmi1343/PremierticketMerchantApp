// To parse this JSON data, do
//
//     final cartinformationRequest = cartinformationRequestFromJson(jsonString);

import 'dart:convert';

String cartinformationRequestToJson(CartinformationRequest data) =>
    json.encode(data.toJson());

class CartinformationRequest {
  CartinformationRequest({
    this.methodname,
    this.customersesid,
    this.eventId,
    this.ticketId,
    this.eventType,
    this.userRoleType,
    this.isMobilerequest,
    this.memberId,
    this.authkey,
  });

  String? methodname;
  String? customersesid;
  String? eventId;
  String? ticketId;
  String? eventType;
  String? userRoleType;
  String? isMobilerequest;
  String? memberId;
  String? authkey;

  Map<String, dynamic> toJson() => {
        "methodname": methodname,
        "customersesid": customersesid,
        "EventId": eventId,
        "TicketId": ticketId,
        "EventType": eventType,
        "UserRoleType": userRoleType,
        "isMobilerequest": isMobilerequest,
        "MemberId": memberId,
        "Authkey": authkey
      };
}
