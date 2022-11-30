import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/auth/controller.dart';
import 'package:school_management_system/global/models/app_user.dart';
import 'package:school_management_system/global/user_data.dart';
import 'package:school_management_system/student_window/view/student_window.dart';

class AddStudentsDetailsWindow extends StatefulWidget {
  const AddStudentsDetailsWindow({Key? key}) : super(key: key);

  @override
  State<AddStudentsDetailsWindow> createState() =>
      _AddStudentsDetailsWindowState();
}

class _AddStudentsDetailsWindowState extends State<AddStudentsDetailsWindow> {
  AuthController auth = AuthController();
  bool isShow = true;
  String picLabel = "Add Photo";
  String role = "student";
  Color picColor = const Color(0xff28C2A0);
  bool isShowConf = true;
  File? img;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future getImg() async {
    final pickedImg =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedImg != null) {
        img = File(pickedImg.path);
        Get.snackbar("Information", "Selected Image Picked");
      } else {
        Get.snackbar("Error Occurred", "No image picked");
      }
    });
  }

  bool _isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _uFatherName = TextEditingController();
  final TextEditingController _uPhoneNo = TextEditingController();
  final TextEditingController _uClass = TextEditingController();
  final TextEditingController _uRollNo = TextEditingController();
  final TextEditingController _uAddress = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection("usersDetail");
  final _auth = FirebaseAuth.instance;
  late String imgUrl = "";
  loadingStudentData() {
    if (appUser == null) return;
    AppUser s = appUser!;
    if (s.fatherName == null || s.sClass == null) return;

    _fullName.text = s.fullName!;
    _uFatherName.text = s.fatherName!;
    _uClass.text = s.sClass!;
    _uRollNo.text = s.rollNo!;
    _uPhoneNo.text = s.phoneNo!;
    _uAddress.text = s.address!;
    imgUrl = s.profileImage!;
  }

  @override
  void initState() {
    loadingStudentData();
    super.initState();
  }

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
                        child: InkWell(
                          onTap: () {
                            getImg();
                          },
                          splashColor: Colors.transparent,
                          child: CircleAvatar(
                            radius: 80.r,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              child: img != null
                                  ? ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          height: 200.h,
                                          width: 200.w,
                                          image: FileImage(img!.absolute)),
                                    )
                                  : imgUrl.isNotEmpty
                                      ? ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: Image(
                                              fit: BoxFit.cover,
                                              height: 200.h,
                                              width: 200.w,
                                              image: NetworkImage(imgUrl)),
                                        )
                                      : img != null
                                          ? ClipOval(
                                              clipBehavior: Clip.hardEdge,
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  height: 200.h,
                                                  width: 200.w,
                                                  image:
                                                      FileImage(img!.absolute)),
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
                      )),
                  Positioned(
                      bottom: 40.h,
                      left: 130.w,
                      right: 0.w,
                      child: img != null
                          ? const Text("")
                          : Text(
                              picLabel,
                              style: TextStyle(
                                color: picColor,
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
                          "Details Form",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff28C2A0),
                              fontSize: 18.sp),
                        ),
                        TextFormField(
                          controller: _fullName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Full name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uFatherName,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (vale) {
                            if (vale!.isEmpty) {
                              return "Enter Father Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Father Name",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uClass,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (vale) {
                            if (vale!.isEmpty) {
                              return "Enter Class";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Class",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.class_,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uRollNo,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter RollNo";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Roll Number",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.numbers,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uPhoneNo,
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return "Enter phone no";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.phone_enabled,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        TextFormField(
                          controller: _uAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (vale) {
                            if (vale!.isEmpty) {
                              return "Enter Address";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Address",
                              labelStyle: TextStyle(
                                  fontFamily: "Roboto", fontSize: 14.sp),
                              suffixIcon: const Icon(
                                Icons.location_on,
                                color: Color(0xff0C46C4),
                              )),
                        ),
                        SizedBox(
                          height: 50.h,
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
                                if (img != null) {
                                  if (formKey.currentState!.validate()) {
                                    addDetails();
                                    auth.getUserData();
                                  }
                                } else {
                                  setState(() {
                                    picLabel = "Pic must upload";
                                    picColor = Colors.red;
                                  });
                                }
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 5,
                                    )
                                  : Text(
                                      "Save",
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
                                Get.off(() => const StudentWindow());
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
                        SizedBox(
                          height: 20.h,
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

  void addDetails() {
    setState(() {
      _isLoading = true;
    });
    String id = _auth.currentUser!.email.toString();
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/profileImages/students/$id');
    firebase_storage.UploadTask uploadTask = ref.putFile(img!.absolute);
    Future.value(uploadTask).then((value) async {
      var newUrl = await ref.getDownloadURL();

      // String idd = DateTime.now().microsecondsSinceEpoch.toString();
      fireStore.doc(id).set({
        "id": id,
        "Role": role.toString(),
        "FullName": _fullName.text,
        "Class": _uClass.text,
        "RollNo": _uRollNo.text,
        "PhoneNo": _uPhoneNo.text,
        "Address": _uAddress.text,
        "FatherName": _uFatherName.text,
        "ProfileImage": newUrl.toString(),
      }).then((value) {
        setState(() {
          _isLoading = false;
        });
        auth.getUserData();
        Get.snackbar("Information", "Details Save Successfully ");
        Get.off(() => const StudentWindow());
      }).onError((error, stackTrace) {
        Get.snackbar("Error Occurred", error.toString());
        setState(() {
          _isLoading = false;
        });
      });
    });
  }
}
