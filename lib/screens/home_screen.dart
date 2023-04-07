import 'dart:convert';

import 'package:attender/utils/storageHandler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  void addAttendence(AttendanceModel attendence) {
    setState(() {
      attendences.add(attendence);
      StorageHandler().saveAttendence(attendences);
    });
  }

  void editSubject(AttendanceModel attendence) {
    setState(() {
      attendences.firstWhere((element) {
        if (element.subjectName.toLowerCase() ==
            attendence.subjectName.toLowerCase()) {
          element.subjectCode = attendence.subjectCode;
          element.subjectName = attendence.subjectName;
          element.totalClasses = attendence.totalClasses;
          element.attendedClasses = attendence.attendedClasses;
          StorageHandler().saveAttendence(attendences);
          return true;
        }
        return false;
      });
    });
  }

  void deleteSubject(AttendanceModel attendence) {
    setState(() {
      attendences.removeWhere(
        (element) => element.subjectCode == attendence.subjectCode,
      );
      StorageHandler().saveAttendence(attendences);
    });
  }

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
            icon: const Icon(
              Icons.refresh,
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
                addAttendence: addAttendence,
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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('attendeces').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                                editSubject: editSubject,
                                deleteSubject: deleteSubject,
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
