import 'package:elearning/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarWidget extends StatefulWidget {
  final Uint8List? avatar;
  final bool isSvg;
  final double? radius;
  final bool? isLoading;

  const AvatarWidget({
    Key? key,
    this.avatar,
    this.radius,
    this.isSvg = false,
    this.isLoading,
  }) : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  Uint8List? avatar;
  bool isSvg = false;

  @override
  void initState() {
    avatar = widget.avatar;
    isSvg = widget.isSvg;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AvatarWidget oldWidget) {
    avatar = widget.avatar;
    isSvg = widget.isSvg;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: avatar != null && !isSvg ? MemoryImage(avatar!) : null,
      radius: widget.radius ?? 64.r,
      child: widget.isLoading != null && widget.isLoading!
          ? ShimmerWidget(
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )
          : childAvatar(),
    );
  }

  Widget childAvatar() {
    if (avatar != null && isSvg) {
      return SvgPicture.memory(avatar!);
    }
    if (avatar != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.memory(
          avatar!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SvgPicture.asset("assets/images/avatar_default.svg"),
    );
  }
}
