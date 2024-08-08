import 'package:flutter/material.dart';

class AppBarTab extends StatefulWidget {
  const AppBarTab({super.key});

  @override
  State<AppBarTab> createState() => _AppBarTabState();
}

class _AppBarTabState extends State<AppBarTab>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Tab'),
        bottom: TabBar(
          controller: _controller,
          tabs: const <Tab>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
            Tab(icon: Icon(Icons.airplanemode_active_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Icon>[
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
          Icon(Icons.airplanemode_active_outlined),
        ],
      ),
    );
  }
}
