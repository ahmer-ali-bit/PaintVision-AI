// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paint_vision_ai/constants/app_colors.dart';

class ProductRating extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final int starCount;
  final double? size;
  final VoidCallback? onTap;

  const ProductRating({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.starCount = 5,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          // Stars
          ...List.generate(
            starCount,
            (index) => Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: size,
            ),
          ),

          const SizedBox(width: 6),

          // Rating + Reviews
          Text(
            '$rating ($reviewCount reviews)',
            style: TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class RatingRow extends StatelessWidget {
  final int star;
  final double percent;
  final String percentText;

  const RatingRow({
    super.key,
    required this.star,
    required this.percent,
    required this.percentText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Star number (5, 4, 3...)
          Text(
            "$star",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 2),

          // Star icon
          const Icon(Icons.star, size: 12, color: Colors.black),
          const SizedBox(width: 8),

          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percent,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Percentage text
          SizedBox(
            width: 35,
            child: Text(
              percentText,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
