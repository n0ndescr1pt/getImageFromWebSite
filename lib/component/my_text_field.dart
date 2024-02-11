import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const MyTextField({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: "Вставьте ссылку",
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
