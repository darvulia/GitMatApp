import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FloatingAmberBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onAddPressed;

  const FloatingAmberBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.brandYellow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderNavAmber, width: 1),
        boxShadow: const [AppShadows.nav],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.dashboard_rounded,
                  label: 'Inicio',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.shopping_bag_outlined,
                  label: 'Compras',
                ),
                // Espacio libre para el botón central FAB
                const SizedBox(width: 48),
                _buildNavItem(
                  index: 2,
                  icon: Icons.filter_alt_outlined,
                  label: 'Mermas',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.analytics_outlined,
                  label: 'Reportes',
                ),
              ],
            ),
          ),
          // Botón central elevado (+ FAB)
          Positioned(
            top: -20,
            child: GestureDetector(
              onTap: onAddPressed,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.brandDark,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.brandYellow, width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x331D2B4F),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.brandYellow,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AppColors.brandDark : AppColors.brandDark.withValues(alpha: 0.60);

    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: color,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
