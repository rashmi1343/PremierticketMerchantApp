// To parse this JSON data, do
//
//     final seatlayoutmodel = seatlayoutmodelFromJson(jsonString);

import 'dart:convert';

Seatlayoutmodel seatlayoutmodelFromJson(String str) => Seatlayoutmodel.fromJson(json.decode(str));

String seatlayoutmodelToJson(Seatlayoutmodel data) => json.encode(data.toJson());

class Seatlayoutmodel {
  Seatlayoutmodel({
    required this.status,
    required this.msg,
    required this.result,
    required this.requestsessionid,
    required this.sessionvalueinfo,
  });

  dynamic status;
  dynamic msg;
  Result result;
  dynamic requestsessionid;
  List<dynamic> sessionvalueinfo=[];

  factory Seatlayoutmodel.fromJson(Map<String, dynamic> json) => Seatlayoutmodel(
    status: json["status"],
    msg: json["msg"],
    result: Result.fromJson(json["result"]),
    requestsessionid: json["requestsessionid"],
    sessionvalueinfo: List<String>.from(json["sessionvalueinfo"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "result": result.toJson(),
    "requestsessionid": requestsessionid,
    "sessionvalueinfo": List<String>.from(sessionvalueinfo.map((x) => x)),
  };
}

class Result {
  Result({
    required this.customersesid,
    required this.showDetail,
    required this.ticketDetail,
    required this.customerCart,
    required this.reservedshowseat,
  });

  dynamic customersesid;
  ShowDetail showDetail;
  List<TicketDetail> ticketDetail;
  dynamic customerCart;
  dynamic reservedshowseat;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    customersesid: json["customersesid"],
    showDetail: ShowDetail.fromJson(json["showDetail"]),
    ticketDetail: List<TicketDetail>.from(json["ticketDetail"].map((x) => TicketDetail.fromJson(x))),
    customerCart: json["customerCart"],
    reservedshowseat: json["reservedshowseat"],
  );

  Map<String, dynamic> toJson() => {
    "customersesid": customersesid,
    "showDetail": showDetail.toJson(),
    "ticketDetail": List<dynamic>.from(ticketDetail.map((x) => x.toJson())),
    "customerCart": customerCart,
    "reservedshowseat": reservedshowseat,
  };
}

class ShowDetail {
  ShowDetail({
    required this.showId,
    required this.dhowDevWidth,
  });

  dynamic showId;
  dynamic dhowDevWidth;

  factory ShowDetail.fromJson(Map<String, dynamic> json) => ShowDetail(
    showId: json["showId"],
    dhowDevWidth: json["dhowDevWidth"],
  );

  Map<String, dynamic> toJson() => {
    "showId": showId,
    "dhowDevWidth": dhowDevWidth,
  };
}

class TicketDetail {
  TicketDetail({
    required this.ticketCatId,
    required this.selcatid,
    required this.ticketCatName,
    required this.ticketCatPrice,
    required this.maxBookingPerCustomer,
    required this.catSeats,
  });

  dynamic ticketCatId;
  dynamic selcatid;
  dynamic ticketCatName;
  dynamic ticketCatPrice;
  dynamic maxBookingPerCustomer;
  List<CatSeat> catSeats;

  factory TicketDetail.fromJson(Map<String, dynamic> json) => TicketDetail(
    ticketCatId: json["ticketCatId"],
    selcatid: json["selcatid"],
    ticketCatName: json["ticketCatName"],
    ticketCatPrice: json["ticketCatPrice"],
    maxBookingPerCustomer: json["MaxBookingPerCustomer"],
    catSeats: List<CatSeat>.from(json["catSeats"].map((x) => CatSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ticketCatId": ticketCatId,
    "selcatid": selcatid,
    "ticketCatName": ticketCatName,
    "ticketCatPrice": ticketCatPrice,
    "MaxBookingPerCustomer": maxBookingPerCustomer,
    "catSeats": List<dynamic>.from(catSeats.map((x) => x.toJson())),
  };
}

class CatSeat {
  CatSeat({
    required this.rowName,
    required this.seatDetail,
  });

  String? rowName;
  List<SeatDetail> seatDetail;

  factory CatSeat.fromJson(Map<String, dynamic> json) => CatSeat(
    rowName: json["rowName"]!,
    seatDetail: List<SeatDetail>.from(json["SeatDetail"].map((x) => SeatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rowName": rowName,
    "SeatDetail": List<dynamic>.from(seatDetail.map((x) => x.toJson())),
  };
}



class SeatDetail {
  SeatDetail({
    required this.seatid,
    required this.rowName,
    required this.seatno,
    required this.seattype,
    required this.originaltype,
    required this.seatPrice,
    required this.discountPrice,
    required this.seatBlockName,
    required this.status,
    required this.blockedTime,
  });

  dynamic seatid;
  String rowName;
  dynamic seatno;
  dynamic seattype;
  dynamic originaltype;
  dynamic seatPrice;
  dynamic discountPrice;
  dynamic seatBlockName;
  dynamic status;
  DateTime? blockedTime;

  factory SeatDetail.fromJson(Map<String, dynamic> json) => SeatDetail(
    seatid: json["seatid"],
    rowName: json["row_name"],
    seatno: json["seatno"],
    seattype: json["seattype"],
    originaltype: json["originaltype"],
    seatPrice: json["seat_price"],
    discountPrice: json["discount_price"],
    seatBlockName: json["seatBlockName"],
    status: json["status"],
    blockedTime: json["blocked_time"],
  );

  Map<String, dynamic> toJson() => {
    "seatid": seatid,
    "row_name": rowName,
    "seatno": seatno,
    "seattype": seattype,
    "originaltype": originaltype,
    "seat_price": seatPrice,
    "discount_price": discountPrice,
    "seatBlockName": seatBlockName,
    "status": status,
    "blocked_time": blockedTime?.toIso8601String(),
  };
}


