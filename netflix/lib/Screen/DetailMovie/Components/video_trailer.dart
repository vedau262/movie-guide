import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netflix/Config/Result.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../DetailMovieBloc.dart';

class VideoTrailer extends StatefulWidget {
  String videoLink = "";
  VideoTrailer(this.videoLink);

  @override
  _VideoTrailerState createState() => _VideoTrailerState(this.videoLink);
}

class _VideoTrailerState extends State<VideoTrailer> {
  late VideoPlayerController _controller;
  Future<void>? _initializeVideoPlayerFuture;
  late int _playBackTime;
  String videoLink = "";

  //The values that are passed when changing quality
  Duration newCurrentPosition = Duration(milliseconds: 0);

  _VideoTrailerState(this.videoLink);


  @override
  void initState() {
    super.initState();
    /*_controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, evenfore the play button has been pressed.
        setState(() {});
      });*/

    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.play();
    });

  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DetailMovieBloc>(context);
    // print("build VideoApp: ${bloc.trailerVideoId.stream.value}");
    bloc.trailerVideoId.listen((value) {
      if (value is SuccessState<String> && value.value != this.videoLink) {
        this.videoLink = value.value;
        _getValuesAndPlay('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
      }
    });

    if(_controller.value.isInitialized){
      return Container(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: VideoProgressIndicator(_controller, allowScrubbing: true),
              ),
              // Container(
              //   child: _ControlsOverlay(controller: _controller),
              // ),
              // ClosedCaption(text: _controller.value.caption.text),
              // _ControlsOverlay(controller: _controller),
              Container(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  )
              )
            ],
          )
      );
    } else return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Future<bool> _clearPrevious() async {
    await _controller.pause();
    return true;
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.network(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }

  void _getValuesAndPlay(String videoPath) {
    // newCurrentPosition = (_controller!=null ? _controller.value.position : Duration(milliseconds: 0));
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}