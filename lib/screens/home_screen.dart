import 'dart:convert';

import 'package:attender/Provider/authenticationProvider.dart';
import 'package:attender/Provider/subjectProvider.dart';
import 'package:attender/screens/signIn_screen.dart';
import 'package:attender/utils/storageHandler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Data/attendaceData.dart';
import '../Model/AttendanceModel.dart';
import '../widget/addAttendencePopUpWidget.dart';
import '../widget/attendenceWidget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Firebase.initializeApp();
    StorageHandler().getAttendence();
  }

  void addAttendence(String subjectName, String subjectCode) async {
    String resText = await Provider.of<SubjectProvider>(context, listen: false)
        .addSubject(subjectName: subjectName, subjectCode: subjectCode);
    setState(() {});
  }

  // void editSubject(AttendanceModel attendence) {
  //   setState(() {
  //     attendences.firstWhere((element) {
  //       if (element.subjectName.toLowerCase() ==
  //           attendence.subjectName.toLowerCase()) {
  //         element.subjectCode = attendence.subjectCode;
  //         element.subjectName = attendence.subjectName;
  //         element.totalClasses = attendence.totalClasses;
  //         element.attendedClasses = attendence.attendedClasses;
  //         StorageHandler().saveAttendence(attendences);
  //         return true;
  //       }
  //       return false;
  //     });
  //   });
  // }

  // void deleteSubject(AttendanceModel attendence) {
  //   setState(() {
  //     attendences.removeWhere(
  //       (element) => element.subjectCode == attendence.subjectCode,
  //     );
  //     StorageHandler().saveAttendence(attendences);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attender"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                StorageHandler().removeToken();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              });
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddAttendacePopUp(
                addAttendence: () {},
              );
            },
          );
          // FirebaseFirestore.instance
          //     .collection('attendences')
          //     .snapshots()
          //     .listen((data) {
          //   data.docs.forEach(
          //     (element) {
          //       print(element['subjectName']);
          //     },
          //   );
          // });
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<SubjectProvider>(context, listen: false)
              .getAllAttendences(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<AttendanceModel> attendences = snapshot.data;
              // String data = jsonEncode(snapshot.data);
              // print(data);
              return Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 50),
                child: (attendences.length == 0)
                    ? Center(
                        child: LottieBuilder.asset('assets/json/empty.json'),
                      )
                    : ListView(
                        // scrollDirection: Axis.vertical,
                        children: attendences
                            .map(
                              (e) => AttendenceWidget(
                                attendence: e,
                                editSubject: () {},
                                deleteSubject: () {},
                              ),
                            )
                            .toList(),
                      ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
