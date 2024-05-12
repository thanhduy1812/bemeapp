class LessonRoadmapRs {
  int? id;
  DateTime? createdAt;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  String? classCode;
  String? skillCode;
  String? lessonName;
  String? mentorName;
  String? mentorId;
  String? lessonStatus;
  DateTime? startDate;
  DateTime? endDate;

  LessonRoadmapRs({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.classCode,
    this.skillCode,
    this.lessonName,
    this.mentorName,
    this.mentorId,
    this.lessonStatus,
    this.startDate,
    this.endDate,
  });

  factory LessonRoadmapRs.fromJson(Map<String, dynamic> json) => LessonRoadmapRs(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDeleted: json["is_deleted"],
        classCode: json["classCode"],
        skillCode: json["skillCode"],
        lessonName: json["lessonName"],
        lessonStatus: json["lessonStatus"],
        mentorName: json["mentorName"],
        mentorId: json["mentorId"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_deleted": isDeleted,
        "classCode": classCode,
        "skillCode": skillCode,
        "lessonName": lessonName,
        "lessonStatus": lessonStatus,
        "mentorName": mentorName,
        "mentorId": mentorId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
      };
}
