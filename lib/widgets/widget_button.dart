// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungcomplant/utility/app_constant.dart';

import 'package:ungcomplant/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressFunc,
      child: WidgetText(text: label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppConstant.redColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
