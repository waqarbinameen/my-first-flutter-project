import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:school_management_system/auth/controller.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';

import '../../global/user_data.dart';
import '../add_details_window/view/add_teachers_details.dart';
import '../add_students_window/view/add_students.dart';
import '../profile_window/view/profile_window.dart';

class TeacherWindow extends StatefulWidget {
  const TeacherWindow({Key? key}) : super(key: key);

  @override
  State<TeacherWindow> createState() => _TeacherWindowState();
}

class _TeacherWindowState extends State<TeacherWindow> {
  AuthController authCon = AuthController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  DateTime timeBackPressed = DateTime.now();
  loadData() {
    authCon.getUserData();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

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
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xff28C2A0),
        ),
        drawer: Drawer(
            backgroundColor: const Color(0xff28C2A0),
            child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xffC4C4C4),
                    ),
                    accountName: Text(
                      "Student",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    accountEmail: Text(
                      appUser!.id.toString(),
                      style: TextStyle(
                        fontFamily: "Oswald",
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 84.r,
                      backgroundColor: const Color(0xff28C2A0),
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: appUser?.profileImage != null
                                ? Image(
                                    fit: BoxFit.cover,
                                    width: 200.w,
                                    height: 200.h,
                                    image: NetworkImage(
                                        appUser!.profileImage.toString()))
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
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.to(() => const ProfileWindow());
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialogBox();
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialogBoxDeleteDoc();
                    },
                  ),
                ])),
        body: Column(
          children: [
            SizedBox(
              height: 220.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: -335.h,
                    left: -40.w,
                    right: -40.w,
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
                    top: 1.h,
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
              height: 10.h,
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
                  InkWell(
                    onTap: () {
                      showDialogBoxDeleteDoc();
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff28C2A0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xff0C46C4),
                                strokeWidth: 5,
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.cloud_off,
                                    size: 60.h,
                                    color: const Color(0xff0C46C4),
                                  ),
                                  Text(
                                    "Delete Account",
                                    style: TextStyle(
                                        fontFamily: "Oswald", fontSize: 14.sp),
                                  ),
                                ],
                              ),
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

  void showDialogBoxDeleteDoc() {
    Get.defaultDialog(
        title: "Warning...!",
        backgroundColor: const Color(0xff28C2A0),
        titleStyle: const TextStyle(
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto"),
        middleTextStyle: const TextStyle(color: Colors.white),
        textConfirm: "Confirm",
        onConfirm: () async {
          setState(() {
            _isLoading = true;
          });
          Navigator.pop(context);
          String id = _auth.currentUser!.email.toString();
          await _auth.currentUser?.delete().then((value) async {
            try {
              await FirebaseFirestore.instance
                  .collection("usersDetail")
                  .doc(id)
                  .delete()
                  .then((value) async {
                final desertRef = firebase_storage.FirebaseStorage.instance
                    .ref('/profileImages/teachers/$id');
                await desertRef.delete();
                _auth.signOut();
                Get.snackbar("Information", "Successfully Account Deleted");
                Get.offAll(() => const ChooseOptionsWindow());
                setState(() {
                  _isLoading = false;
                });
              }).onError((error, stackTrace) {
                setState(() {
                  _isLoading = false;
                });
                Get.snackbar("Error", error.toString());
              });
            } catch (e) {
              return;
            }
          });
        },
        textCancel: "Cancel",
        cancelTextColor: Colors.white,
        confirmTextColor: Colors.white,
        buttonColor: const Color(0xff0C46C4),
        barrierDismissible: false,
        radius: 10,
        content: Padding(
            padding: EdgeInsets.all(10.h),
            child: Wrap(
              children: const [
                Text(
                  "Are you sure to delete account?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Deleting your account will delete your access and all your information.",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )));
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
