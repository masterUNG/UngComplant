// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog(
      {required String title, required String detail, Widget? actionFunc}) {
    Get.dialog(AlertDialog(
      icon: const WidgetImage(
        size: 100,
      ),
      title: WidgetText(text: title),
      content: WidgetText(text: detail),
      actions: [
        actionFunc ??
            WidgetButton(
              label: 'Cancel',
              pressFunc: () {
                Get.back();
              },
            )
      ],
    ));
  }
}
