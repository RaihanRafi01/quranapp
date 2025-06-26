import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              top: 90,
                right: 20,
                left: 20,
                child: Image.asset('assets/images/lessons/video_placeholder.png')),
            // Arabic text overlay
            Positioned(
              left: 20,
              right: 20,
              bottom: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'لا يمكن أن تكون مستقلة أبدا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'وجعت أن المقصود أن من الطيور ما\nهو جائز مثل عن القصد دائما',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لم يدع لنا نعمل وقتما نشاء',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'وجعت أن المقصود أن من الطيور ما\nهو جائز مثل عن القصد دائما',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'وهي الخطوط الجوية',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لا يمكن أن تكون مستقلة أبدا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تحتاج إلى الخير من مستقبلينا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 18,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),

            // Top controls (visible when _showControls is true)
            if (_showControls)
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // More options
                      },
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),

            // Bottom controls
            if (_showControls)
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    // Progress bar
                    Row(
                      children: [
                        Text(
                          _formatTime(_currentPosition),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.green,
                              inactiveTrackColor: Colors.white30,
                              thumbColor: Colors.green,
                              trackHeight: 2,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.replay_5_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap: _seekForward,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.forward_5_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18,),
                    // Bottom action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: _changePlaybackSpeed,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '${_playbackSpeed}x',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // repeat
                          },
                          child: SvgPicture.asset('assets/images/lessons/repeate_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Captions/subtitles
                          },
                          child: SvgPicture.asset('assets/images/lessons/video_video_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Bookmark
                          },
                          child: SvgPicture.asset('assets/images/lessons/trans_icon.svg'),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 28,
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