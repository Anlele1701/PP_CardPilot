import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNavigationItem {
  const AppNavigationItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.isPrimaryAction = false,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final bool isPrimaryAction;
}

class AppFloatingNavigationBar extends StatelessWidget {
  const AppFloatingNavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  }) : assert(items.length >= 2),
       assert(selectedIndex >= 0 && selectedIndex < items.length);

  final List<AppNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: SizedBox(
        height: 70,
        child: _GlassSurface(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / items.length;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 480),
                    curve: Curves.easeInOutCubic,
                    top: 8,
                    bottom: 8,
                    left: selectedIndex * itemWidth + 8,
                    width: itemWidth - 16,
                    child: const _SelectionIndicator(),
                  ),
                  Row(
                    children: [
                      for (var index = 0; index < items.length; index++)
                        Expanded(
                          child: items[index].isPrimaryAction
                              ? _PrimaryAction(
                                  item: items[index],
                                  onTap: () => onSelected(index),
                                )
                              : _NavigationDestination(
                                  key: Key('navigation-item-$index'),
                                  item: items[index],
                                  selected: selectedIndex == index,
                                  onTap: () => onSelected(index),
                                ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandBlue.withValues(alpha: 0.16),
            blurRadius: 14,
          ),
        ],
      ),
    );
  }
}

class _GlassSurface extends StatelessWidget {
  const _GlassSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: isDark ? 0.32 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        AppColors.darkSurface.withValues(alpha: 0.88),
                        AppColors.brandBlue.withValues(alpha: 0.18),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.97),
                        Colors.white.withValues(alpha: 0.91),
                      ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: isDark ? 0.18 : 0.92),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _NavigationDestination extends StatelessWidget {
  const _NavigationDestination({
    required this.item,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final AppNavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  static const _iconDuration = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppColors.brandBlue
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: AnimatedSwitcher(
            duration: _iconDuration,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: Icon(
              selected ? item.selectedIcon ?? item.icon : item.icon,
              key: ValueKey(selected),
              size: 24,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  const _PrimaryAction({required this.item, required this.onTap});

  static const double size = 46;

  final AppNavigationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: item.label,
      child: Tooltip(
        message: item.label,
        child: Center(
          child: InkWell(
            key: const Key('primary-navigation-item'),
            onTap: onTap,
            borderRadius: BorderRadius.circular(size / 2),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.brandTeal, Color(0xFF0EBB91)],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.88),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brandTeal.withValues(alpha: 0.24),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(item.icon, color: Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
