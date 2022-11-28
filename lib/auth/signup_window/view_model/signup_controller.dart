import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/auth/signup_window/model/user.dart';

import '../../../teacher_window/view/teacher_window.dart';

class AuthControllerSign extends GetxController {
  static AuthControllerSign instance = Get.find();
  File? proImage;
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final img = File(image.path);
    proImage = img;
  }

  Future<void> signUp(
    String name,
    String uClass,
    String uRollNo,
    String email,
    String phoneNo,
    String password,
    File? image,
  ) async {
    try {
      if (name.isNotEmpty &&
          uClass.isNotEmpty &&
          uRollNo.isNotEmpty &&
          email.isNotEmpty &&
          phoneNo.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        logger("Created User");
        String downloadUrl = await _uploadProPic(image);
        logger("Uploaded Picture");
        MyUser user = MyUser(
            name: name,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid,
            phoneNo: phoneNo,
            uClass: uClass,
            uRollNo: uRollNo);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
        logger("Written User to DB");
        logger("Going to home");
        Get.offAll(() => const TeacherWindow());
        Get.snackbar("Success", "Profile has been created successfully");
      } else {
        Get.snackbar("Error Creating Account", "Please enter all data");
      }
    } catch (e) {
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }
}

logger(msg) {
  Get.log("================\n${msg.toString()}\n=============");
}
