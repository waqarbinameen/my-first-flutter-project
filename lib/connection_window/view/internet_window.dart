import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternetShowWindow extends StatefulWidget {
  const InternetShowWindow({Key? key}) : super(key: key);

  @override
  State<InternetShowWindow> createState() => _InternetShowWindowState();
}

class _InternetShowWindowState extends State<InternetShowWindow> {
  @override
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
            left: 60.w,
            top: 130.h,
            child: Center(
              child: SizedBox(
                height: 120.h,
                width: 240.w,
                child: Card(
                    child: Column(
                  children: [
                    Text(
                      "Warning",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 16.sp,
                          color: Colors.orange),
                    ),
                    Icon(
                      Icons.wifi_off,
                      size: 50.sp,
                    ),
                    Wrap(
                      children: [
                        Text(
                          "There is no internet Please connect with internet connection",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontFamily: "Oswald", fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
          Positioned(
              left: 0.w,
              right: 0.w,
              top: 0.h,
              bottom: 0.h,
              child: Image(image: AssetImage("assets/images/Logo.png"))),
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
