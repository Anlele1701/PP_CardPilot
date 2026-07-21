import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

class OnboardingPagination extends StatelessWidget {
  const OnboardingPagination({
    required this.currentPage,
    required this.pageCount,
    super.key,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final isActive = currentPage == index;

        return AnimatedContainer(
          width: isActive ? 22 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.brandBlue
                : AppColors.brandBlue.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
