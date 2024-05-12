import 'package:easy_localization/easy_localization.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';

class AddLessonRq {
  String? classCode;
  String? lessonName;
  String? lessonStatus;
  String? mentorName;
  String? mentorId;
  DateTime? startDate;

  AddLessonRq({
    this.classCode,
    this.lessonName,
    this.lessonStatus,
    this.mentorName,
    this.mentorId,
    this.startDate,
  });

  factory AddLessonRq.fromJson(Map<String, dynamic> json) => AddLessonRq(
        classCode: json["classCode"],
        lessonName: json["lessonName"],
        mentorName: json["mentorName"],
        mentorId: json["mentorId"],
        lessonStatus: json["lessonStatus"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      );

  Map<String, dynamic> toJson() => {
        "classCode": classCode,
        "lessonName": lessonName,
        "mentorName": mentorName,
        "mentorId": mentorId,
        "lessonStatus": lessonStatus,
        "startDate": DateFormat(iosPattern).format(startDate!),
      };
}
