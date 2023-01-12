import 'package:elearning/core/data/models/slide_show_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideShowView extends StatefulWidget {
  final List<SlideShowModel> slideShows;

  const SlideShowView({
    Key? key,
    required this.slideShows,
  }) : super(key: key);

  @override
  State<SlideShowView> createState() => _SlideShowViewState();
}

class _SlideShowViewState extends State<SlideShowView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.slideShows.length > 1
                ? "${widget.slideShows.length} ${Strings.of(context)!.pages}"
                : "${widget.slideShows.length} ${Strings.of(context)!.page}",
            style: AppText.text16.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              final slideShow = widget.slideShows[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 25,
                ),
                color: index % 2 == 0
                    ? AppColor.neutrals.shade50
                    : Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage:
                          const AssetImage(Images.iconSlideShowRoadMap),
                    ),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slideShow.name,
                            style: AppText.text16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: widget.slideShows.length,
          ),
        ),
      ],
    );
  }
}
