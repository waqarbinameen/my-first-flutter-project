import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/student_window/view/student_window.dart';

import '../../../global/user_data.dart';
import '../../add_details_window/view/add_details.dart';

class ProfileWindow extends StatefulWidget {
  const ProfileWindow({Key? key}) : super(key: key);

  @override
  State<ProfileWindow> createState() => _ProfileWindowState();
}

class _ProfileWindowState extends State<ProfileWindow> {
  final _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection("usersDetail");

  String? downloadURL;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
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
                        child: ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: appUser!.profileImage != null
                              ? Image(
                                  fit: BoxFit.cover,
                                  width: 200.w,
                                  height: 200.h,
                                  image: NetworkImage(
                                    appUser!.profileImage.toString(),
                                  ))
                              : Image(
                                  height: 110.h,
                                  width: 110.w,
                                  color: Colors.black26,
                                  image: const AssetImage(
                                      "assets/images/smile.png")),
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Text(
                        "ID Card".toUpperCase(),
                        style: TextStyle(
                            fontFamily: "Oswald",
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff28C2A0),
                            fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      appUser!.role != null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Full Name:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appUser!.fullName.toString(),
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Father Name:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appUser!.fatherName.toString(),
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Class:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appUser!.sClass.toString(),
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Roll No:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appUser!.rollNo.toString(),
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Phone Number:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appUser!.phoneNo.toString(),
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Address:",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 16.sp,
                                          color: const Color(0xff0C46C4)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        children: [
                                          Text(
                                            appUser!.address.toString(),
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  "Please update profile data",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 16.sp,
                                      color: const Color(0xff0C46C4)),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => const AddDetailsWindow());
                        },
                        child: Container(
                          height: 50.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff0C46C4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontSize: 26.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => const StudentWindow());
                        },
                        child: Container(
                          height: 50.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff0C46C4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontSize: 26.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    try {
      await downloadURLExample();
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLExample() async {
    String id = _auth.currentUser!.email.toString();
    downloadURL = await FirebaseStorage.instance
        .ref('/profileImages/students')
        .child(id)
        .getDownloadURL();
    debugPrint(downloadURL.toString());
  }
}
