import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class MyLearningCommunicationViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CommentModel commentModel = CommentModel();

  String? replyTo;

  bool autoFocus = false;

  TextEditingController replyToTextField = TextEditingController(text: '');
  FocusNode focusNode = FocusNode();

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    LogUtils.d("[MY_LEARNING_COMMUNICATION_VIEW_MODEL] => INIT");
    await getCommentTeacher();
  }

  Future<void> getCommentTeacher() async {
    try {
      _isLoading = true;
      final res = await _myLearningRepository.getCommentTeacher();
      commentModel = res;
      _isLoading = false;
    } on Exception {
      _isLoading = false;
      rethrow;
    }
    notifyListeners();
  }

  void getNameReply(String? value, bool autoFocusValue) {
    replyTo = value;
    replyToTextField.text = value ?? '';
    autoFocus = autoFocusValue;
    FocusScope.of(context).requestFocus(focusNode);
    replyToTextField.selection = TextSelection.fromPosition(
      TextPosition(offset: replyToTextField.text.length),
    );
    notifyListeners();
  }
}
