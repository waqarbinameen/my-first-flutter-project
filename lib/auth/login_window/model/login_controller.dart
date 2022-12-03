import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:school_management_system/auth/signup_window/view_model/signup_controller.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';

import '../../../teacher_window/view/teacher_window.dart';

class AuthControllerLogin extends GetxController {
  static AuthControllerLogin instance = Get.find<AuthControllerLogin>();
  //late Rx<User?> _user;
  @override
  void onReady() {
    var cu = FirebaseAuth.instance.currentUser;
    // print("Current User; ${cu.toString()}");
    // _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    // _user.bindStream(FirebaseAuth.instance.authStateChanges());
    // ever(_user, _setInitialView);
    _setInitialView(cu);
    super.onReady();
  }

  _setInitialView(User? user) {
    logger("Navigating from initial view");
    if (user == null) {
      Get.offAll(() => const ChooseOptionsWindow());
    } else {
      Get.offAll(() => const TeacherWindow());
    }
  }

  void login(String email, String password) async {
    try {
      if ((email.isNotEmpty) && (password.isNotEmpty)) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error in Login", "Please enter details");
      }
    } catch (e) {
      Get.snackbar("Error Occurred", "Error Occurred! PLease try again$e");
    }
  }
}
