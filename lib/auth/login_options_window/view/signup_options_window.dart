import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_management_system/auth/login_with_phone/login_with_phone.dart';
import 'package:school_management_system/auth/signup_window/view/signup_window.dart';
import 'package:school_management_system/global/user_data.dart';
import 'package:school_management_system/student_window/view/student_window.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../../global/models/app_user.dart';
import '../../../teacher_window/view/teacher_window.dart';
import '../../login_window/view/login_window.dart';

class SignupOptionsWindow extends StatefulWidget {
  final int? role;
  const SignupOptionsWindow({Key? key, required this.role}) : super(key: key);

  @override
  State<SignupOptionsWindow> createState() => _SignupOptionsWindowState();
}

class _SignupOptionsWindowState extends State<SignupOptionsWindow> {
  String? uEmail;
  User? user;
  User? userFb;
  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
      apiKey: 'wkeO1wbI1dHfEjK9TMXPdbD4g',
      apiSecretKey: 'b60VwlAerBi39M2TBKz1V6bDAbzu2J2vWFupWs2ZSl6Quz6uVf',
      redirectURI: 'school-management-system://',
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();
    debugPrint("Auth Result: ${authResult.toString()}");
    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  bool isShow = true;
  bool _isLoading = false;
  bool _isLoadingLogin = false;

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
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SignupWindow());
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 30.h,
                                  image: AssetImage("assets/images/email.png")),
                              SizedBox(
                                width: 25.w,
                              ),
                              Text(
                                "Sign Up with Email",
                                style: TextStyle(
                                    color: const Color(0xff0C46C4),
                                    fontFamily: "Roboto",
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 30.h,
                                  image: AssetImage("assets/images/phone.png")),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                "Sign Up with Phone",
                                style: TextStyle(
                                    color: const Color(0xff0C46C4),
                                    fontFamily: "Roboto",
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoadingLogin = true;
                        });
                        await signInWithFacebook().then((value) {
                          user = FirebaseAuth.instance.currentUser;
                          setState(() {
                            uEmail = user!.email.toString();
                          });
                          Get.to(() => SignupWindow(
                                uEmail: uEmail,
                              ));
                          Get.snackbar("Information",
                              "Successfully verify with facebook");

                          setState(() {
                            _isLoadingLogin = false;
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            _isLoadingLogin = false;
                          });
                          debugPrint(error.toString());
                          Get.snackbar("Error", error.toString());
                        });
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 30.h,
                                  image:
                                      AssetImage("assets/images/facebook.png")),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                "Sign Up with Facebook",
                                style: TextStyle(
                                    color: const Color(0xff0C46C4),
                                    fontFamily: "Roboto",
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        await signInWithTwitter().then((value) {
                          user = FirebaseAuth.instance.currentUser;
                          setState(() {
                            uEmail = user!.email.toString();
                          });
                          Get.to(() => SignupWindow(
                                uEmail: uEmail,
                              ));
                          Get.snackbar(
                              "Information", "Successfully verify with Google");
                        }).onError((error, stackTrace) {
                          debugPrint(error.toString());
                          Get.snackbar("Error", error.toString());
                        });
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 30.h,
                                  image:
                                      AssetImage("assets/images/twitter.png")),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                "Sign Up with Twitter",
                                style: TextStyle(
                                    color: const Color(0xff0C46C4),
                                    fontFamily: "Roboto",
                                    fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        await signInWithGoogle().then((value) {
                          user = FirebaseAuth.instance.currentUser;
                          setState(() {
                            uEmail = user!.email.toString();
                          });
                          Get.to(() => SignupWindow(
                                uEmail: uEmail,
                              ));
                          Get.snackbar(
                              "Information", "Successfully verify with Google");
                        }).onError((error, stackTrace) {
                          debugPrint(error.toString());
                          Get.snackbar("Error", error.toString());
                        });
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                  height: 30.h,
                                  image:
                                      AssetImage("assets/images/google.png")),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                "Sign Up with Google",
                                style: TextStyle(
                                    color: const Color(0xff0C46C4),
                                    fontFamily: "Roboto",
                                    fontSize: 20.sp),
                              ),
                            ],
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
                            "You have an account?",
                            style: TextStyle(
                                fontFamily: "Roboto", fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAll(() => LoginWindow(role: widget.role));
                            },
                            child: Text(
                              "Login",
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
