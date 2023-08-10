// To parse this JSON data, do
//
//     final EventsDetailResponse = EventsDetailResponseFromJson(jsonString);

import 'dart:convert';

EventsDetailResponse EventsDetailResponseFromJson(String str) =>
    EventsDetailResponse.fromJson(json.decode(str));

String EventsDetailResponseToJson(EventsDetailResponse data) =>
    json.encode(data.toJson());

class EventsDetailResponse {
  EventsDetailResponse({
    this.status,
    this.msg,
    this.result,
    this.requestsessionid,
    this.sessionvalueinfo,
  });

  String? status;
  String? msg;
  Result? result;
  String? requestsessionid;
  Sessionvalueinfo? sessionvalueinfo;

  factory EventsDetailResponse.fromJson(Map<String, dynamic> json) =>
      EventsDetailResponse(
        status: json["status"],
        msg: json["msg"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        requestsessionid: json["requestsessionid"],
        sessionvalueinfo: json["sessionvalueinfo"] == null
            ? null
            : Sessionvalueinfo.fromJson(json["sessionvalueinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": result?.toJson(),
        "requestsessionid": requestsessionid,
        "sessionvalueinfo": sessionvalueinfo?.toJson(),
      };
}

class Result {
  Result({
    this.eventId,
    this.eventTitle,
    this.eventDetail,
    this.eventDate,
    this.eventTime,
    this.eventseconddatetime,
    this.eventType,
    this.showId,
    this.eventInfo,
    this.eventSmallImage,
    this.eventlargeimage,
    this.eventStageLocation,
    this.seatingPlan,
    this.isSeatBooking,
    this.eventBookingType,
    this.hideBookNowBtn,
    this.btnText,
    this.venuename,
    this.venueAddress,
    this.venuepostCode,
    this.venueState,
    this.venueCountry,
    this.promoterDetail,
    this.promoterName,
    this.promoterEmail,
    this.ticketInformation,
    this.formAction,
    this.eventTicketId,
    this.singleEventMaxTicket,
    this.currencySymbol,
    this.currencyCode,
    this.ticketInformationNonSeating,
    this.eventTicketIdNonSeating,
    this.eventUrl,
    this.svgadvancelayout,
    this.multibookingbtnshow,
    this.isPhoneBooking,
    this.phoneBookingText,
    this.showCheckout,
    this.ticketQtyArray,
  });

  int? eventId;
  String? eventTitle;
  String? eventDetail;
  String? eventDate;
  String? eventTime;
  String? eventseconddatetime;
  String? eventType;
  String? showId;
  String? eventInfo;
  String? eventSmallImage;
  String? eventlargeimage;
  String? eventStageLocation;
  String? seatingPlan;
  String? isSeatBooking;
  String? eventBookingType;
  String? hideBookNowBtn;
  String? btnText;
  String? venuename;
  String? venueAddress;
  String? venuepostCode;
  String? venueState;
  String? venueCountry;
  String? promoterDetail;
  String? promoterName;
  String? promoterEmail;
  dynamic ticketInformation;
  String? formAction;
  dynamic eventTicketId;
  dynamic singleEventMaxTicket;
  String? currencySymbol;
  String? currencyCode;
  List<dynamic>? ticketInformationNonSeating;
  dynamic eventTicketIdNonSeating;
  String? eventUrl;
  String? svgadvancelayout;
  String? multibookingbtnshow;
  String? isPhoneBooking;
  dynamic phoneBookingText;
  int? showCheckout;
  List<String>? ticketQtyArray = [];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        eventId: json["EventId"] ?? 0,
        eventTitle: json["eventTitle"] ?? "",
        eventDetail: json["eventDetail"] ?? "",
        eventDate: json["eventDate"] ?? "",
        eventTime: json["eventTime"] ?? "",
        eventseconddatetime: json["eventseconddatetime"] ?? "",
        eventType: json["event_type"] ?? "",
        showId: json["show_id"] ?? "",
        eventInfo: json["eventInfo"] ?? "",
        eventSmallImage: json["eventSmallImage"] ?? "",
        eventlargeimage: json["eventlargeimage"] ?? "",
        eventStageLocation: json["eventStageLocation"] ?? "",
        seatingPlan: json["seatingPlan"] ?? "",
        isSeatBooking: json["isSeatBooking"] ?? "",
        eventBookingType: json["eventBookingType"] ?? "",
        hideBookNowBtn: json["hideBookNowBtn"] ?? "",
        btnText: json["BtnText"] ?? "",
        venuename: json["venuename"] ?? "",
        venueAddress: json["venueAddress"] ?? "",
        venuepostCode: json["venuepostCode"] ?? "",
        venueState: json["venueState"] ?? "",
        venueCountry: json["venueCountry"] ?? "",
        promoterDetail: json["promoterDetail"] ?? "",
        promoterName: json["promoter_name"] ?? "",
        promoterEmail: json["promoter_email"] ?? "",
        ticketInformation: json["ticketInformation"] == null
            ? []
            : List<TicketInformation>.from(json["ticketInformation"]!
                .map((x) => TicketInformation.fromJson(x))),
        formAction: json["formAction"] ?? "",
        eventTicketId: json["EventTicketId"] ?? false,
        singleEventMaxTicket: json["SingleEventMaxTicket"] ?? "",
        currencySymbol: json["CurrencySymbol"] ?? "",
        currencyCode: json["CurrencyCode"] ?? "",
        ticketInformationNonSeating: json["ticketInformationNonSeating"] == null
            ? []
            : List<TicketInformationNonSeating>.from(
                json["ticketInformationNonSeating"]!
                    .map((x) => TicketInformationNonSeating.fromJson(x))),
        eventTicketIdNonSeating: json["EventTicketIdNonSeating"] ?? "",
        eventUrl: json["eventURL"] ?? "",
        svgadvancelayout: json["svgadvancelayout"] ?? "",
        multibookingbtnshow: json["multibookingbtnshow"] ?? "",
        isPhoneBooking: json["isPhoneBooking"] ?? "",
        phoneBookingText: json["phoneBookingText"] ?? "",
        showCheckout: json["showCheckout"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "EventId": eventId,
        "eventTitle": eventTitle,
        "eventDetail": eventDetail,
        "eventDate": eventDate,
        "eventTime": eventTime,
        "eventseconddatetime": eventseconddatetime,
        "event_type": eventType,
        "show_id": showId,
        "eventInfo": eventInfo,
        "eventSmallImage": eventSmallImage,
        "eventlargeimage": eventlargeimage,
        "eventStageLocation": eventStageLocation,
        "seatingPlan": seatingPlan,
        "isSeatBooking": isSeatBooking,
        "eventBookingType": eventBookingType,
        "hideBookNowBtn": hideBookNowBtn,
        "BtnText": btnText,
        "venuename": venuename,
        "venueAddress": venueAddress,
        "venuepostCode": venuepostCode,
        "venueState": venueState,
        "venueCountry": venueCountry,
        "promoterDetail": promoterDetail,
        "promoter_name": promoterName,
        "promoter_email": promoterEmail,
        "ticketInformation": ticketInformation == null
            ? []
            : List<dynamic>.from(ticketInformation!.map((x) => x.toJson())),
        "formAction": formAction,
        "EventTicketId": eventTicketId,
        "SingleEventMaxTicket": singleEventMaxTicket,
        "CurrencySymbol": currencySymbol,
        "CurrencyCode": currencyCode,
        "ticketInformationNonSeating": ticketInformationNonSeating == null
            ? []
            : List<dynamic>.from(
                ticketInformationNonSeating!.map((x) => x.toJson())),
        "EventTicketIdNonSeating": eventTicketIdNonSeating,
        "eventURL": eventUrl,
        "svgadvancelayout": svgadvancelayout,
        "multibookingbtnshow": multibookingbtnshow,
        "isPhoneBooking": isPhoneBooking,
        "phoneBookingText": phoneBookingText,
        "showCheckout": showCheckout,
      };
}

class TicketInformation {
  TicketInformation({
    this.ticketId,
    this.ticketName,
    this.ticketDescription,
    this.ticketPrice,
    this.ticketStatus,
    this.ticketStatusName,
    this.ticketBtnClass,
    this.maxTicketBooking,
    this.ticketBookingType,
    this.ticketlistprice,
    this.etBlockid,
    this.eventGroupid,
    this.blockstatus,
    this.isTicketOption,
    this.ticketOptions,
    this.ticketSeatAvailable,
    this.blockdetail,
    this.blockdesc,
    this.blockgroupdata,
  });

  String? ticketId;
  String? ticketName;
  String? ticketDescription;
  String? ticketPrice;
  String? ticketStatus;
  TicketStatusName? ticketStatusName;
  TicketBtnClass? ticketBtnClass;
  String? maxTicketBooking;
  String? ticketBookingType;
  String? ticketlistprice;
  String? etBlockid;
  String? eventGroupid;
  String? blockstatus;
  String? isTicketOption;
  dynamic ticketOptions;
  String? ticketSeatAvailable;
  String? blockdetail;
  String? blockdesc;
  dynamic blockgroupdata;

  factory TicketInformation.fromJson(Map<String, dynamic> json) =>
      TicketInformation(
        ticketId: json["ticketId"],
        ticketName: json["ticketName"],
        ticketDescription: json["ticketDescription"],
        ticketPrice: json["ticketPrice"],
        ticketStatus: json["ticketStatus"],
        ticketStatusName: ticketStatusNameValues.map[json["ticketStatusName"]]!,
        ticketBtnClass: ticketBtnClassValues.map[json["ticketBtnClass"]]!,
        maxTicketBooking: json["maxTicketBooking"],
        ticketBookingType: json["TicketBookingType"],
        ticketlistprice: json["ticketlistprice"],
        etBlockid: json["et_blockid"],
        eventGroupid: json["event_groupid"],
        blockstatus: json["blockstatus"],
        isTicketOption: json["isTicketOption"],
        ticketOptions: json["ticketOptions"],
        ticketSeatAvailable: json["ticketSeatAvailable"],
        blockdetail: json["blockdetail"],
        blockdesc: json["blockdesc"],
        blockgroupdata: json["blockgroupdata"] == null
            ? []
            : List<Blockgroupdatum>.from(json["blockgroupdata"]!
                .map((x) => Blockgroupdatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "ticketName": ticketName,
        "ticketDescription": ticketDescription,
        "ticketPrice": ticketPrice,
        "ticketStatus": ticketStatus,
        "ticketStatusName": ticketStatusNameValues.reverse[ticketStatusName],
        "ticketBtnClass": ticketBtnClassValues.reverse[ticketBtnClass],
        "maxTicketBooking": maxTicketBooking,
        "TicketBookingType": ticketBookingType,
        "ticketlistprice": ticketlistprice,
        "et_blockid": etBlockid,
        "event_groupid": eventGroupid,
        "blockstatus": blockstatus,
        "isTicketOption": isTicketOption,
        "ticketOptions": ticketOptions,
        "ticketSeatAvailable": ticketSeatAvailable,
        "blockdetail": blockdetail,
        "blockdesc": blockdesc,
        "blockgroupdata": blockgroupdata == null
            ? []
            : List<dynamic>.from(blockgroupdata!.map((x) => x.toJson())),
      };
}

class Blockgroupdatum {
  Blockgroupdatum({
    this.ticketId,
    this.ticketName,
    this.ticketDescription,
    this.ticketPrice,
    this.ticketStatus,
    this.ticketStatusName,
    this.ticketBtnClass,
    this.maxTicketBooking,
    this.ticketBookingType,
    this.ticketlistprice,
    this.etBlockid,
    this.isTicketOption,
    this.ticketOptions,
    this.ticketGroupSeatAvailable,
  });

  String? ticketId;
  String? ticketName;
  String? ticketDescription;
  String? ticketPrice;
  String? ticketStatus;
  TicketStatusName? ticketStatusName;
  TicketBtnClass? ticketBtnClass;
  String? maxTicketBooking;
  String? ticketBookingType;
  String? ticketlistprice;
  String? etBlockid;
  String? isTicketOption;
  dynamic ticketOptions;
  String? ticketGroupSeatAvailable;

  factory Blockgroupdatum.fromJson(Map<String, dynamic> json) =>
      Blockgroupdatum(
        ticketId: json["ticketId"],
        ticketName: json["ticketName"],
        ticketDescription: json["ticketDescription"],
        ticketPrice: json["ticketPrice"],
        ticketStatus: json["ticketStatus"],
        ticketStatusName: ticketStatusNameValues.map[json["ticketStatusName"]]!,
        ticketBtnClass: ticketBtnClassValues.map[json["ticketBtnClass"]]!,
        maxTicketBooking: json["maxTicketBooking"],
        ticketBookingType: json["TicketBookingType"],
        ticketlistprice: json["ticketlistprice"],
        etBlockid: json["et_blockid"],
        isTicketOption: json["isTicketOption"],
        ticketOptions: json["ticketOptions"],
        ticketGroupSeatAvailable: json["ticketGroupSeatAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "ticketName": ticketName,
        "ticketDescription": ticketDescription,
        "ticketPrice": ticketPrice,
        "ticketStatus": ticketStatus,
        "ticketStatusName": ticketStatusNameValues.reverse[ticketStatusName],
        "ticketBtnClass": ticketBtnClassValues.reverse[ticketBtnClass],
        "maxTicketBooking": maxTicketBooking,
        "TicketBookingType": ticketBookingType,
        "ticketlistprice": ticketlistprice,
        "et_blockid": etBlockid,
        "isTicketOption": isTicketOption,
        "ticketOptions": ticketOptions,
        "ticketGroupSeatAvailable": ticketGroupSeatAvailable,
      };
}

enum TicketBtnClass { EMPTY, BTN_SOLTOUT }

final ticketBtnClassValues = EnumValues(
    {"btn_soltout": TicketBtnClass.BTN_SOLTOUT, "": TicketBtnClass.EMPTY});

enum TicketStatusName { BOOK_NOW, SOLD_OUT }

final ticketStatusNameValues = EnumValues({
  "Book Now": TicketStatusName.BOOK_NOW,
  "Sold Out": TicketStatusName.SOLD_OUT
});

class TicketInformationNonSeating {
  TicketInformationNonSeating({
    this.ticketQty,
    this.ticketId,
    this.ticketName,
    this.ticketDescription,
    this.ticketPrice,
    this.ticketStatus,
    this.ticketStatusName,
    this.ticketBtnClass,
    this.maxTicketBooking,
    this.ticketBookingType,
    this.ticketlistprice,
    this.etBlockid,
    this.eventGroupid,
    this.blockstatus,
    this.isTicketOption,
    this.ticketOptions,
    this.ticketNonSeatAvailable,
  });
  String? ticketQty;
  String? ticketId;
  String? ticketName;
  String? ticketDescription;
  String? ticketPrice;
  String? ticketStatus;
  String? ticketStatusName;
  String? ticketBtnClass;
  String? maxTicketBooking;
  String? ticketBookingType;
  String? ticketlistprice;
  String? etBlockid;
  dynamic eventGroupid;
  dynamic blockstatus;
  String? isTicketOption;
  dynamic ticketOptions;
  String? ticketNonSeatAvailable;

  factory TicketInformationNonSeating.fromJson(Map<String, dynamic> json) =>
      TicketInformationNonSeating(
        ticketId: json["ticketId"],
        ticketName: json["ticketName"],
        ticketDescription: json["ticketDescription"],
        ticketPrice: json["ticketPrice"],
        ticketStatus: json["ticketStatus"],
        ticketStatusName: json["ticketStatusName"],
        ticketBtnClass: json["ticketBtnClass"],
        maxTicketBooking: json["maxTicketBooking"],
        ticketBookingType: json["TicketBookingType"],
        ticketlistprice: json["ticketlistprice"],
        etBlockid: json["et_blockid"],
        eventGroupid: json["event_groupid"],
        blockstatus: json["blockstatus"],
        isTicketOption: json["isTicketOption"],
        ticketOptions: json["ticketOptions"],
        ticketNonSeatAvailable: json["ticketNonSeatAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "ticketName": ticketName,
        "ticketDescription": ticketDescription,
        "ticketPrice": ticketPrice,
        "ticketStatus": ticketStatus,
        "ticketStatusName": ticketStatusName,
        "ticketBtnClass": ticketBtnClass,
        "maxTicketBooking": maxTicketBooking,
        "TicketBookingType": ticketBookingType,
        "ticketlistprice": ticketlistprice,
        "et_blockid": etBlockid,
        "event_groupid": eventGroupid,
        "blockstatus": blockstatus,
        "isTicketOption": isTicketOption,
        "ticketOptions": ticketOptions,
        "ticketNonSeatAvailable": ticketNonSeatAvailable,
      };
}

class Sessionvalueinfo {
  Sessionvalueinfo({
    this.showId,
    this.site,
  });

  String? showId;
  Site? site;

  factory Sessionvalueinfo.fromJson(Map<String, dynamic> json) =>
      Sessionvalueinfo(
        showId: json["show_id"],
        site: json["site"] == null ? null : Site.fromJson(json["site"]),
      );

  Map<String, dynamic> toJson() => {
        "show_id": showId,
        "site": site?.toJson(),
      };
}

class Site {
  Site({
    this.city,
    this.cityName,
  });

  String? city;
  String? cityName;

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        city: json["city"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "city_name": cityName,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
