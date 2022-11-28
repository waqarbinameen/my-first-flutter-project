import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../student_window/view/student_window.dart';

class LoginWithPhoneWindow extends StatefulWidget {
  const LoginWithPhoneWindow({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneWindow> createState() => _LoginWithPhoneWindowState();
}

class _LoginWithPhoneWindowState extends State<LoginWithPhoneWindow> {
  bool isShow = true;
  Image? icon;
  String opt = "";
  bool _optVis = false;
  bool _loginVis = false;
  IconData? iconN;
  bool _isLoading = false;
  bool _isLoadingLogin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _uPhone = TextEditingController();
  final TextEditingController _uOPT = TextEditingController();
  final _countryCode = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyOPT = GlobalKey<FormState>();

  // var controller = Get.isRegistered<AuthControllerLogin>()
  //     ? Get.find<AuthControllerLogin>()
  //     : Get.put(AuthControllerLogin());
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
                          child: ClipRRect(
                            child: Image(
                                height: 110.h,
                                width: 110.w,
                                image:
                                    const AssetImage("assets/images/Logo.png")),
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
                  child: Column(
                    children: [
                      Form(
                          key: formKey,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  controller: _countryCode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Choose Code";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showCountryPicker(
                                        showPhoneCode: true,
                                        favorite: ["PK"],
                                        context: context,
                                        onSelect: (Country value) {
                                          setState(() {
                                            _countryCode.text =
                                                "+${value.phoneCode} ";
                                          });
                                        });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Code",
                                    hintText: "Choose Country Code",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _uPhone,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter phone Number";
                                    } else if (value.length < 10 ||
                                        value.length > 10) {
                                      return "Enter correct phone number";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      hintText: "123 1234 123",
                                      labelStyle: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14.sp),
                                      suffixIcon: const Icon(
                                        Icons.contact_phone,
                                        color: Color(0xff0C46C4),
                                      )),
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            loginWithPhone();
                          }
                        },
                        child: Container(
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Color(0xff0C46C4),
                                    strokeWidth: 5,
                                  )
                                : Text(
                                    "Send OPT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff0C46C4),
                                        fontFamily: "Roboto",
                                        fontSize: 26.sp),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Visibility(
                        visible: _optVis,
                        child: Form(
                          key: formKeyOPT,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _uOPT,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              if (value.length == 6) {
                                setState(() {
                                  _loginVis = true;
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "OPT";
                              } else if (value.length < 6 || value.length > 6) {
                                return "Enter correct OPT";
                              }
                              return null;
                            },
                            obscureText: isShow,
                            decoration: InputDecoration(
                                labelText: "OPT",
                                hintText: "6 digit code",
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
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Visibility(
                        visible: _loginVis,
                        child: InkWell(
                          onTap: () async {
                            if (formKeyOPT.currentState!.validate()) {
                              //AuthController
                              // controller.login(_uEmail.text, _uPassword.text);
                              setState(() {
                                _isLoadingLogin = true;
                              });
                              final credential = PhoneAuthProvider.credential(
                                  verificationId: opt, smsCode: _uOPT.text);
                              try {
                                await _auth
                                    .signInWithCredential(credential)
                                    .then((value) {
                                  Get.snackbar(
                                      "Information", "Login successfully");
                                  Get.to(() => const StudentWindow());
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    _isLoadingLogin = false;
                                  });
                                  Get.snackbar(
                                      "Error Occurred", error.toString());
                                });
                              } catch (e) {
                                setState(() {
                                  _isLoadingLogin = false;
                                });
                                Get.snackbar("Error occurred", e.toString());
                              }
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
                              child: _isLoadingLogin
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

  void loginWithPhone() {
    setState(() {
      _isLoading = true;
    });
    _auth.verifyPhoneNumber(
        phoneNumber: _countryCode.text + _uPhone.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Get.snackbar("Failed", e.toString());
          setState(() {
            _isLoading = false;
          });
        },
        codeSent: (String verificationId, int? token) {
          setState(() {
            opt = verificationId;
          });
          setState(() {
            _isLoading = false;
          });
          Get.snackbar("Information", "OPT send successfully");
          setState(() {
            _optVis = true;
          });
        },
        codeAutoRetrievalTimeout: (e) {
          Get.snackbar("Timeout", e.toString());
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
}
