import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';

import '../../global/user_data.dart';
import '../add_details_window/view/add_details.dart';
import '../add_students_window/view/add_students.dart';
import '../profile_window/view/profile_window.dart';

class TeacherWindow extends StatefulWidget {
  const TeacherWindow({Key? key}) : super(key: key);

  @override
  State<TeacherWindow> createState() => _TeacherWindowState();
}

class _TeacherWindowState extends State<TeacherWindow> {
  final _auth = FirebaseAuth.instance;

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final diff = DateTime.now().difference(timeBackPressed);
        final isExitWarn = diff >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarn) {
          const message = "Press again to exit";

          Fluttertoast.showToast(msg: message, fontSize: 18);

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 220.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: -280.h,
                    left: -30.w,
                    right: -30.w,
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.w,
                    right: 0.w,
                    top: 50.h,
                    child: CircleAvatar(
                      radius: 84.r,
                      backgroundColor: const Color(0xff28C2A0),
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: appUser!.profileImage != null
                                ? Image(
                                    fit: BoxFit.cover,
                                    width: 200.w,
                                    height: 200.h,
                                    image: NetworkImage(
                                      appUser!.profileImage!,
                                    ),
                                    loadingBuilder: (context, img, event) {
                                      if (event == null) return img;
                                      double progress =
                                          (event.expectedTotalBytes! /
                                              event.cumulativeBytesLoaded);

                                      return CircularProgressIndicator(
                                        value: progress,
                                      );
                                    },
                                  )
                                : Image(
                                    height: 110.h,
                                    width: 110.w,
                                    color: Colors.black26,
                                    image: const AssetImage(
                                        "assets/images/smile.png")),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: GridView.count(
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: [
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: const Color(0xff28C2A0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 60.h,
                          color: const Color(0xff0C46C4),
                        ),
                        Text(
                          "Attendance Teacher",
                          style:
                              TextStyle(fontFamily: "Oswald", fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.grading,
                            size: 60.h,
                            color: const Color(0xff0C46C4),
                          ),
                          Text(
                            "Result",
                            style: TextStyle(
                                fontFamily: "Oswald", fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const AddStudentsWindow());
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.how_to_reg,
                            size: 60.h,
                            color: const Color(0xff0C46C4),
                          ),
                          Text(
                            "Register Student",
                            style: TextStyle(
                                fontFamily: "Oswald", fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => const AddDetailsWindow());
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person_add_alt_1,
                            size: 60.h,
                            color: const Color(0xff0C46C4),
                          ),
                          Text(
                            "Add Account Details",
                            style: TextStyle(
                                fontFamily: "Oswald", fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => const ProfileWindow());
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person,
                            size: 60.h,
                            color: const Color(0xff0C46C4),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontFamily: "Oswald", fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialogBox();
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 60.h,
                            color: const Color(0xff0C46C4),
                          ),
                          Text(
                            "Sign out",
                            style: TextStyle(
                                fontFamily: "Oswald", fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDialogBox() {
    Get.defaultDialog(
        title: "Warning...!",
        middleText: "Are you sure to logout?",
        backgroundColor: const Color(0xff28C2A0),
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        textConfirm: "Confirm",
        onConfirm: () {
          _auth.signOut().then((value) {
            Get.snackbar(
                "Information", "Successfully log out....! See you next time ");
            Get.offAll(() => const ChooseOptionsWindow());
          }).onError((error, stackTrace) {
            Get.snackbar("Error", error.toString());
          });
        },
        textCancel: "Cancel",
        // onCancel: () {
        //   // if (Get.isDialogOpen == true) {
        //   Get.back();
        // },
        cancelTextColor: Colors.white,
        confirmTextColor: Colors.white,
        buttonColor: const Color(0xff0C46C4),
        barrierDismissible: false,
        radius: 10,
        content: const Text("Are you sure to logout?"));
  }
}
