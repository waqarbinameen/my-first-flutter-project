import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/auth/signup_window/view/signup_window.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';

class ForgetPasswordWindow extends StatefulWidget {
  const ForgetPasswordWindow({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordWindow> createState() => _ForgetPasswordWindowState();
}

class _ForgetPasswordWindowState extends State<ForgetPasswordWindow> {
  bool isShow = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _uEmail = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Please enter a valid email",
                        decoration: InputDecoration(
                            labelText: "Username/ Email",
                            labelStyle: TextStyle(
                                fontFamily: "Roboto", fontSize: 14.sp),
                            suffixIcon: const Icon(
                              Icons.person,
                              color: Color(0xff0C46C4),
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            //AuthController
                            // controller.login(_uEmail.text, _uPassword.text);
                            forgetPassword();
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
                                    "Reset",
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
                            "If you have't account?",
                            style: TextStyle(
                                fontFamily: "Roboto", fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupWindow()));
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void forgetPassword() {
    setState(() {
      _isLoading = true;
    });
    _auth.sendPasswordResetEmail(email: _uEmail.text).then((value) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar("Information", "Reset Link Send Successfully");
      Get.to(() => const ChooseOptionsWindow());
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        "Error occurred",
        error.toString(),
      );
    });
  }
}
