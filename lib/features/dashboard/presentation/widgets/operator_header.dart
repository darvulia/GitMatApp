import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OperatorHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const OperatorHeader({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Avatar con anillo ámbar característico de Stitch
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(
                color: AppColors.brandYellow,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F1D2B4F),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.brandDark,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.precision_manufacturing_rounded,
                    color: AppColors.brandYellow,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Títulos y estado de operación
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'PATIO CENTRAL • 100% OFFLINE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brandMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Control de Metales',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brandDark,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Botón superior derecho con sombra suave e indicador
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfacePure,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderAmberSubtle),
              boxShadow: const [AppShadows.soft],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: const [
                Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.brandDark,
                    size: 20,
                  ),
                ),
                Positioned(
                  top: 9,
                  right: 9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                    child: SizedBox(width: 7, height: 7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
