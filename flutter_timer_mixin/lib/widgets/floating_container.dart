import 'package:flutter/material.dart';

class FloatingContainer extends StatefulWidget {
  final bool isShown;
  final Widget? child;
  const FloatingContainer({
    super.key,
    this.isShown = false,
    this.child,
  });

  @override
  State<FloatingContainer> createState() => _FloatingContainerState();
}

class _FloatingContainerState extends State<FloatingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      // color: Colors.black.withOpacity(0.5),
      child: widget.child,
    );
  }
}
