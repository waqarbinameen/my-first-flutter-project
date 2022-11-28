import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../teacher_window/view/teacher_window.dart';

class AddStudentsWindow extends StatefulWidget {
  const AddStudentsWindow({Key? key}) : super(key: key);

  @override
  State<AddStudentsWindow> createState() => _AddStudentsWindowState();
}

class _AddStudentsWindowState extends State<AddStudentsWindow> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isShow = true;
  bool isShowConf = true;
  bool _isVisible = true;
  bool _isLoading = false;
  String _setPassword = "";
  bool shouldValidate = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _uEmail = TextEditingController();

  final TextEditingController _uSetPassword = TextEditingController();
  final TextEditingController _uConfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            heroTag: "btnAdd",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signUp();
              }
            },
            backgroundColor: const Color(0xff28C2A0),
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  )
                : Icon(
                    Icons.add,
                    size: 26.sp,
                  )),
        body: Column(
          children: [
            SizedBox(
              height: 220.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: -280,
                    left: -30,
                    right: -30,
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
                      left: 0,
                      right: 0,
                      top: 50,
                      child: CircleAvatar(
                        radius: 84,
                        backgroundColor: const Color(0xff28C2A0),
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              child: Image(
                                  height: 110.h,
                                  width: 110.w,
                                  image: const AssetImage(
                                      "assets/images/Logo.png")),
                            ),
                          ),
                        ),
                      )),
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
                        Text(
                          "Sign up Form",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff28C2A0),
                              fontSize: 18.sp),
                        ),
                        TextFormField(
                          controller: _uEmail,
                          autovalidateMode: shouldValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                          decoration: InputDecoration(
                              labelText: "Username/ Email",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.email,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uSetPassword,
                          autovalidateMode: shouldValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _setPassword = value;
                          },
                          obscureText: isShow,
                          decoration: InputDecoration(
                              labelText: "Set Password",
                              labelStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.sp,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  _togglePasswordView();
                                },
                                child: Icon(
                                  isShow
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xff0C46C4),
                                ),
                              )),
                        ),
                        Visibility(
                          visible: _isVisible,
                          child: FlutterPwValidator(
                            controller: _uSetPassword,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 3,
                            specialCharCount: 1,
                            normalCharCount: 3,
                            width: 400,
                            height: 150,
                            onSuccess: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Password is Strong")));
                              setState(() {
                                _isVisible = false;
                              });
                            },
                            onFail: () {
                              debugPrint("NOT MATCHED");
                              setState(() {
                                _isVisible = true;
                              });
                            },
                          ),
                        ),
                        TextFormField(
                          controller: _uConfPassword,
                          autovalidateMode: shouldValidate
                              ? AutovalidateMode.onUserInteraction
                              : null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            } else if (value != _setPassword) {
                              return "Password not match";
                            }
                            return null;
                          },
                          obscureText: isShowConf,
                          decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14.sp,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  _toggleConfPasswordView();
                                },
                                child: Icon(
                                  isShowConf
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xff0C46C4),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                        Container(
                          height: 50.h,
                          width: 350.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff0C46C4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Get.off(() => const TeacherWindow());
                              },
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() {
    setState(() {
      _isLoading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            email: _uEmail.text, password: _uConfPassword.text)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar("Information", "Student Add Successfully ");
      setState(() {
        _uEmail.clear();
        _uConfPassword.clear();
        _uSetPassword.clear();
        shouldValidate = false;
      });
    }).onError((error, stackTrace) {
      Get.snackbar("Error Occurred", error.toString());
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _togglePasswordView() {
    setState(() {
      isShow = !isShow;
    });
  }

  void _toggleConfPasswordView() {
    setState(() {
      isShowConf = !isShowConf;
    });
  }
}
