import 'package:flutter/material.dart';
import 'package:news_wave/presentation/utils/extensions/color_extension.dart';

import '../utils/colors/color_coding.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: enableButtonBackgroundColor.toColor()),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lineColor.toColor()),
        ),
      ),
    );
  }
}
