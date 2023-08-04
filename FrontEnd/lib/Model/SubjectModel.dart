class SubjectModel {
  String id;
  String subjectName;
  String subjectCode;
  int totalClasses;
  int attendedClasses;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.totalClasses,
    required this.attendedClasses,
  });

  static fromJson(jsonData) {
    return SubjectModel(
      id: jsonData['id'],
      subjectName: jsonData['subjectName'],
      subjectCode: jsonData['subjectCode'],
      totalClasses: jsonData['totalClasses'],
      attendedClasses: jsonData['attendedClasses'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectName': subjectName,
        'subjectCode': subjectCode,
        'totalClasses': totalClasses,
        'attendedClasses': attendedClasses,
      };
}
