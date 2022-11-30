import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/auth/forget_window/view/forget_password.dart';
import 'package:school_management_system/auth/login_with_phone/login_with_phone.dart';
import 'package:school_management_system/auth/signup_window/view/signup_window.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';
import 'package:school_management_system/global/user_data.dart';
import 'package:school_management_system/student_window/view/student_window.dart';

import '../../../global/models/app_user.dart';
import '../../../teacher_window/view/teacher_window.dart';

class LoginWindow extends StatefulWidget {
  final int? role;
  const LoginWindow({Key? key, required this.role}) : super(key: key);

  @override
  State<LoginWindow> createState() => _LoginWindowState();
}

class _LoginWindowState extends State<LoginWindow> {
  bool isShow = true;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _uEmail = TextEditingController();
  final TextEditingController _uPassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // var controller = Get.isRegistered<AuthControllerLogin>()
  //     ? Get.find<AuthControllerLogin>()
  //     : Get.put(AuthControllerLogin());
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
                            image: const AssetImage("assets/images/Logo.png")),
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _uEmail,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      decoration: InputDecoration(
                          labelText: "Username/ Email",
                          labelStyle:
                              TextStyle(fontFamily: "Roboto", fontSize: 14.sp),
                          suffixIcon: const Icon(
                            Icons.person,
                            color: Color(0xff0C46C4),
                          )),
                    ),
                    TextFormField(
                      controller: _uPassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) return "Enter Password";
                        return null;
                      },
                      obscureText: isShow,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14.sp,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              _togglePasswordView();
                            },
                            child: Icon(
                              isShow ? Icons.visibility : Icons.visibility_off,
                              color: const Color(0xff0C46C4),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ForgetPasswordWindow());
                      },
                      child: Text(
                        "Forget password?",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Roboto",
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          //AuthController

                          // controller.login(_uEmail.text, _uPassword.text);

                          login();
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          color: const Color(0xff0C46C4),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 5,
                                )
                              : Text(
                                  "Login",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Change option",
                          style:
                              TextStyle(fontFamily: "Roboto", fontSize: 12.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(() => const ChooseOptionsWindow());
                          },
                          child: Text(
                            "Click here",
                            style: TextStyle(
                                color: const Color(0xff0C46C4),
                                fontFamily: "Roboto",
                                fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const LoginWithPhoneWindow());
                      },
                      child: Container(
                        height: 50.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xff28C2A0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Login with phone number",
                            style: TextStyle(
                                color: const Color(0xff0C46C4),
                                fontFamily: "Roboto",
                                fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      visible: widget.role == 1 ? false : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If you have't account?",
                            style: TextStyle(
                                fontFamily: "Roboto", fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const SignupWindow());
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: const Color(0xff0C46C4),
                                  fontFamily: "Roboto",
                                  fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void login() {
    setState(() {
      _isLoading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: _uEmail.text, password: _uPassword.text)
        .then((value) async {
      await getUserData();
      setState(() {
        _isLoading = false;
      });
      if ((appUser!.role == "student") && (widget.role == 1)) {
        Get.snackbar("Information", "Welcome Student Panel");

        Get.off(() => const StudentWindow());
      } else if ((appUser!.role == "teacher") && (widget.role == 2)) {
        Get.snackbar("Information", "Welcome to Teacher Panel");

        Get.off(() => const TeacherWindow());
      } else {
        Get.snackbar("Error", "Please Choose Correct Role Option");
      }
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar("Error", e.toString());
    });
  }

  Future<void> getUserData() async {
    var doc = await FirebaseFirestore.instance
        .collection('usersDetail')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (doc.exists) {
      appUser = AppUser.fromJson(doc.data());
    }
  }

  void _togglePasswordView() {
    setState(() {
      isShow = !isShow;
    });
  }
}
