import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class QuickServicesGrid extends StatelessWidget {
  final VoidCallback onNewPurchase;
  final VoidCallback onWasteTap;
  final VoidCallback onPricesTap;
  final VoidCallback onReportsTap;

  const QuickServicesGrid({
    super.key,
    required this.onNewPurchase,
    required this.onWasteTap,
    required this.onPricesTap,
    required this.onReportsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1: Nueva Compra (Destacado en Navy profundo)
        _buildServiceItem(
          icon: Icons.add_shopping_cart_rounded,
          label: 'Nueva Compra',
          isHighlighted: true,
          onTap: onNewPurchase,
        ),
        // 2: Mermas Tierra
        _buildServiceItem(
          icon: Icons.filter_tilt_shift_rounded,
          label: 'Mermas Tierra',
          isHighlighted: false,
          onTap: onWasteTap,
        ),
        // 3: Precios / Calidad
        _buildServiceItem(
          icon: Icons.sell_outlined,
          label: 'Precios / Kg',
          isHighlighted: false,
          onTap: onPricesTap,
        ),
        // 4: Reportes / Caja
        _buildServiceItem(
          icon: Icons.analytics_outlined,
          label: 'Reportes',
          isHighlighted: false,
          onTap: onReportsTap,
        ),
      ],
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required bool isHighlighted,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: isHighlighted
                  ? AppColors.brandDark
                  : AppColors.brandYellow.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isHighlighted
                    ? Colors.transparent
                    : AppColors.brandYellow.withValues(alpha: 0.35),
                width: 1.2,
              ),
              boxShadow: isHighlighted ? const [AppShadows.soft] : null,
            ),
            child: Center(
              child: Icon(
                icon,
                color: isHighlighted ? AppColors.brandYellow : AppColors.brandYellowDeep,
                size: 26,
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 72,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.brandDark,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
