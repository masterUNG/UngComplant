import 'package:flutter/material.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class DetailComplant extends StatelessWidget {
  const DetailComplant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const WidgetText(text: 'รายละเอียน (สำหรับ Admin)'),),);
  }
}