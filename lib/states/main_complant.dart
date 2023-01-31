import 'package:flutter/material.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class MainComplant extends StatelessWidget {
  const MainComplant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(text: 'เรื่องร้องทุกข์'),
      ),
      body: ListView(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
        children: [
          WidgetText(
            text: 'ประเภทเรื่อง',
            textStyle:
                AppConstant().defaultStyle(size: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
