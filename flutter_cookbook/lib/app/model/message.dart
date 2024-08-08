import 'package:flutter/material.dart';

@immutable
class Message {
  final String text;
  final String sender;
  final String receiver;
  final DateTime time;

  const Message({
    required this.text,
    required this.sender,
    required this.receiver,
    required this.time,
  });

  static Map<K, List<Message>> groupBy<K>(
      List<Message> list, K Function(Message) keyExtractor) {
    Map<K, List<Message>> groupedMap = {};

    list.forEach((element) {
      K key = keyExtractor(element);

      if (!groupedMap.containsKey(key)) {
        groupedMap[key] = [];
      }
      groupedMap[key]?.add(element);
    });

    return groupedMap;
  }
}
