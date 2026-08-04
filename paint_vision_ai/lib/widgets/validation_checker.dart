// lib/widgets/validation_checker.dart

import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';

class ValidationChecker extends StatelessWidget {
  final Map<String, bool> checks;

  const ValidationChecker({super.key, required this.checks});

  @override
  Widget build(BuildContext context) {
    // Kuch type nahi kia — kuch mat dikhao
    if (checks.isEmpty) return const SizedBox();

    // Sab valid — kuch mat dikhao (sirf green tick field mein)
    final allValid = checks.values.every((v) => v);
    if (allValid) return const SizedBox();

    // Sirf FAILED checks dikhao
    final failedChecks = checks.entries.where((entry) => !entry.value).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: failedChecks
            .map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(Icons.cancel, color: AppColors.red, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: TextStyle(color: AppColors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
