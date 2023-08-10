class RegisterResponse {
  String? status;
  String? msg;
  RegisterResult? result;
  String? requestsessionid;
  Sessionvalueinfo? sessionvalueinfo;

  RegisterResponse(
      {this.status,
        this.msg,
        this.result,
        this.requestsessionid,
        this.sessionvalueinfo});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    result =
    json['result'] != null ? RegisterResult.fromJson(json['result']) : null;
    requestsessionid = json['requestsessionid'];
    sessionvalueinfo = json['sessionvalueinfo'] != null
        ? Sessionvalueinfo.fromJson(json['sessionvalueinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['requestsessionid'] = requestsessionid;
    final sessionvalueinfo = this.sessionvalueinfo;
    if (sessionvalueinfo != null) {
      data['sessionvalueinfo'] = sessionvalueinfo.toJson();
    }
    return data;
  }
}

class RegisterResult {
  String? result;
 // Customerid? customerid;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? displayName;
  String? bookingTotalPrice;
  String? registerStatus;
  String? enableAttendee;
  String? guestCheckout;

  RegisterResult(
      {this.result,
     //   this.customerid,
        this.userName,
        this.userMobile,
        this.userEmail,
        this.displayName,
        this.bookingTotalPrice,
        this.registerStatus,
        this.enableAttendee,
        this.guestCheckout});

  RegisterResult.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    // customerid = json['customerid'] != null
    //     ? new Customerid.fromJson(json['customerid'])
    //     : null;
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userEmail = json['user_email'];
    displayName = json['display_name'];
    bookingTotalPrice = json['bookingTotalPrice'];
    registerStatus = json['register_status'];
    enableAttendee = json['enable_attendee'];
    guestCheckout = json['guest_checkout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['result'] = result;
    // if (customerid != null) {
    //   data['customerid'] = customerid!.toJson();
    // }
    data['user_name'] = userName;
    data['user_mobile'] = userMobile;
    data['user_email'] = userEmail;
    data['display_name'] = displayName;
    data['bookingTotalPrice'] = bookingTotalPrice;
    data['register_status'] = registerStatus;
    data['enable_attendee'] = enableAttendee;
    data['guest_checkout'] = guestCheckout;
    return data;
  }
}
//
// class Customerid {
//   Errors? errors;
//   List<Null>? errorData;
//
//   Customerid({this.errors, this.errorData});
//
//   Customerid.fromJson(Map<String, dynamic> json) {
//     errors =
//     json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
//     if (json['error_data'] != null) {
//       errorData = <Null>[];
//       json['error_data'].forEach((v) {
//         errorData!.add(new Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (errors != null) {
//       data['errors'] = errors.toJson();
//     }
//     if (errorData != null) {
//       data['error_data'] = errorData.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Errors {
  List<String>? invalidUserId;

  Errors({this.invalidUserId});

  Errors.fromJson(Map<String, dynamic> json) {
    invalidUserId = json['invalid_user_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['invalid_user_id'] = invalidUserId;
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
    json['member'] != null ? Member.fromJson(json['member']) : null;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['isGuestCheckout'] = isGuestCheckout;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['Mobile'] = mobile;
    data['Email'] = email;
    data['user_street_num'] = userStreetNum;
    data['user_street_name'] = userStreetName;
    data['user_city'] = userCity;
    data['user_post_code'] = userPostCode;
    data['user_countryId'] = userCountryId;
    data['user_stateId'] = userStateId;
    data['device_type'] = deviceType;
    data['methodname'] = methodname;
    data['customersesid'] = customersesid;
    data['regemail'] = regemail;
    return data;
  }
}

class Member {
  String? userRegisterStatus;
  String? iD;
  String? userLogin;
  String? userNicename;
  String? displayName;
  String? userStatus;
  String? userEmail;
  String? userFirstname;
  String? userLastname;
  String? userMobile;
  String? userStreetName;
  String? userCity;
  String? userCountryId;
  String? userStateId;
  String? userPostCode;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_register_status'] = userRegisterStatus;
    data['ID'] = iD;
    data['user_login'] = userLogin;
    data['user_nicename'] = userNicename;
    data['display_name'] = displayName;
    data['user_status'] = userStatus;
    data['user_email'] = userEmail;
    data['user_firstname'] = userFirstname;
    data['user_lastname'] = userLastname;
    data['user_mobile'] = userMobile;
    data['user_street_name'] = userStreetName;
    data['user_city'] = userCity;
    data['user_countryId'] = userCountryId;
    data['user_stateId'] = userStateId;
    data['user_post_code'] = userPostCode;
    data['user_roletype'] = userRoletype;
    data['send_ticket_status'] = sendTicketStatus;
    return data;
  }
}