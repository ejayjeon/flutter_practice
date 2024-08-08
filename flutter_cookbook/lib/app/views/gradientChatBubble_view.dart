import 'package:cookbook/app/const/app_layout.dart';
import 'package:cookbook/app/model/message.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

class GradientChatBubbleView extends StatelessWidget {
  const GradientChatBubbleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      appTitle: 'GradientChatBubble',
      backgroundColor: Color.fromARGB(0, 37, 37, 37),
      body: GradientChatBubble(),
    );
  }
}

class GradientChatBubble extends StatefulWidget {
  const GradientChatBubble({super.key});

  @override
  State<GradientChatBubble> createState() => _GradientChatBubbleState();
}

class _GradientChatBubbleState extends State<GradientChatBubble> {
  late final List<Message> data;

  @override
  void initState() {
    super.initState();
    data = MessageGenerator.generate(60, 1324);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      reverse: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final message = data[index];
        return MessageBubble(
          message: message,
          child: Text(message.text),
        );
      },
    );
  }
}

@immutable
class MessageBubble extends StatelessWidget {
  final Message message;
  final Widget child;
  const MessageBubble({
    super.key,
    required this.message,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        message.isMine ? Alignment.topRight : Alignment.topLeft;
    // 부모의 사이즈 비율에 맞도록 자식의 크기를 지정한다
    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8, // 부모의 80%
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 20.0,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: [
                if (message.isMine) ...const [
                  Color.fromARGB(255, 87, 244, 60),
                  Color.fromARGB(255, 31, 199, 255),
                ] else ...const [
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ],
              ],
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  final Widget? child;
  final List<Color> colors;
  const BubbleBackground({
    super.key,
    required this.colors,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        colors: colors,
        context: context,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  final ScrollableState _scrollable;
  final BuildContext _context;
  final List<Color> _colors;

// 초기화할 때, 외부에서 받아온 값을 필드에 세팅해 줌
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext context,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _context = context,
        _colors = colors,
        super(repaint: scrollable.position);
  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _context.findRenderObject() as RenderBox;
    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._context != _context ||
        oldDelegate._colors != _colors;
  }
}

// @immutable
// class MessageGenerator {
//   // 1. 서버에서 메세지를 불러온다
//   // 2. 불러온 메세지를 모델로 파싱한다
//   // 3. 보낸 시간 순서대로 정렬한다
//   // 4. 시간 순서대로 메세지를 만든다
//   static generator() {
//     return Message.groupBy(_sampleMessage, (data) => data.sender);
//   }
// }

// final _sampleMessage = [
//   Message(
//     text: '안녕 오늘 하루 잘 지냈니',
//     sender: '은정',
//     receiver: '명은',
//     time: DateTime.parse("2024-01-10 13:27:00"),
//   ),
//   Message(
//     text: '응. 오늘 일이 매우 바빴단다',
//     sender: '명은',
//     receiver: '은정',
//     time: DateTime.parse("2024-01-10 13:27:01"),
//   ),
//   Message(
//     text: '오늘 뭐했는데?',
//     sender: '은정',
//     receiver: '명은',
//     time: DateTime.parse("2024-01-10 13:28:14"),
//   ),
//   Message(
//     text: '이것저것 요것저것......',
//     sender: '명은',
//     receiver: '은정',
//     time: DateTime.parse("2024-01-10 13:28:48"),
//   ),
//   Message(
//     text: '모야 -_-',
//     sender: '은정',
//     receiver: '명은',
//     time: DateTime.parse("2024-01-10 13:30:11"),
//   ),
//   Message(
//     text: '뭐긴 뭐야~ 사람이지~',
//     sender: '명은',
//     receiver: '은정',
//     time: DateTime.parse("2024-01-10 13:30:18"),
//   ),
// ];

enum MessageOwner { myself, other }

@immutable
class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final String text;

  bool get isMine => owner == MessageOwner.myself;
}

class MessageGenerator {
  static List<Message> generate(int count, [int? seed]) {
    final random = Random(seed);
    // 변경할 수 없도록 고정
    return List.unmodifiable(List<Message>.generate(count, (index) {
      return Message(
        owner: random.nextBool() ? MessageOwner.myself : MessageOwner.other,
        text: _exampleData[random.nextInt(_exampleData.length)],
      );
    }));
  }

  static final _exampleData = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'In tempus mauris at velit egestas, sed blandit felis ultrices.',
    'Ut molestie mauris et ligula finibus iaculis.',
    'Sed a tempor ligula.',
    'Test',
    'Phasellus ullamcorper, mi ut imperdiet consequat, nibh augue condimentum nunc, vitae molestie massa augue nec erat.',
    'Donec scelerisque, erat vel placerat facilisis, eros turpis egestas nulla, a sodales elit nibh et enim.',
    'Mauris quis dignissim neque. In a odio leo. Aliquam egestas egestas tempor. Etiam at tortor metus.',
    'Quisque lacinia imperdiet faucibus.',
    'Proin egestas arcu non nisl laoreet, vitae iaculis enim volutpat. In vehicula convallis magna.',
    'Phasellus at diam a sapien laoreet gravida.',
    'Fusce maximus fermentum sem a scelerisque.',
    'Nam convallis sapien augue, malesuada aliquam dui bibendum nec.',
    'Quisque dictum tincidunt ex non lobortis.',
    'In hac habitasse platea dictumst.',
    'Ut pharetra ligula libero, sit amet imperdiet lorem luctus sit amet.',
    'Sed ex lorem, lacinia et varius vitae, sagittis eget libero.',
    'Vestibulum scelerisque velit sed augue ultricies, ut vestibulum lorem luctus.',
    'Pellentesque et risus pretium, egestas ipsum at, facilisis lectus.',
    'Praesent id eleifend lacus.',
    'Fusce convallis eu tortor sit amet mattis.',
    'Vivamus lacinia magna ut urna feugiat tincidunt.',
    'Sed in diam ut dolor imperdiet vehicula non ac turpis.',
    'Praesent at est hendrerit, laoreet tortor sed, varius mi.',
    'Nunc in odio leo.',
    'Praesent placerat semper libero, ut aliquet dolor.',
    'Vestibulum elementum leo metus, vitae auctor lorem tincidunt ut.',
  ];
}
