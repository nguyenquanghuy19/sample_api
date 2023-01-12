import 'package:audioplayers/audioplayers.dart';
import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/widgets/slide_item_custom/term_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flip.dart';

class TermWidget extends StatefulWidget {
  final TermModel termModel;
  final FlipController flipController;
  final TermController swiperController;
  final bool swapContent;

  const TermWidget({
    Key? key,
    required this.termModel,
    required this.flipController,
    required this.swiperController,
    this.swapContent = false,
  }) : super(key: key);

  @override
  State<TermWidget> createState() => _TermWidgetState();
}

class _TermWidgetState extends State<TermWidget> {
  TermOutlineMode _mode = TermOutlineMode.none;

  final audioPlayer = AudioPlayer();

  bool _swapContent = false;

  @override
  void initState() {
    _swapContent = widget.swapContent;
    _mode = widget.swiperController.mode;
    widget.swiperController.addListener(_listenChangeStateController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TermWidget oldWidget) {
    _swapContent = widget.swapContent;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _swapContent = widget.swapContent;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.swiperController.removeListener(_listenChangeStateController);
    audioPlayer.dispose();

    super.dispose();
  }

  void _listenChangeStateController() {
    setState(() {
      _mode = widget.swiperController.mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flip(
      flipDirection: Axis.horizontal,
      firstChild: _buildContentTerm(
        _swapContent ? widget.termModel.definition : widget.termModel.term,
        widget.termModel.image,
        true,
      ),
      secondChild: _buildContentTerm(
        _swapContent ? widget.termModel.term : widget.termModel.definition,
        widget.termModel.image,
        false,
      ),
      controller: widget.flipController,
    );
  }

  Widget _buildContentTerm(String? content, String? image, bool isFront) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: _getColorOfBorderWithModeCurrent(),
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: InkWell(
              onTap: () {
                audioPlayer.play(
                  UrlSource(
                    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                  ),
                );
              },
              child: isFront
                  ? const Icon(Icons.volume_up)
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.termModel.isRemember = !widget.termModel.isRemember;
                });
              },
              child: widget.termModel.isRemember
                  ? Icon(
                      Icons.star,
                      color: AppColor.primary.shade400,
                    )
                  : const Icon(Icons.star_border),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (isFront && image != null) ...{
                //   Image.memory(
                //     image as Uint8List,
                //     fit: BoxFit.cover,
                //     width: MediaQuery.of(context).size.height * 0.3,
                //     height: MediaQuery.of(context).size.height * 0.3,
                //   ),
                // },
                SizedBox(height: 15.h),
                Text(
                  content ?? "",
                  style: AppText.text24.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorOfBorderWithModeCurrent() {
    switch (_mode) {
      case TermOutlineMode.left:
        return Colors.red;
      case TermOutlineMode.right:
        return Colors.green;
      case TermOutlineMode.none:
        return Colors.transparent;
    }
  }
}

class TermController extends ValueNotifier<TermOutlineMode> {
  TermController({
    TermOutlineMode mode = TermOutlineMode.none,
  }) : super(mode);

  TermOutlineMode get mode => value;

  set mode(v) {
    value = v;
    notifyListeners();
  }
}
