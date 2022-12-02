import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/auth/login_options_window/view/login_options_window.dart';

class ChooseOptionsWindow extends StatefulWidget {
  const ChooseOptionsWindow({Key? key}) : super(key: key);

  @override
  State<ChooseOptionsWindow> createState() => _ChooseOptionsWindowState();
}

class _ChooseOptionsWindowState extends State<ChooseOptionsWindow> {
  int role = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                          child: Image(
                              height: 110.h,
                              width: 110.w,
                              image:
                                  const AssetImage("assets/images/Logo.png")),
                        ),
                      ),
                    )),
                Text(
                  "Sign in",
                  style: TextStyle(
                      fontFamily: "Oswald",
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff28C2A0),
                      fontSize: 18.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Choose your option",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff0C46C4),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    role = 1;
                  });
                  Get.to(() => LoginOptionsWindow(role: role));
                },
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff0C46C4),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(
                    Icons.settings_accessibility,
                    size: 60.h,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    role = 2;
                  });
                  Get.to(() => LoginOptionsWindow(role: role));
                },
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff0C46C4),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(
                    Icons.cast_for_education,
                    size: 60.h,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Student",
                style: TextStyle(fontFamily: "Roboto", fontSize: 16.sp),
              ),
              Text(
                "Teacher",
                style: TextStyle(fontFamily: "Roboto", fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          InkWell(
            onTap: () {
              // Get.off(() => const AddDetailsWindow());
            },
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: const Color(0xff0C46C4),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(
                Icons.person,
                size: 60.h,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Guest",
            style: TextStyle(fontFamily: "Roboto", fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
