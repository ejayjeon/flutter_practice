import 'package:flutter/material.dart';

class SlideInOverlay extends StatefulWidget {
  @override
  _SlideInOverlayState createState() => _SlideInOverlayState();
}

class _SlideInOverlayState extends State<SlideInOverlay>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
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
      begin: Offset(1.5, 0.0), // 시작 위치 (화면 밖 오른쪽)
      end: Offset(0.0, 0.0), // 끝 위치 (화면 안)
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  void _hideOverlay() {
    _controller.reverse().then((value) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        right: 0,
        width: 200,
        height: 50,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            elevation: 4.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Hello!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide In Overlay Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showOverlay();
            Future.delayed(Duration(seconds: 3), () {
              _hideOverlay();
            });
          },
          child: Text('Show Overlay'),
        ),
      ),
    );
  }
}
