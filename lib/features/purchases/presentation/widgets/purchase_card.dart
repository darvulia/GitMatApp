import 'package:flutter/material.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../domain/entities/purchase_item.dart';

class PurchaseCard extends StatelessWidget {
  final PurchaseItem purchase;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const PurchaseCard({
    super.key,
    required this.purchase,
    this.onDelete,
    this.onTap,
  });

  Color _getMaterialColor(MetalType type) {
    switch (type) {
      case MetalType.acero:
        return AppColors.colorAcero;
      case MetalType.bronce:
        return AppColors.colorBronce;
      case MetalType.cobre:
        return AppColors.colorCobre;
      case MetalType.aluminio:
        return AppColors.colorAluminio;
    }
  }

  @override
  Widget build(BuildContext context) {
    final materialColor = _getMaterialColor(purchase.materialType);
    final hasWaste = purchase.wasteQuantity > 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado: Tipo de material, Calidad y Fecha
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: materialColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: materialColor, width: 1.2),
                    ),
                    child: Text(
                      purchase.materialType.displayName.toUpperCase(),
                      style: TextStyle(
                        color: materialColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Calidad: ${purchase.quality.displayName}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    DateFormatter.formatDate(purchase.purchaseDate),
                    style: const TextStyle(
                      color: AppColors.textDisabled,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Métricas: Bruto, Merma por suciedad y Neto
              Row(
                children: [
                  Expanded(
                    child: _buildMetricItem(
                      label: 'PESO BRUTO',
                      value: NumberFormatter.formatWeight(
                        purchase.grossQuantity,
                        purchase.unit.symbol,
                      ),
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (hasWaste) ...[
                    Container(width: 1, height: 32, color: AppColors.divider),
                    Expanded(
                      child: _buildMetricItem(
                        label: 'MERMA (${purchase.wastePercentage.toStringAsFixed(1)}%)',
                        value: '-${NumberFormatter.formatWeight(purchase.wasteQuantity, purchase.unit.symbol)}',
                        color: AppColors.waste,
                      ),
                    ),
                  ],
                  Container(width: 1, height: 32, color: AppColors.divider),
                  Expanded(
                    child: _buildMetricItem(
                      label: 'PESO NETO',
                      value: NumberFormatter.formatWeight(
                        purchase.netQuantity,
                        purchase.unit.symbol,
                      ),
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: AppColors.divider, height: 1),
              const SizedBox(height: 12),

              // Pie: Costo total, Precio unitario y Proveedor
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total pagado',
                        style: TextStyle(
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        NumberFormatter.formatCurrency(purchase.totalCost),
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${NumberFormatter.formatCurrency(purchase.unitPrice)} / ${purchase.unit.symbol}',
                        style: const TextStyle(
                          color: AppColors.textDisabled,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  if (purchase.supplierName != null && purchase.supplierName!.isNotEmpty)
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              purchase.supplierName!,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.textDisabled, size: 20),
                      onPressed: onDelete,
                      tooltip: 'Eliminar registro',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textDisabled,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
