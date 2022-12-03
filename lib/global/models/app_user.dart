import 'dart:core';

class AppUser {
  AppUser({
    this.role,
    this.address,
    this.phoneNo,
    this.profileImage,
    this.fullName,
    this.id,
    this.subject,
    this.fatherName,
    this.rollNo,
    this.sClass,
  });

  AppUser.fromJson(dynamic json) {
    role = json['Role'];
    address = json['Address'];
    phoneNo = json['PhoneNo'];
    profileImage = json['ProfileImage'];
    fullName = json['FullName'];
    id = json['id'];
    subject = json['Subject'];
    fatherName = json['FatherName'];
    rollNo = json['RollNo'];
    sClass = json['Class'];
  }
  String? role;
  String? address;
  String? phoneNo;
  String? profileImage;
  String? fullName;
  String? id;
  String? subject;
  String? fatherName;
  String? rollNo;
  String? sClass;
  AppUser copyWith({
    String? role,
    String? address,
    String? phoneNo,
    String? profileImage,
    String? fullName,
    String? id,
    String? subject,
    String? fatherName,
    String? rollNo,
    String? sClass,
  }) =>
      AppUser(
        role: role ?? this.role,
        address: address ?? this.address,
        phoneNo: phoneNo ?? this.phoneNo,
        profileImage: profileImage ?? this.profileImage,
        fullName: fullName ?? this.fullName,
        id: id ?? this.id,
        subject: subject ?? this.subject,
        fatherName: fatherName ?? this.fatherName,
        rollNo: rollNo ?? this.rollNo,
        sClass: sClass ?? this.sClass,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Role'] = role;
    map['Address'] = address;
    map['PhoneNo'] = phoneNo;
    map['ProfileImage'] = profileImage;
    map['FullName'] = fullName;
    map['id'] = id;
    map['Subject'] = subject;
    map['FatherName'] = fatherName;
    map['RollNo'] = rollNo;
    map['Class'] = sClass;
    return map;
  }
}
