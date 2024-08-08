import 'dart:math';

import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';

class ChangeWidget extends StatefulWidget {
  const ChangeWidget({super.key});

  @override
  State<ChangeWidget> createState() => _ChangeWidgetState();
}

class _ChangeWidgetState extends State<ChangeWidget> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: 'Change Widget',
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      fab: FloatingActionButton(
        onPressed: () {
          setState(() {
            final random = Random();
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            _color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );
            _borderRadius = BorderRadius.circular(
              random.nextInt(100).toDouble(),
            );
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
