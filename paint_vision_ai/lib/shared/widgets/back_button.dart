// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.chevron_left),
      padding: EdgeInsets.zero, // Padding remove
      constraints: BoxConstraints(), // Minimum size remove
      splashRadius: 20,
    );
  }
}
