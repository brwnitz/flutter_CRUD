import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String text;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            margin: const EdgeInsets.only(bottom: 10),
            child: TextField(
              keyboardType: type,
              controller: controller,
              decoration: InputDecoration(
              labelText: text,
            ),
            ),
          );
  }
}