

class UserFeedback {
  int? id;
  DateTime? createdAt;
  DateTime? createdBy;
  String? updatedBy;
  bool? isDeleted;
  String? userName;
  int? lessonRoadmapId;
  DateTime? cancelDate;
  int? feedbackId;
  String? feedbackAnswer;
  String? feedbackTo;
  DateTime? feedbackDate;
  DateTime? catchUpDate;

  UserFeedback({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.userName,
    this.lessonRoadmapId,
    this.cancelDate,
    this.feedbackId,
    this.feedbackAnswer,
    this.feedbackTo,
    this.feedbackDate,
    this.catchUpDate,
  });

  factory UserFeedback.fromJson(Map<String, dynamic> json) => UserFeedback(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["created_by"] == null ? null : DateTime.parse(json["created_by"]),
        updatedBy: json["updated_by"],
        isDeleted: json["is_deleted"],
        userName: json["userName"],
        lessonRoadmapId: json["lessonRoadmapId"],
        cancelDate: json["cancelDate"] == null ? null : DateTime.parse(json["cancelDate"]),
        feedbackId: json["feedbackId"],
        feedbackAnswer: json["feedbackAnswer"],
        feedbackTo: json["feedbackTo"],
        feedbackDate: json["feedbackDate"] == null ? null : DateTime.parse(json["feedbackDate"]),
        catchUpDate: json["catchUpDate"] == null ? null : DateTime.parse(json["catchUpDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "created_by": createdBy?.toIso8601String(),
        "updated_by": updatedBy,
        "is_deleted": isDeleted,
        "userName": userName,
        "lessonRoadmapId": lessonRoadmapId,
        "cancelDate": cancelDate?.toIso8601String(),
        "feedbackId": feedbackId,
        "feedbackAnswer": feedbackAnswer,
        "feedbackTo": feedbackTo,
        "feedbackDate": feedbackDate?.toIso8601String(),
        "catchUpDate": catchUpDate?.toIso8601String(),
      };

  Map<String, dynamic> toRequestJson() => {
        "userName": userName,
        "lessonRoadmapId": lessonRoadmapId,
        "feedbackId": feedbackId,
        "feedbackAnswer": feedbackAnswer,
        "feedbackTo": feedbackTo,
        "feedbackDate": feedbackDate?.toIso8601String()
      };
}
