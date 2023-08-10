class CountryResponse {
  String? status;
  String? msg;
  List<CountryResult>? result;
  String? requestsessionid;
  Sessionvalueinfo? sessionvalueinfo;

  CountryResponse(
      {this.status,
        this.msg,
        this.result,
        this.requestsessionid,
        this.sessionvalueinfo});

  CountryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['result'] != null) {
      result = <CountryResult>[];
      json['result'].forEach((v) {
        result!.add(new CountryResult.fromJson(v));
      });
    }
    requestsessionid = json['requestsessionid'];
    sessionvalueinfo = json['sessionvalueinfo'] != null
        ? Sessionvalueinfo.fromJson(json['sessionvalueinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['requestsessionid'] = this.requestsessionid;
    if (this.sessionvalueinfo != null) {
      data['sessionvalueinfo'] = this.sessionvalueinfo!.toJson();
    }
    return data;
  }
}

class CountryResult {
  String? countryid;
  String? countryname;
  String? countryimage;

  CountryResult({this.countryid, this.countryname, this.countryimage});

  CountryResult.fromJson(Map<String, dynamic> json) {
    countryid = json['countryid'];
    countryname = json['countryname'];
    countryimage = json['countryimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryid'] = this.countryid;
    data['countryname'] = this.countryname;
    data['countryimage'] = this.countryimage;
    return data;
  }
}
class Sessionvalueinfo {
  Site? site;
  String? showId;

  Sessionvalueinfo({this.site, this.showId});

  Sessionvalueinfo.fromJson(Map<String, dynamic> json) {
    site = json['site'] != null ? Site.fromJson(json['site']) : null;
    showId = json['show_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.site != null) {
      data['site'] = this.site!.toJson();
    }
    data['show_id'] = this.showId;
    return data;
  }
}

class Site {
  String? city;
  String? cityName;

  Site({this.city, this.cityName});

  Site.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city'] = this.city;
    data['city_name'] = this.cityName;
    return data;
  }
}