
import 'dart:convert';

LoginResponse logindataFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginresponseTojson(LoginResponse loginresponsedata) => json.encode(loginresponsedata.toJson());




class LoginResponse {
  String? status;
  String? msg;
  String? resultstatus;
  Result? result;

  LoginResponse({this.status, this.msg, this.resultstatus, this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    resultstatus = json['resultstatus'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['resultstatus'] = this.resultstatus;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  UserInfo? userInfo;
  AuthDetail? authDetail;

  Result({this.userInfo, this.authDetail});

  Result.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    authDetail = json['auth_detail'] != null
        ? new AuthDetail.fromJson(json['auth_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    if (this.authDetail != null) {
      data['auth_detail'] = this.authDetail!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? iD;
  String? userLogin;
  String? userNicename;
  String? userEmail;
  String? userUrl;
  String? userRegistered;
  String? userActivationKey;
  String? userStatus;
  String? displayName;

  UserInfo(
      {this.iD,
        this.userLogin,
        this.userNicename,
        this.userEmail,
        this.userUrl,
        this.userRegistered,
        this.userActivationKey,
        this.userStatus,
        this.displayName});

  UserInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userLogin = json['user_login'];
    userNicename = json['user_nicename'];
    userEmail = json['user_email'];
    userUrl = json['user_url'];
    userRegistered = json['user_registered'];
    userActivationKey = json['user_activation_key'];
    userStatus = json['user_status'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_login'] = this.userLogin;
    data['user_nicename'] = this.userNicename;
    data['user_email'] = this.userEmail;
    data['user_url'] = this.userUrl;
    data['user_registered'] = this.userRegistered;
    data['user_activation_key'] = this.userActivationKey;
    data['user_status'] = this.userStatus;
    data['display_name'] = this.displayName;
    return data;
  }
}

class AuthDetail {
  String? accessToken;
  String? accessKey;

  AuthDetail({this.accessToken, this.accessKey});

  AuthDetail.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    accessKey = json['access_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['access_key'] = this.accessKey;
    return data;
  }
}