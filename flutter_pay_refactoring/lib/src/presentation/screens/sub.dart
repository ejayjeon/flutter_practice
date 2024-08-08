import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/layouts/sub_layout.dart';
import 'package:sketch_pay/src/shared/widgets/structure/sub_top_bar.dart';

class Sub extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const Sub({
    super.key,
    required this.navigationShell,
  });

  @override
  State<Sub> createState() => _SubState();
}

class _SubState extends State<Sub> {
  @override
  Widget build(BuildContext context) {
    return SubLayout(
      appbar: SubTopBar(
        title: context.currentPath.toString().replaceAll('/', ''),
        onLeadingPressed: () =>
            context.canPop() ? context.pop() : context.go(HomeRoute.path),
      ),
      child: widget.navigationShell,
    );
  }
}
