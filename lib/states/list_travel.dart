import 'package:flutter/material.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class ListTravel extends StatelessWidget {
  const ListTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(text: 'สถานที่ท่องเที่ยว'),),);
  }
}