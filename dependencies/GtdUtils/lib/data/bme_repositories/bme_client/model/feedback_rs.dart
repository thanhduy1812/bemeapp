class FeedbackAsk {
  int? id;
  DateTime? createdAt;
  String? createdBy;
  String? updatedBy;
  bool? isDeleted;
  String? fbQuestion;
  String? fbDefaultAnswers;

  FeedbackAsk({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.isDeleted,
    this.fbQuestion,
    this.fbDefaultAnswers,
  });

  factory FeedbackAsk.fromJson(Map<String, dynamic> json) => FeedbackAsk(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        isDeleted: json["is_deleted"],
        fbQuestion: json["fbQuestion"],
        fbDefaultAnswers: json["fbDefaultAnswers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "is_deleted": isDeleted,
        "fbQuestion": fbQuestion,
        "fbDefaultAnswers": fbDefaultAnswers,
      };
}
