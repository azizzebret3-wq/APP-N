import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/models/course.dart';

/// A relief-style card for the horizontal course carousel.
class CourseCarouselCard extends StatelessWidget {
  const CourseCarouselCard({required this.course, super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course icon badge.
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: course.color.withAlpha(30),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(course.icon, color: course.color, size: 28),
          ),
          const SizedBox(height: 14),
          Text(
            course.category.toUpperCase(),
            style: AppTypography.labelSmall.copyWith(
              color: course.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            course.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.headlineSmall,
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.play_circle_outline_rounded,
                size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${course.lessons} leçons',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${course.price} FCFA',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
