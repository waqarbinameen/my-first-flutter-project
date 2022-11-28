import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/choose_option_window/view/choose_options_window.dart';
import 'package:school_management_system/global/user_data.dart';
import 'package:school_management_system/student_window/view/student_window.dart';
import 'package:school_management_system/teacher_window/view/teacher_window.dart';

import 'internet_window.dart';

class ConnectivityWrapper extends StatefulWidget {
  const ConnectivityWrapper({Key? key}) : super(key: key);

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  Connectivity connectivity = Connectivity();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
        future: connectivity.checkConnectivity(),
        builder: (context, fsnap) {
          if (fsnap.hasData) {
            return StreamBuilder<ConnectivityResult>(
                stream: connectivity.onConnectivityChanged,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                        {
                          // print(snapshot.data!.data());
                          return appUser != null
                              ? appUser!.role == "student"
                                  ? StudentWindow()
                                  : TeacherWindow()
                              : ChooseOptionsWindow();

                          // if(widget.role==1){
                          //   return TeacherDashboard();
                          // }else{
                          // return UserDashboard();
                          // }
                        }
                      case ConnectionState.none:
                        {
                          return InternetShowWindow();
                        }
                      case ConnectionState.waiting:
                        return InternetShowWindow();
                      default:
                        return InternetShowWindow();
                    }
                  } else {
                    return Material(
                      color: Colors.white70,
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  }
                });
          } else {
            return InternetShowWindow();
          }
        });
  }
}
