import 'package:app/extensions/context_extension.dart';
import 'package:app/mixin/overlay_mixin.dart';
import 'package:app/mixin/timer_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenApp extends StatefulWidget {
  const FullScreenApp({super.key});

  @override
  State<FullScreenApp> createState() => _FullScreenAppState();
}

class _FullScreenAppState extends State<FullScreenApp> with TimerMixin {
  @override
  @override
  void onTimerTick() {
    super.onTimerTick();
    setState(() {
      seconds--;
    });

    if (seconds <= 0) {
      stopTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    shouldMilliSec = true;

    setSeconds(60 * 5);
    startTimer();
    // createOverlayEntry(_buildWidget());

    /// 화면 세로고정 -> 세로로 풀스크린이 됨
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // /// 화면 가로고정 -> 가로로 풀스크린으로 돌아감
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    /// 화면 로테이션이 가능한 풀스크린 화면
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    /// 화면 로테이션이 불가능한 풀스크린 화면
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // 상단바만 보이기 (하단 네비게이션바 없애기)
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [
    //     SystemUiOverlay.top,
    //   ],
    // );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 풀스크린이다보니
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: RichText(
                text: TextSpan(
                  text:
                      '${formatTime(seconds).hour.toString().padLeft(2, '0')}:',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '${formatTime(seconds).minute.toString().padLeft(2, '0')}:',
                    ),
                    TextSpan(
                      text:
                          '${formatTime(seconds).second.toString().padLeft(2, '0')}.',
                    ),
                    TextSpan(
                      text: formatTime(seconds)
                          .millisecond
                          .toString()
                          .padLeft(3, '0'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (laps.isNotEmpty) ...[
            AnimatedContainer(
              duration: const Duration(
                seconds: 2,
              ),
              curve: Curves.linear,
              // transform:
              // transform: Matrix4.skewY(0.3),
              child: Container(
                color: Colors.white,
                width: 250,
                height: context.height,
                child: ListView(
                  children: List<Widget>.generate(
                    laps.length,
                    (index) => _childLapTime(
                      context,
                      time: formatTime(laps[index]),
                    ),
                  ),
                ),
                // height: ,
              ),
            )
          ],
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: clearLaps,
              child: const Icon(Icons.clear),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: lapTimer,
              child: const Icon(Icons.cut),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isPaused ? resumeTimer : pauseTimer,
        child: Icon(!isPaused ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  Widget _childLapTime(
    BuildContext context, {
    required Time time,
  }) {
    return ListTile(
      tileColor: Colors.black,
      dense: true,
      // title: Text(time),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(text: '${time.hour.toString().padLeft(2, '0')}:'),
            TextSpan(text: '${time.minute.toString().padLeft(2, '0')}:'),
            TextSpan(text: '${time.second.toString().padLeft(2, '0')}.'),
            TextSpan(
              text: time.millisecond.toString().padLeft(3, '0'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
