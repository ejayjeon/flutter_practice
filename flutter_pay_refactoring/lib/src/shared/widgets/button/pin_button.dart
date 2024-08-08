import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';

class PinButton extends StatefulWidget {
  final List<String> keys;
  String pin = "";
  TextEditingController? controller;
  final VoidCallback? onTap;
  PinButton({
    super.key,
    required this.keys,
    required this.pin,
    this.controller,
    this.onTap,
  });

  @override
  State<PinButton> createState() => _PinButtonState();
}

class _PinButtonState extends State<PinButton> {
  String removeCharacters(String value) {
    if (value.isEmpty) return value;
    return value.substring(0, value.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: constraints.maxHeight,
          minHeight: constraints.minHeight,
        ),
        child: Wrap(
          children: List.generate(
            widget.keys.length + 1,
            (index) {
              double? paddingSize = 16;
              return SizedBox(
                width: constraints.maxWidth / 3 - paddingSize * 2,
                height: (constraints.maxHeight) / 4 - paddingSize * 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (index + 1 != 12) {
                        if (widget.keys[index] != '') {
                          widget.pin = widget.keys[index];
                          widget.controller?.text += widget.keys[index];
                        }
                      } else {
                        while (widget.controller!.text.isNotEmpty) {
                          widget.controller?.text =
                              removeCharacters(widget.controller!.text);
                        }
                      }
                    });
                  },
                  child: index + 1 != 12
                      ? _buildPinButton(
                          context,
                          value: widget.keys[index],
                          size: paddingSize * 2,
                        )
                      : _buildBackPressButton(size: paddingSize * 2),
                ),
              ).paddingSymmetric(
                size: Size(paddingSize, paddingSize),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPinButton(
    BuildContext context, {
    String? value,
    double? size,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(size ?? 24),
      ),
      child: value == ""
          ? ImageUtil.showImage(
              "assets/icons/sidebar/ic_logo.png",
              width: 38,
              height: 38,
            ).center
          : Text(
              value ?? "",
              style: context.titleText?.copyWith(fontWeight: FontWeight.w700),
            ).center,
    );
  }

  Widget _buildBackPressButton({
    double? size,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(size ?? 24),
      ),
      child: const Icon(Icons.backspace_rounded),
    );
  }
}
