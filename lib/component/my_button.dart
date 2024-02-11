import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26), // <-- Radius
        ),
      ),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Text('Далее'),
      ),
    );
  }
}
