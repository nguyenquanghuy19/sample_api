import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future _initializeVideoPlayer;
  bool _isVideoPlaying = true;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    );
    _initializeVideoPlayer = _videoPlayerController.initialize();
    _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? GestureDetector(
                  onTap: () => _playPauseVideo(),
                  child: Stack(alignment: Alignment.center, children: [
                    AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    IconButton(
                      onPressed: () => _playPauseVideo(),
                      icon: SvgPicture.asset(
                        Images.iconPlaySlideShow,
                        color:
                            Colors.white.withOpacity(_isVideoPlaying ? 0 : 0.5),
                      ),
                      color: Colors.white,
                    ),
                    Positioned(
                      bottom: 65,
                      left: 0,
                      right: 0,
                      child: VideoProgressIndicator(
                        _videoPlayerController,
                        colors: VideoProgressColors(
                          playedColor: AppColor.primary.shade400,
                          backgroundColor: AppColor.neutrals.shade50,
                        ),
                        allowScrubbing: true,
                      ),
                    ),
                  ]),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    "assets/jsons/tiktok_loading.json",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
        },
      ),
    );
  }

  void _playPauseVideo() {
    _isVideoPlaying
        ? _videoPlayerController.pause()
        : _videoPlayerController.play();
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }
}
