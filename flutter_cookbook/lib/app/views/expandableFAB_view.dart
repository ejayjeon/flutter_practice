import 'package:cookbook/app/const/app_dialog.dart';
import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpandableFABView extends StatelessWidget {
  const ExpandableFABView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      appTitle: 'Expandaable FAB',
      body: ListView.builder(
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),
      fab: ExpandableFAB(
        distance: 100,
        children: [
          ActionButton(
            onPressed: () => appDialog(context, 'Book'),
            icon: const Icon(
              Icons.menu_book_sharp,
            ),
          ),
          ActionButton(
            onPressed: () => appDialog(context, 'Link'),
            icon: const Icon(
              Icons.insert_link_sharp,
            ),
          ),
          ActionButton(
            onPressed: () => appDialog(context, 'Restore'),
            icon: const Icon(
              Icons.restore_from_trash,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableFAB extends StatefulWidget {
  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  const ExpandableFAB({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initialOpen ?? false;
    _controller = AnimationController(
      vsync: this,
      value: _isOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(size: 72),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(icon: Icons.create),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab({required double size}) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          child: InkWell(
            onTap: _toggle,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab({required IconData icon}) {
    // ??
    return IgnorePointer(
      ignoring: _isOpen,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _isOpen ? 0.7 : 1.0,
          _isOpen ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _isOpen ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1); // 90도
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  const _ExpandingActionButton({
    super.key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
