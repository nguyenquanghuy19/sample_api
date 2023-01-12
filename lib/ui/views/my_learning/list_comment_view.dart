import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/comment_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListCommentView extends StatefulWidget {
  final List<CommentModel> comments;

  const ListCommentView({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  State<ListCommentView> createState() => _ListCommentViewState();
}

class _ListCommentViewState extends State<ListCommentView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.comments.length > 1
                ? "${widget.comments.length} ${Strings.of(context)!.comments}"
                : "${widget.comments.length} ${Strings.of(context)!.aComment}",
            style: AppText.text16.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _buildListComment(),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: Constants.contentPaddingHorizontal,
            right: Constants.contentPaddingHorizontal,
            top: 8,
          ),
          child: Row(children: [
            Expanded(
              child: AppInput(
                prefixIcon: Tab(
                  icon: SvgPicture.asset(Images.iconMessageComment),
                ),
                fillColor: Colors.white,
                hintText: Strings.of(context)!.hintTextComment,
                radius: 24,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(width: 16.w),
            SvgPicture.asset(Images.iconAddComment),
          ]),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildListComment() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          final comment = widget.comments[index];

          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 25,
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage: const AssetImage(Images.imageAccountType),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.name,
                        style: AppText.text16,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        comment.description,
                        style: AppText.text14.copyWith(
                          color: AppColor.neutrals.shade300,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        comment.createDate,
                        style: AppText.text14.copyWith(
                          color: AppColor.supporting.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.comments.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1.h,
            color: AppColor.neutrals.shade200,
            height: 0,
            indent: 20.w,
            endIndent: 20.w,
          );
        },
      ),
    );
  }
}
