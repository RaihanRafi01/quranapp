import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:quranapp/common/customFont.dart';
import '../../../../common/appColors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  bool _showControls = true;
  double _currentPosition = 0.0;
  double _totalDuration = 100.0; // Mock duration
  double _playbackSpeed = 1;

  @override
  void initState() {
    super.initState();
    // Hide status bar for full screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _seekBackward() {
    setState(() {
      _currentPosition = (_currentPosition - 10).clamp(0.0, _totalDuration);
    });
  }

  void _seekForward() {
    setState(() {
      _currentPosition = (_currentPosition + 10).clamp(0.0, _totalDuration);
    });
  }

  void _changePlaybackSpeed() {
    setState(() {
      if (_playbackSpeed == 1.0) {
        _playbackSpeed = 1.25;
      } else if (_playbackSpeed == 1.25) {
        _playbackSpeed = 1.5;
      } else if (_playbackSpeed == 1.5) {
        _playbackSpeed = 2.0;
      } else {
        _playbackSpeed = 1.0;
      }
    });
  }

  String _formatTime(double seconds) {
    int minutes = (seconds / 60).floor();
    int secs = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            Positioned(
              top: 90.h,
              right: 20.w,
              left: 20.w,
              child: Image.asset('assets/images/lessons/video_placeholder.png'),
            ),
            // Arabic text overlay
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'لا يمكن أن تكون مستقلة أبدا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'وجعت أن المقصود أن من الطيور ما\nهو جائز مثل عن القصد دائما',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'لم يدع لنا نعمل وقتما نشاء',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'وجعت أن المقصود أن من الطيور ما\nهو جائز مثل عن القصد دائما',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'وهي الخطوط الجوية',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'لا يمكن أن تكون مستقلة أبدا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'تحتاج إلى الخير من مستقبلينا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18.sp,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),

            // Top controls (visible when _showControls is true)
            if (_showControls)
              Positioned(
                top: 50.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // More options
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ],
                ),
              ),

            // Bottom controls
            if (_showControls)
              Positioned(
                bottom: 20.h,
                left: 16.w,
                right: 16.w,
                child: Column(
                  children: [
                    // Progress bar
                    Row(
                      children: [
                        Text(
                          _formatTime(_currentPosition),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.white30,
                              thumbColor: Colors.green,
                              trackHeight: 2.h,
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 6.r,
                              ),
                            ),
                            child: Slider(
                              value: _currentPosition,
                              min: 0.0,
                              max: _totalDuration,
                              onChanged: (double value) {
                                setState(() {
                                  _currentPosition = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Text(
                          _formatTime(_totalDuration),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: _seekBackward,
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Icon(
                                Icons.replay_5_rounded,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              child: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 32.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                          GestureDetector(
                            onTap: _seekForward,
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Icon(
                                Icons.forward_5_rounded,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    // Bottom action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _changePlaybackSpeed,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              '${_playbackSpeed}x',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // repeat
                          },
                          child: SvgPicture.asset(
                              'assets/images/lessons/repeate_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Captions/subtitles
                          },
                          child: SvgPicture.asset(
                              'assets/images/lessons/video_video_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Bookmark
                          },
                          child: SvgPicture.asset(
                              'assets/images/lessons/trans_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
