import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/material.dart';

// Fade in images with a placeholder
class ExpandableFABWithFlowView extends StatelessWidget {
  const ExpandableFABWithFlowView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      appTitle: 'ExpandableFAB With Flow View',
      body: ExpandableFABWithFAB(),
    );
  }
}

class ExpandableFABWithFAB extends StatefulWidget {
  const ExpandableFABWithFAB({super.key});

  @override
  State<ExpandableFABWithFAB> createState() => _ExpandableFABWithFABState();
}

class _ExpandableFABWithFABState extends State<ExpandableFABWithFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuAnimationController;
  IconData lastTappedIcon = Icons.menu;

  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu,
  ];

  void _updateMenuIcon(IconData icon) {
    if (icon != Icons.menu) {
      setState(() {
        lastTappedIcon = icon;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _menuAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _menuAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(menuAnimation: _menuAnimationController),
      children: menuItems.map<Widget>((icon) => flowMenuItem(icon)).toList(),
    );
  }

  Widget flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / menuItems.length;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: RawMaterialButton(
        fillColor: lastTappedIcon == icon ? Colors.purple[400] : Colors.grey,
        splashColor: Colors.purple[700],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(
          Size(buttonDiameter, buttonDiameter),
        ),
        onPressed: () {
          _updateMenuIcon(icon);
          _menuAnimationController.status == AnimationStatus.completed
              ? _menuAnimationController.reverse()
              : _menuAnimationController.forward();
        },
        child: Icon(icon, color: Colors.white, size: 45.0),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> menuAnimation;
  FlowMenuDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    double dy = 90.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
            dx * menuAnimation.value, dx * menuAnimation.value, 0.0),
      );
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    // 기존의 것과 다르다면 다시 리페인트하라
    return menuAnimation != oldDelegate.menuAnimation;
  }
}
