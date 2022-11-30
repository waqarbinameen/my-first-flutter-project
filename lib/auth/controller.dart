import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../global/models/app_user.dart';
import '../global/user_data.dart';

class AuthController {
  Future<void> getUserData() async {
    var doc = await FirebaseFirestore.instance
        .collection('usersDetail')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (doc.exists) {
      appUser = AppUser.fromJson(doc.data());
    }
  }
}
