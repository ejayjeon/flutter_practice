// ignore: file_names
import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DragWidget extends StatelessWidget {
  const DragWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      appTitle: 'Drag Widget',
      body: _DragCard(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}

class _DragCard extends StatefulWidget {
  final Widget child;
  const _DragCard({
    super.key,
    required this.child,
  });

  @override
  State<_DragCard> createState() => __DragCardState();
}

// Step 1: SingleTickerProviderStateMixin 추가 / AnimationController init
class __DragCardState extends State<_DragCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Step 2: Using Gestures
  Alignment _dragAlignment = Alignment.center;
  // Step 3: Animate the Widget
  late Animation<Alignment> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // 컨트롤러에 리스너 추가
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  // 드래그에 애니메이션 추가
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      // a Tween that interpolates between the point the widget was dragged to,
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    // _controller.reset();
    // _controller.forward();
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance; // 속도

    const spring = SpringDescription(mass: 50, stiffness: 1, damping: 1);
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        // 제스처를 취할 때마다, 즉 위젯의 위치가 변할 때마다
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
