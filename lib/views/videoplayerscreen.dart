import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  String filename;
  VideoPlayerScreen({Key key, @required this.filename}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      "http://beerabbit.kr/data/${widget.filename}",
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
            // VideoPlayer의 종횡비를 제한하세요.
            return InkWell (
                onTap: () {
                  setState(() {
                  // 영상이 재생 중이라면, 일시 중지 시킵니다.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                    _controller.play();
                  }
                  });
                },
                child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            // 만약 VideoPlayerController가 여전히 초기화 중이라면, 
            // 로딩 스피너를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      );
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
          // 보여집니다.
          setState(() {
            // 영상이 재생 중이라면, 일시 중지 시킵니다.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // 만약 영상이 일시 중지 상태였다면, 재생합니다.
              _controller.play();
            }
          });
        },
        // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // 이 마지막 콤마는 build 메서드에 자동 서식이 잘 적용될 수 있도록 도와줍니다.
    );
    */
  }
}