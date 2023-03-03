import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Model/AttendanceModel.dart';

class AttendenceWidget extends StatefulWidget {
  final AttendanceModel attendence;
  const AttendenceWidget({required this.attendence});

  @override
  State<AttendenceWidget> createState() => _AttendenceWidgetState();
}

class _AttendenceWidgetState extends State<AttendenceWidget> {
  int calculateReqClass(int totalClass, int attendedClass) {
    if (totalClass == 0) {
      return 0;
    }
    int a = ((attendedClass / totalClass) * 100).toInt();
    if (a >= 75) {
      return 0;
    } else {
      a = ((75 * totalClass - 100 * attendedClass) / 25).toInt();
      return a;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 3,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Lottie.asset(
                (widget.attendence.subjectCode.toLowerCase().contains('cs'))
                    ? 'assets/json/cs.json'
                    : 'assets/json/ma.json',
                height: 150,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 3,
                  //     spreadRadius: 3,
                  //     offset: Offset(0, 4),
                  //     color: Colors.black.withOpacity(0.25),
                  //   ),
                  // ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(10),
                // margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.attendence.subjectName,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.attendence.subjectCode,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                "Attended : ${widget.attendence.attendedClasses}"),
                            Text("Total : ${widget.attendence.totalClasses}")
                            // IconButton(
                            //   icon: const Icon(Icons.done),
                            //   onPressed: () {},
                            // ),
                            // IconButton(
                            //   icon: const Icon(Icons.cancel_sharp),
                            //   onPressed: () {},
                            // ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // maximumSize: MediaQuery.of(context).size * 25,
                            // minimumSize: MediaQuery.of(context).size * 0.25,
                            shadowColor: Colors.black,
                          ),
                          onPressed: () {
                            widget.attendence.totalClasses =
                                widget.attendence.totalClasses + 1;
                            widget.attendence.attendedClasses =
                                widget.attendence.attendedClasses + 1;
                            setState(() {});
                          },
                          child: Text(
                            "YES",
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 50,
                          width: 160,
                          child: Center(
                            child: Text(
                              (calculateReqClass(widget.attendence.totalClasses,
                                          widget.attendence.attendedClasses) ==
                                      0)
                                  ? "Great you already have 75% attendance"
                                  : "You have to attend next ${calculateReqClass(widget.attendence.totalClasses, widget.attendence.attendedClasses)} class to gain 75% attendence",
                              maxLines: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // maximumSize: MediaQuery.of(context).size * 25,
                            // minimumSize: MediaQuery.of(context).size * 0.25,
                            shadowColor: Colors.black,
                          ),
                          onPressed: () {
                            widget.attendence.totalClasses =
                                widget.attendence.totalClasses + 1;
                            setState(() {});
                          },
                          child: Text(
                            "NO",
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "${((widget.attendence.attendedClasses / widget.attendence.totalClasses) * 100).roundToDouble()}",
                    //   style: const TextStyle(fontSize: 30, color: Colors.purple),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          right: 30,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (widget.attendence.totalClasses == 0) ? null :Colors.purple[50],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
             (widget.attendence.totalClasses == 0) ? "" : "${((widget.attendence.attendedClasses / widget.attendence.totalClasses) * 100).roundToDouble()}",
              style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
          ),
        ),
      ],
    );
  }
}