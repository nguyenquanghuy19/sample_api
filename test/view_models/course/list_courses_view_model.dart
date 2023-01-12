import 'package:elearning/core/data/models/course_mock_model.dart';
import 'package:elearning/core/mock_datas/mock_courses_data.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ListCoursesViewModel extends BaseViewModel {
  List<CoursesModel> courses = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool activeSearch = false;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await _getDataCourses();
  }

  Future<void> _getDataCourses() async {
    // TODO : Handle call API courses
    try {
      _isLoading = true;
      final res = MockDataCourses.courses;
      courses = res;
      _isLoading = false;
      notifyListeners();
    } on Exception {
      _showToastMessError();
      _isLoading = false;
    }
  }

  void _showToastMessError() {
    showToastError("An error has occurred");
  }
}
