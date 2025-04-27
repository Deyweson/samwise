import 'package:flutter/material.dart';

class AddClientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddClientButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: const Icon(Icons.add));
  }
}
