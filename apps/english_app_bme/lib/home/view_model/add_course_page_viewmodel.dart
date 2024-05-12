import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/bme_client.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/add_lesson_rq.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_origin_course_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_repositories/bme_repository.dart';
import 'package:gtd_utils/data/network/network.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_api_error.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:intl/intl.dart';

class AddCoursePageViewModel extends BasePageViewModel {
  final bool isAddLesson;
  String titleField = "";
  DateTime startDate = DateTime.now();
  BmeUser? seletedMentor;
  final BmeOriginCourse? course;
  final bool isEditMode;
  List<BmeUser> mentors = [];
  bool isOrient = true;
  bool isIPA = false;
  bool isSpeaking = false;
  bool isListening = false;
  bool isGrammar = false;
  Color selectedColor = Colors.red;
  AddCoursePageViewModel({super.title, this.isAddLesson = false, this.course, this.isEditMode = false}) {
    if (course != null) {
      isOrient = course?.dinhHuong?.toLowerCase() == "x";
      isIPA = course?.phatAm?.toLowerCase() == "x";
      isSpeaking = course?.noi?.toLowerCase() == "x";
      isListening = course?.nghe?.toLowerCase() == "x";
      isGrammar = course?.nguPhap?.toLowerCase() == "x";
      int originColor = int.tryParse(course?.mau ?? "0") ?? Colors.green.value;
      selectedColor = Color(originColor);
    }
    loadMentors();
  }

  factory AddCoursePageViewModel.initAddLessonPage({required BmeOriginCourse course}) {
    AddCoursePageViewModel viewModel =
        AddCoursePageViewModel(title: "Add a lesson", isAddLesson: true, course: course, isEditMode: false);
    return viewModel;
  }

  factory AddCoursePageViewModel.initEditLessonPage({required BmeOriginCourse course}) {
    return AddCoursePageViewModel(title: "Add a lesson", isAddLesson: true, course: course, isEditMode: true);
  }

  factory AddCoursePageViewModel.initAddcoursePage() {
    AddCoursePageViewModel addCoursePageViewModel =
        AddCoursePageViewModel(title: "Add a Course", isAddLesson: false, isEditMode: false);
    addCoursePageViewModel.selectedColor = Colors.red;
    return addCoursePageViewModel;
  }

  factory AddCoursePageViewModel.initEditcoursePage(BmeOriginCourse course) {
    AddCoursePageViewModel viewModel =
        AddCoursePageViewModel(title: "Edit this course", course: course, isAddLesson: false, isEditMode: true);
    viewModel.titleField = course.maLop ?? "";
    viewModel.seletedMentor = BmeUser(fullName: course.giaoVienHienTai ?? "");
    try {
      viewModel.startDate = dateFormat.parse(course.ngayKhaiGiang ?? "");
    } catch (e) {
      viewModel.startDate = DateTime.now();
    }

    return viewModel;
  }

  void setStartDate(DateTime date) {
    startDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  void setHourDate(TimeOfDay timeOfDay) {
    DateTime originalDateTime = startDate;
    startDate =
        DateTime(originalDateTime.year, originalDateTime.month, originalDateTime.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  bool validateForm() {
    return titleField.isNotEmpty && (isOrient || isGrammar || isSpeaking || isListening || isIPA);
  }

  Future<Result<AddLessonRq, GtdApiError>> createLessonRoadmap() async {
    // var bmeUser = CacheHelper.shared.loadSavedObject(BmeUser.fromJson, key: CacheStorageType.accountBox.name);

    // var mentor = seletedMentor ?? bmeUser;
    var mentor = mentors.where((element) => element.username == course?.maGV).firstOrNull;
    var lessonRoadmapRq = AddLessonRq(
      classCode: course?.maLop ?? "",
      lessonName: DateFormat("dd/MM/yyyy").format(startDate),
      mentorName: mentor?.fullName,
      mentorId: mentor?.username,
      startDate: startDate,
    );
    return BmeRepository.shared.createLessonRoadmap(addLessonRq: lessonRoadmapRq);
  }

  Future<Result<BmeOriginCourse, GtdApiError>> createCourse() async {
    BmeOriginCourse course = BmeOriginCourse(
        maLop: titleField,
        ngayKhaiGiang: dateFormat.format(startDate),
        mau: "${selectedColor.value}",
        dinhHuong: isOrient ? "x" : "",
        phatAm: isIPA ? "x" : "",
        nghe: isListening ? "x" : "",
        noi: isSpeaking ? "x" : "",
        nguPhap: isGrammar ? "x" : "",
        giaoVienHienTai: seletedMentor?.fullName ?? "",
        maGV: seletedMentor?.username);
    return await BmeRepository.shared.createBmeCourse(course).then((value) {
      if (seletedMentor != null) {
        seletedMentor?.tag = titleField;
        BmeRepository.shared.updateBmeUser(seletedMentor!);
      }
      return value;
    });
  }

  Future<Result<BmeOriginCourse, GtdApiError>> updateCourse() async {
    if (course?.id == null) {
      return Error(GtdApiError(message: "Missing course id!"));
    }
    course?.maLop = titleField;
    course?.ngayKhaiGiang = dateFormat.format(startDate);
    course?.giaoVienHienTai = seletedMentor?.fullName;
    course?.dinhHuong = isOrient ? "x" : "";
    course?.phatAm = isIPA ? "x" : "";
    course?.nghe = isListening ? "x" : "";
    course?.noi = isSpeaking ? "x" : "";
    course?.nguPhap = isGrammar ? "x" : "";
    course?.mau = "${selectedColor.value}";

    if (seletedMentor != null) {
      if (seletedMentor?.id != null) {
        seletedMentor?.tag = course?.maLop;
        course?.maGV = seletedMentor?.username;
        course?.giaoVienHienTai = seletedMentor?.fullName;
        BmeRepository.shared.updateBmeUser(seletedMentor!);
      }
    }
    return await BmeRepository.shared.updateBmeCourse(course!);
  }

  void loadMentors() async {
    await BmeRepository.shared.findUserByRole("MENTOR").then((value) {
      value.whenSuccess((success) {
        mentors = success;
      });
    });
  }
}

extension ColorExtension on Color {
  String toHex() {
    String hexAlpha = alpha.toRadixString(16).padLeft(2, '0');
    String hexRed = red.toRadixString(16).padLeft(2, '0');
    String hexGreen = green.toRadixString(16).padLeft(2, '0');
    String hexBlue = blue.toRadixString(16).padLeft(2, '0');
    return '#$hexAlpha$hexRed$hexGreen$hexBlue';
  }
}
