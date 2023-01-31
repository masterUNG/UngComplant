import 'package:flutter/material.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class ListShopFood extends StatelessWidget {
  const ListShopFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: WidgetText(text: 'ร้านอาหาร'),),);
  }
}