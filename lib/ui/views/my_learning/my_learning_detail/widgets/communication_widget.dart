import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/comment_tree_custom_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/my_learning_communication_view_model.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CommunicationWidget extends BaseView {
  const CommunicationWidget({
    Key? key,
  }) : super(key: key);

  @override
  CommunicationWidgetState createState() => CommunicationWidgetState();
}

class CommunicationWidgetState extends BaseViewState<CommunicationWidget,
    MyLearningCommunicationViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MyLearningCommunicationViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<MyLearningCommunicationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                bottomSheet: _buildBottomSheetComment(context),
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Strings.of(context)!.teacherCommunication,
                      style:
                          AppText.text18.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 5.h),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.contentPaddingHorizontal,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Selector<MyLearningCommunicationViewModel,
                                CommentModel>(
                              selector: (_, viewModel) =>
                                  viewModel.commentModel,
                              builder: (_, commentModel, __) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) =>
                                      CommentTreeCustomWidget(
                                    commentModel: commentModel,
                                    callBack: (value, autoFocusValue) {
                                      viewModel.getNameReply(
                                        value,
                                        autoFocusValue,
                                      );
                                    },
                                  ),
                                  itemCount: 3,
                                );
                              },
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Container _buildBottomSheetComment(BuildContext context) {
    return Container(
      color: AppColor.neutrals.shade50,
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 10.h,
      ),
      height: 110.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<MyLearningCommunicationViewModel, String?>(
            selector: (_, viewModel) => viewModel.replyTo,
            builder: (_, replyTo, __) {
              return replyTo != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "${Strings.of(context)!.replyTo} ",
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO: handle when clear spec
                                },
                              text: "@$replyTo",
                              style: AppText.text14.copyWith(
                                color: AppColor.supporting.shade600,
                              ),
                            ),
                          ]),
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.getNameReply(null, false);
                            FocusScope.of(
                              _scaffoldKey.currentContext ?? context,
                            ).unfocus();
                          },
                          child: Text(Strings.of(context)!.cancel),
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(children: [
            Expanded(
              child: Selector<MyLearningCommunicationViewModel, String?>(
                selector: (_, viewModel) => viewModel.replyTo,
                builder: (_, replyTo, __) {
                  return Selector<MyLearningCommunicationViewModel, bool>(
                    selector: (_, viewModel) => viewModel.autoFocus,
                    builder: (_, autoFocus, __) {
                      return AppInput(
                        focusNode: viewModel.focusNode,
                        autoFocus: autoFocus,
                        controller: viewModel.replyToTextField,
                        prefixIcon: Tab(
                          icon: SvgPicture.asset(
                            Images.iconMessageComment,
                          ),
                        ),
                        fillColor: Colors.white,
                        hintText: Strings.of(context)!.hintTextComment,
                        radius: 24,
                        textInputAction: TextInputAction.done,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(width: 16.w),
            SvgPicture.asset(Images.iconAddComment),
          ]),
        ],
      ),
    );
  }
}
