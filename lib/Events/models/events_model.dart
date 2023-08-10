import 'dart:convert';

EventlistResponse eventlistResponseFromJson(String str) => EventlistResponse.fromJson(json.decode(str));

String eventlistResponseToJson(EventlistResponse data) => json.encode(data.toJson());

class EventlistResponse {
  EventlistResponse({
    required this.status,
    required this.msg,
    required this.result,
    required this.requestsessionid,
    required this.sessionvalueinfo,
  });

  String status;
  String msg;
  clsResult result;
  String requestsessionid;
  Sessionvalueinfo sessionvalueinfo;

  factory EventlistResponse.fromJson(Map<String, dynamic> json) => EventlistResponse(
    status: json["status"],
    msg: json["msg"],
    result: clsResult.fromJson(json["result"]),
    requestsessionid: json["requestsessionid"],
    sessionvalueinfo: Sessionvalueinfo.fromJson(json["sessionvalueinfo"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "result": result.toJson(),
    "requestsessionid": requestsessionid,
    "sessionvalueinfo": sessionvalueinfo.toJson(),
  };
}

class clsResult {
  List<Eventlist>? eventlist;
  List<EventCategory>? eventCategory;

  clsResult({required this.eventlist, required this.eventCategory});

  clsResult.fromJson(Map<String, dynamic> json) {
    if (json['eventlist'] != null) {
      eventlist = <Eventlist>[];
      json['eventlist'].forEach((v) {
        eventlist!.add(new Eventlist.fromJson(v));
      });
    }
    if (json['eventCategory'] != null) {
      eventCategory = <EventCategory>[];
      json['eventCategory'].forEach((v) {
        eventCategory!.add(new EventCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventlist != null) {
      data['eventlist'] = this.eventlist!.map((v) => v.toJson()).toList();
    }
    if (this.eventCategory != null) {
      data['eventCategory'] =
          this.eventCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventCategory {
  EventCategory({
    required this.eventCatId,
    required this.eventCatName,
  });

  String eventCatId;
  String eventCatName;

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
    eventCatId: json["eventCatId"],
    eventCatName: json["eventCatName"],
  );

  Map<String, dynamic> toJson() => {
    "eventCatId": eventCatId,
    "eventCatName": eventCatName,
  };
}

class Eventlist {
  Eventlist({
    required this.eventId,
    required this.eventTitle,
    required this.eventDscription,
    required this.eventDate,
    required this.eventDay,
    required this.eventDayName,
    required this.eventTime,
    required this.eventMonth,
    required this.venueAddress,
    required this.eventImage,
    required this.eventLink,
    required this.eventImageSmall,
    required this.eventViewCounter,
  });

  String? eventId;
  String? eventTitle;
  String? eventDscription;
  String? eventDate;
  String? eventDay;
  String? eventDayName;
  String? eventTime;
  String? eventMonth;
  String? venueAddress;
  String? eventImage;
  String? eventLink;
  String? eventImageSmall;
  String? eventViewCounter;

  Eventlist.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventTitle = json['eventTitle'];
    eventDscription = json['eventDscription']?? '';
    eventDate = json['eventDate'];
    eventDay = json['eventDay'];
    eventDayName = json['eventDayName'];
    eventTime = json['eventTime'];
    eventMonth = json['eventMonth'];
    venueAddress = json['venueAddress'];
    eventImage = json['eventImage'];
    eventLink = json['eventLink'];
    eventImageSmall = json['eventImageSmall'];
    eventViewCounter = json['eventViewCounter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventTitle'] = this.eventTitle;
    data['eventDscription'] = this.eventDscription;
    data['eventDate'] = this.eventDate;
    data['eventDay'] = this.eventDay;
    data['eventDayName'] = this.eventDayName;
    data['eventTime'] = this.eventTime;
    data['eventMonth'] = this.eventMonth;
    data['venueAddress'] = this.venueAddress;
    data['eventImage'] = this.eventImage;
    data['eventLink'] = this.eventLink;
    data['eventImageSmall'] = this.eventImageSmall;
    data['eventViewCounter'] = this.eventViewCounter;
    return data;
  }
}

class Sessionvalueinfo {
  Sessionvalueinfo({
    required this.site,
  });

  Site site;

  factory Sessionvalueinfo.fromJson(Map<String, dynamic> json) => Sessionvalueinfo(
    site: Site.fromJson(json["site"]),
  );

  Map<String, dynamic> toJson() => {
    "site": site.toJson(),
  };
}

class Site {
  Site({
    required this.city,
    required this.cityName,
  });

  String city;
  String cityName;

  factory Site.fromJson(Map<String, dynamic> json) => Site(
    city: json["city"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "city_name": cityName,
  };
}
