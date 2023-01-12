import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/widgets/shimmer_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemCourseWidget extends StatelessWidget {
  const ItemCourseWidget({
    Key? key,
    required this.course,
    required this.onTap,
    required this.isSignIn,
  }) : super(key: key);

  final CourseModel course;
  final Function() onTap;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        // color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (115.w + 115.h) / 2,
                height: (115.w + 115.h) / 2,
                child: course.isLoadingImage
                    ? const ShimmerWidget(
                        height: double.infinity,
                        width: double.infinity,
                        shapeBorder: RoundedRectangleBorder(),
                      )
                    : (course.image != null && course.isSvg
                        ? SvgPicture.memory(
                            fit: BoxFit.cover,
                            course.image!,
                          )
                        : course.image != null
                            ? Image.memory(
                                fit: BoxFit.cover,
                                course.image!,
                              )
                            : SvgPicture.asset(
                                Images.defaultCourses,
                                fit: BoxFit.cover,
                              )),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: (115.w + 115.h) / 2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.name!,
                              style: AppText.text18.copyWith(
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              "${course.dateFormat}",
                              style: AppText.text14.copyWith(
                                color: AppColor.neutrals.shade300,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.yellow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  course.status!,
                                  style: AppText.text14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (course.metaDescription != null &&
                                course.metaDescription!.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 6.h,
                                ),
                                child: Text(
                                  course.metaDescription!,
                                  style: AppText.text14,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              Strings.of(context)!.joinNow,
                              style: AppText.text14.copyWith(
                                color: AppColor.blueAccent,
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              Images.iconArrowRight,
                              color: AppColor.blueAccent,
                              width: 10,
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
