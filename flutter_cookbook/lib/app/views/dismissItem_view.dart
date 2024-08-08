import 'package:cookbook/app/const/app_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DismissItemView extends StatelessWidget {
  const DismissItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      appTitle: 'Dismiss Item',
      body: DismissItem(),
    );
  }
}

class DismissItem extends StatefulWidget {
  const DismissItem({super.key});

  @override
  State<DismissItem> createState() => _DismissItemState();
}

class _DismissItemState extends State<DismissItem> {
  final items = List<String>.generate(15, (index) => '아이템 ${index + 1}번');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        // 1. 모든 Dismissable Item은 키를 가지고 있어야 함
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              items.removeAt(index);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$item 이 삭제되었습니다'),
              ),
            );
          },
          background: Container(color: const Color.fromARGB(255, 139, 9, 0)),
          child: ListTile(
            title: Text(
              item,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
