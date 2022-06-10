


import 'package:flutter/material.dart';

class LoginMaster {
  int success;
  String message;
  LoginDetails result;

  LoginMaster({this.success, this.message, this.result});

  LoginMaster.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new LoginDetails.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class LoginDetails {
  String userId;
  String name;
  String firstName;
  String lastName;
  String email;
  String phone;
  String sessionId;
  String registerDate;
  String profileImage;
  String thumbImage;
  String badgeCount;

  LoginDetails(
      {this.userId,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.sessionId,
        this.registerDate,
        this.profileImage,
        this.thumbImage,
        this.badgeCount});

  LoginDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    sessionId = json['sessionId'];
    registerDate = json['registerDate'];
    profileImage = json['profileImage'];
    thumbImage = json['thumbImage'];
    badgeCount = json['badgeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['sessionId'] = this.sessionId;
    data['registerDate'] = this.registerDate;
    data['profileImage'] = this.profileImage;
    data['thumbImage'] = this.thumbImage;
    data['badgeCount'] = this.badgeCount;
    return data;
  }
}
