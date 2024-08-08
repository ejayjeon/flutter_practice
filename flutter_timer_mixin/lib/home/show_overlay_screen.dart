import 'package:app/mixin/overlay_mixin.dart';
import 'package:flutter/material.dart';

class ShowOverlayScreen extends StatefulWidget {
  const ShowOverlayScreen({super.key});

  @override
  State<ShowOverlayScreen> createState() => _ShowOverlayScreenState();
}

class _ShowOverlayScreenState extends State<ShowOverlayScreen>
    with OverlayMixin, SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0), // 시작 위치 (화면 밖 오른쪽)
      end: Offset(1.5, 0.0), // 끝 위치 (화면 안)
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void showOverlay() {
    // super.showOverlay();
    overlayEntry = createOverlayEntry(buildWidget);
    Overlay.of(context).insert(overlayEntry!);
    _controller.forward();
  }

  @override
  void hideOverlay() {
    _controller.reverse().then((value) {
      overlayEntry?.remove();
      overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide In Overlay Example'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton.icon(
              onPressed: () {
                showOverlay();
                Future.delayed(Duration(seconds: 3), () {
                  hideOverlay();
                });
              },
              label: Text("아이콘")),
        ),
      ),
    );
  }

  Widget ColorContainer(Color? color) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        elevation: 4,
        color: color,
        child: Center(
          child: Text("Text"),
        ),
      ),
    );
  }

  @override
  // TODO: implement buildWidget
  Widget get buildWidget => ColorContainer(Colors.red);
}
