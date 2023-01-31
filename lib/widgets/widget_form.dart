// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    required this.hint,
    this.obsceu,
    required this.changeFunc,
  }) : super(key: key);

  final String hint;
  final bool? obsceu;
  final Function(String) changeFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(onChanged: changeFunc,
        obscureText: obsceu ?? false,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey.shade300),
      ),
    );
  }
}
