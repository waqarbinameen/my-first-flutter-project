import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  late String name;
  late String profilePhoto;
  late String email;
  late String uid;
  late String phoneNo;
  late String uClass;
  late String uRollNo;

  MyUser({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
    required this.phoneNo,
    required this.uClass,
    required this.uRollNo,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePic": profilePhoto,
        "email": email,
        "uid": uid,
        "phoneNo": phoneNo,
        "uClass": uClass,
        "uRollNo": uRollNo,
      };
  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
        email: snapshot["email"],
        profilePhoto: snapshot["profilePhoto"],
        uid: snapshot["uid"],
        name: snapshot["name"],
        phoneNo: snapshot["phoneNo"],
        uClass: snapshot["uClass"],
        uRollNo: snapshot["uRollNo"]);
  }
}
