class StatesResponse {
  String? status;
  String? msg;
  Result? result;
  String? requestsessionid;
  Sessionvalueinfo? sessionvalueinfo;

  StatesResponse(
      {this.status,
        this.msg,
        this.result,
        this.requestsessionid,
        this.sessionvalueinfo});

  StatesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    requestsessionid = json['requestsessionid'];
    sessionvalueinfo = json['sessionvalueinfo'] != null
        ? new Sessionvalueinfo.fromJson(json['sessionvalueinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['requestsessionid'] = this.requestsessionid;
    if (this.sessionvalueinfo != null) {
      data['sessionvalueinfo'] = this.sessionvalueinfo!.toJson();
    }
    return data;
  }
}

class Result {
  List<StateArray>? stateArray;

  Result({this.stateArray});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['stateArray'] != null) {
      stateArray = <StateArray>[];
      json['stateArray'].forEach((v) {
        stateArray!.add(new StateArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stateArray != null) {
      data['stateArray'] = this.stateArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateArray {
  String? stateId;
  String? stateName;

  StateArray({this.stateId, this.stateName});

  StateArray.fromJson(Map<String, dynamic> json) {
    stateId = json['StateId'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    return data;
  }
}

class Sessionvalueinfo {
  Member? member;
  String? isGuestCheckout;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? userStreetNum;
  String? userStreetName;
  String? userCity;
  String? userPostCode;
  String? userCountryId;
  String? userStateId;
  String? deviceType;
  String? methodname;
  String? customersesid;
  String? regemail;

  Sessionvalueinfo(
      {this.member,
        this.isGuestCheckout,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.userStreetNum,
        this.userStreetName,
        this.userCity,
        this.userPostCode,
        this.userCountryId,
        this.userStateId,
        this.deviceType,
        this.methodname,
        this.customersesid,
        this.regemail});

  Sessionvalueinfo.fromJson(Map<String, dynamic> json) {
    member =
    json['member'] != null ? new Member.fromJson(json['member']) : null;
    isGuestCheckout = json['isGuestCheckout'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobile = json['Mobile'];
    email = json['Email'];
    userStreetNum = json['user_street_num'];
    userStreetName = json['user_street_name'];
    userCity = json['user_city'];
    userPostCode = json['user_post_code'];
    userCountryId = json['user_countryId'];
    userStateId = json['user_stateId'];
    deviceType = json['device_type'];
    methodname = json['methodname'];
    customersesid = json['customersesid'];
    regemail = json['regemail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.member != null) {
      data['member'] = this.member!.toJson();
    }
    data['isGuestCheckout'] = this.isGuestCheckout;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['user_street_num'] = this.userStreetNum;
    data['user_street_name'] = this.userStreetName;
    data['user_city'] = this.userCity;
    data['user_post_code'] = this.userPostCode;
    data['user_countryId'] = this.userCountryId;
    data['user_stateId'] = this.userStateId;
    data['device_type'] = this.deviceType;
    data['methodname'] = this.methodname;
    data['customersesid'] = this.customersesid;
    data['regemail'] = this.regemail;
    return data;
  }
}

class Member {
  String? userRegisterStatus;
  Null? iD;
  String? userLogin;
  String? userNicename;
  String? displayName;
  String? userStatus;
  String? userEmail;
  String? userFirstname;
  String? userLastname;
  String? userMobile;
  bool? userStreetName;
  bool? userCity;
  bool? userCountryId;
  bool? userStateId;
  bool? userPostCode;
  String? userRoletype;
  String? sendTicketStatus;

  Member(
      {this.userRegisterStatus,
        this.iD,
        this.userLogin,
        this.userNicename,
        this.displayName,
        this.userStatus,
        this.userEmail,
        this.userFirstname,
        this.userLastname,
        this.userMobile,
        this.userStreetName,
        this.userCity,
        this.userCountryId,
        this.userStateId,
        this.userPostCode,
        this.userRoletype,
        this.sendTicketStatus});

  Member.fromJson(Map<String, dynamic> json) {
    userRegisterStatus = json['user_register_status'];
    iD = json['ID'];
    userLogin = json['user_login'];
    userNicename = json['user_nicename'];
    displayName = json['display_name'];
    userStatus = json['user_status'];
    userEmail = json['user_email'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userMobile = json['user_mobile'];
    userStreetName = json['user_street_name'];
    userCity = json['user_city'];
    userCountryId = json['user_countryId'];
    userStateId = json['user_stateId'];
    userPostCode = json['user_post_code'];
    userRoletype = json['user_roletype'];
    sendTicketStatus = json['send_ticket_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_register_status'] = this.userRegisterStatus;
    data['ID'] = this.iD;
    data['user_login'] = this.userLogin;
    data['user_nicename'] = this.userNicename;
    data['display_name'] = this.displayName;
    data['user_status'] = this.userStatus;
    data['user_email'] = this.userEmail;
    data['user_firstname'] = this.userFirstname;
    data['user_lastname'] = this.userLastname;
    data['user_mobile'] = this.userMobile;
    data['user_street_name'] = this.userStreetName;
    data['user_city'] = this.userCity;
    data['user_countryId'] = this.userCountryId;
    data['user_stateId'] = this.userStateId;
    data['user_post_code'] = this.userPostCode;
    data['user_roletype'] = this.userRoletype;
    data['send_ticket_status'] = this.sendTicketStatus;
    return data;
  }
}