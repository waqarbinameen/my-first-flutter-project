import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../choose_option_window/view/choose_options_window.dart';
import '../../connection_window/view/connectivity_wrapper.dart';
import '../../global/models/app_user.dart';
import '../../global/user_data.dart';

class SplashWindow extends StatefulWidget {
  const SplashWindow({Key? key}) : super(key: key);

  @override
  State<SplashWindow> createState() => _SplashWindowState();
}

class _SplashWindowState extends State<SplashWindow> {
  int mode = 0;

  getUserData() async {
    var doc = await FirebaseFirestore.instance
        .collection('usersDetail')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (doc.exists) {
      appUser = AppUser.fromJson(doc.data());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user == null) {
        Timer(const Duration(seconds: 6), () {
          Get.offAll(() => const ChooseOptionsWindow());
        });
      } else {
        await getUserData();
        Timer(const Duration(seconds: 4), () {
          Get.offAll(() => const ConnectivityWrapper());
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -350.h,
            left: -400.w,
            right: 0.w,
            child: Container(
              height: 440.h,
              width: 440.w,
              decoration: BoxDecoration(
                color: const Color(0xff28C2A0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
              left: 0.w,
              right: 0.w,
              top: 0.h,
              bottom: 0.h,
              child: const Image(image: AssetImage("assets/images/Logo.png"))),
          Positioned(
            bottom: -300.h,
            left: -20.w,
            right: -20.w,
            child: Container(
              height: 440.h,
              width: 440.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: const Color(0xff0C46C4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 0.w,
            bottom: 30.h,
            right: 0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Powered By:",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Oswald",
                      color: Colors.white),
                ),
                Text(
                  " Waqar Ahmad",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Oswald",
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
