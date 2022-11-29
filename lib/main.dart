import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:school_management_system/auth/login_window/model/login_controller.dart';
import 'package:school_management_system/auth/signup_window/view_model/signup_controller.dart';
import 'package:school_management_system/splash_window/view/splash_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(() => AuthControllerSign());
  Get.put(() => AuthControllerLogin());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Connectivity connectivity = Connectivity();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(builder: (context, _) {
        return const SplashWindow();
      }),
    );
  }
}

getInit() {
  Get.lazyPut(() => AuthControllerSign());
  Get.lazyPut(() => AuthControllerLogin());
}
