import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentTreeCustomWidget extends StatefulWidget {
  final CommentModel commentModel;
  final double radiusAvatar;
  final Color? colorLine;
  final Function(String value, bool autoFocusValue)? callBack;

  const CommentTreeCustomWidget({
    Key? key,
    required this.commentModel,
    this.radiusAvatar = 20,
    this.colorLine,
    this.callBack,
  }) : super(key: key);

  @override
  State<CommentTreeCustomWidget> createState() =>
      _CommentTreeCustomWidgetState();
}

class _CommentTreeCustomWidgetState extends State<CommentTreeCustomWidget> {
  bool isShowAllComment = false;

  @override
  Widget build(BuildContext context) {
    List<DataCommentModel> listTerm = [widget.commentModel.data[0]];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: CommentTreeWidget<DataCommentModel, DataCommentModel>(
        DataCommentModel(
          displayName: "Giảng pro 123",
          content: "Làm chủ flutter trong 24h",
          createdAt: DateTime.parse('2012-02-27 13:27:00'),
        ),
        isShowAllComment ? widget.commentModel.data : listTerm,
        treeThemeData: TreeThemeData(
          lineColor: widget.colorLine ?? AppColor.neutrals.shade100,
          lineWidth: 2,
        ),
        avatarRoot: (context, value) => PreferredSize(
          preferredSize: Size.fromRadius(widget.radiusAvatar),
          child: AvatarWidget(
            radius: widget.radiusAvatar,
          ),
        ),
        avatarChild: (context, value) => isShowAllComment
            ? PreferredSize(
                preferredSize: Size.fromRadius(widget.radiusAvatar),
                child: AvatarWidget(
                  radius: widget.radiusAvatar,
                ),
              )
            : const PreferredSize(
                preferredSize: Size.fromRadius(0),
                child: AvatarWidget(
                  radius: 0,
                ),
              ),
        contentRoot: (context, value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColor.neutrals.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          value.displayName != null
                              ? value.displayName ?? ''
                              : value.userName ?? '',
                          style: AppText.text16.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      value.content ?? '',
                      style: AppText.text14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: AppText.text14.copyWith(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w700,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 4.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.callBack != null) {
                            widget.callBack!(
                              value.displayName != null
                                  ? value.displayName ?? ''
                                  : value.userName ?? '',
                              true,
                            );
                          }
                        },
                        child: Text(Strings.of(context)!.reply),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          value.dateFormat(context) ?? '',
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade300,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        contentChild: (context, value) {
          return isShowAllComment
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.neutrals.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                value.displayName != null
                                    ? value.displayName ?? ''
                                    : value.userName ?? '',
                                style: AppText.text16.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            value.content ?? '',
                            style: AppText.text14.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                      style: AppText.text14.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w700,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 4.w),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.callBack != null) {
                                  widget.callBack!(
                                    value.displayName != null
                                        ? value.displayName ?? ''
                                        : value.userName ?? '',
                                    true,
                                  );
                                }
                              },
                              child: Text(Strings.of(context)!.reply),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Text(
                                value.dateFormat(context) ?? '',
                                style: AppText.text14.copyWith(
                                  color: AppColor.neutrals.shade300,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isShowAllComment = !isShowAllComment;
                    });
                  },
                  child: Row(
                    children: [
                      const AvatarWidget(
                        radius: 10,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        value.displayName != null
                            ? value.displayName ?? ''
                            : value.userName ?? '',
                        style: AppText.text14.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text(
                          value.content ?? '',
                          maxLines: 1,
                          style: AppText.text14.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
