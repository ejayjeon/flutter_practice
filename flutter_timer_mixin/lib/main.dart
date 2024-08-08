import 'package:app/home/draggable_scrollsheet.dart';
import 'package:app/home/full_screen_app.dart';
import 'package:app/home/show_overlay_screen.dart';
import 'package:app/home/slide_in_overlay.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _navigaterButton(context, FullScreenApp(), '타이머 시작'),
          _navigaterButton(context, ShowOverlayScreen(), 'Overlay 띄우기'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink[200],
        shape: const CircularNotchedRectangle(),
        notchMargin: 0,
        // child: Container(
        //   height: 30.0,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          // _count++;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DraggableScrollableSheetExampleApp(),
          ));
        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  Widget _navigaterButton(BuildContext context, Widget page, String name) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      ),
      child: Text(
        name,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
