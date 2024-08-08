import 'package:flutter/material.dart';

mixin OverlayMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? overlayEntry;

  /// [Getter]
  // OverlayEntry? get overlayEntry => _overlayEntry;
  Widget get buildWidget;

  /// [Method]

  OverlayEntry createOverlayEntry(Widget buildWidget) {
    return OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 100,
        left: 0,
        width: 200,
        height: 50,
        // child: SlideTransition(
        //   position: _offsetAnimation,
        //   child: Material(
        //     elevation: 4.0,
        //     color: Colors.blue,
        //     child: Center(
        //       child: Text(
        //         'Hello!',
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //     ),
        //   ),
        // ),
        child: buildWidget,
      ),
    );
  }

  // void toggleOverlay() {
  //   if (_overlayEntry == null) {
  //     showOverlay();
  //   } else {
  //     hideOverlay();
  //   }
  // }

  void showOverlay() {
    overlayEntry = createOverlayEntry(buildWidget);
    Overlay.of(context).insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
