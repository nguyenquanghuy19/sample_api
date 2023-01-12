import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/time_ago_utils.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/widgets/slide_item_custom/action_pane_motions.dart';
import 'package:elearning/ui/widgets/slide_item_custom/actions.dart';
import 'package:elearning/ui/widgets/slide_item_custom/slide_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notification;
  final Function() onDelete;
  final Function() onMarkRead;

  const NotificationWidget({
    Key? key,
    required this.onMarkRead,
    required this.onDelete,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return SlideCustomView(
      key: ValueKey(widget.notification.id ?? ""),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio:
            widget.notification.status != Constants.readStatus ? 0.4 : 0.25,
        children: [
          SlideAction(
            autoClose: true,
            backgroundColor: AppColor.redApp.shade400,
            foregroundColor: Colors.white,
            icon: SvgPicture.asset(
              Images.iconRemove,
              width: 12.w,
              height: 12.h,
            ),
            label: Strings.of(context)!.delete,
            textStyle: AppText.text12.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            onPressed: (context) {
              DialogWidget().showBasicDialog(
                context: context,
                title: Strings.of(context)!.titleConfirmDeleteNotification,
                content: Strings.of(context)!.contentConfirmDeleteNotification,
                positiveText: Strings.of(context)!.accept,
                negativeText: Strings.of(context)!.cancel,
                positiveOnClickListener: () => widget.onDelete(),
                negativeOnClickListener: () => Navigator.of(context).pop(),
              );
            },
          ),
          if (widget.notification.status != Constants.readStatus)
            SlideAction(
              autoClose: true,
              backgroundColor: AppColor.greenAccent.shade300,
              foregroundColor: Colors.white,
              icon: SvgPicture.asset(
                Images.iconTick,
                width: 12.w,
                height: 12.h,
              ),
              label: Strings.of(context)!.readTick,
              textStyle: AppText.text12.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onPressed: (context) {
                widget.onMarkRead();
              },
            ),
        ],
      ),
      child: _buildItemNotifications(context),
    );
  }

  Widget _buildItemNotifications(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DialogWidget().showBasicDialog(
          context: context,
          title: widget.notification.title,
          subTitle: TimeAgoUtils.dateFormat(
                widget.notification.createdAt,
                context,
              ) ??
              "",
          content: widget.notification.content ?? '',
          positiveText: Strings.of(context)!.gotIt,
          negativeText: "",
          positiveOnClickListener: () {
            widget.onMarkRead();
          },
        );
      },
      child: Container(
        color: widget.notification.status == Constants.readStatus
            ? Colors.white
            : AppColor.neutrals.shade50,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: Constants.contentPaddingHorizontal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.w,
              child: _buildIconType(widget.notification.type),
            ),
            const SizedBox(width: Constants.contentPaddingHorizontal),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.notification.title ?? "",
                    style: AppText.text16.copyWith(
                      color: AppColor.neutrals.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    widget.notification.content ?? "",
                    style: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade300),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    TimeAgoUtils.dateFormat(
                          widget.notification.createdAt,
                          context,
                        ) ??
                        "",
                    style: AppText.text14
                        .copyWith(color: AppColor.supporting.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconType(String? type) {
    switch (type) {
      case Constants.typeCourse:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconCourseType),
          ),
        );
      case Constants.typeAccount:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconAccountType),
          ),
        );
      case Constants.typeClassRoom:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconMyClassRoomType),
          ),
        );
      case Constants.flashcard:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconFlashCardType),
          ),
        );
      case Constants.typeQuiz:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconQuizType),
          ),
        );
      case Constants.typeSlideShow:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconSlideShowType),
          ),
        );
      default:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(Images.iconCourseType),
          ),
        );
    }
  }
}
