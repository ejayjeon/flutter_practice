import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final String? appTitle;
  final Widget body;
  final Widget? fab;
  final Color? backgroundColor;
  const AppLayout({
    super.key,
    this.appTitle,
    required this.body,
    this.fab,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle ?? '-'),
      ),
      backgroundColor: backgroundColor,
      body: body,
      floatingActionButton: fab,
    );
  }
}
