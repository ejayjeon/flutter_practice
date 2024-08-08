import 'package:flutter/material.dart';

class EntranceLayout extends StatelessWidget {
  final Widget child;
  final Color? color;
  const EntranceLayout({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: color,
        body: SizedBox.expand(
          child: child,
        ),
      ),
    );
  }
}
