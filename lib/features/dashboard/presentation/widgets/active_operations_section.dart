import 'package:flutter/material.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/number_formatter.dart';
import 'package:matapp/features/purchases/domain/entities/purchase_item.dart';

class ActiveOperationsSection extends StatelessWidget {
  final List<PurchaseItem> purchases;
  final VoidCallback onViewAll;
  final void Function(PurchaseItem purchase) onDelete;

  const ActiveOperationsSection({
    super.key,
    required this.purchases,
    required this.onViewAll,
    required this.onDelete,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Cabecera de la sección ───────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Lotes y Compras Recientes',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.brandDark,
                letterSpacing: -0.2,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'Ver todas (${purchases.length})',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brandYellowDeep,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (purchases.isEmpty)
          _buildEmptyState()
        else ...[
          // La primera compra se muestra con la tarjeta Timeline detallada
          _buildTimelineCard(context, purchases.first),
          const SizedBox(height: 12),

          // Las siguientes compras se muestran con el formato compacto de Stitch
          ...purchases.skip(1).take(3).map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildCompactCard(context, item),
            );
          }),
        ],
      ],
    );
  }

  // ── Tarjeta con Timeline de 3 Puntos (Stitch Order Card) ───────────────────
  Widget _buildTimelineCard(BuildContext context, PurchaseItem item) {
    final matColor = _getMaterialColor(item.materialType);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePure,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderAmberSubtle, width: 1),
        boxShadow: const [AppShadows.soft],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera del lote
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.brandYellowLight.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.brandYellowDeep,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.materialType.displayName} • ${item.quality.displayName}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandDark,
                        ),
                      ),
                      Text(
                        DateFormatter.formatDateTime(item.purchaseDate),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.brandMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brandYellowLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'EN PATIO',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brandYellowDeep,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // ── Timeline horizontal de 3 nodos (Bruto -> Tierra -> Neto) ──────
          Stack(
            alignment: Alignment.center,
            children: [
              // Línea de fondo
              Positioned(
                left: 24,
                right: 24,
                top: 10,
                child: Container(
                  height: 2.5,
                  color: AppColors.divider,
                ),
              ),
              // Tramo activo en amarillo
              Positioned(
                left: 24,
                right: MediaQuery.of(context).size.width * 0.25,
                top: 10,
                child: Container(
                  height: 2.5,
                  color: AppColors.brandYellow,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nodo 1: Peso Bruto
                  _buildTimelineNode(
                    nodeColor: AppColors.brandYellow,
                    innerColor: AppColors.brandDark,
                    label: 'Bruto',
                    value: '${NumberFormatter.formatNumber(item.grossQuantity)} kg',
                  ),
                  // Nodo 2: Merma Tierra
                  _buildTimelineNode(
                    nodeColor: AppColors.brandDark,
                    innerColor: AppColors.brandYellow,
                    label: 'Tierra',
                    value: '-${NumberFormatter.formatNumber(item.wasteQuantity)} kg',
                    isWarning: true,
                  ),
                  // Nodo 3: Material Neto
                  _buildTimelineNode(
                    nodeColor: AppColors.success,
                    innerColor: Colors.white,
                    label: 'Neto',
                    value: '${NumberFormatter.formatNumber(item.netQuantity)} kg',
                    isSuccess: true,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Pie de tarjeta: Proveedor y Monto Liquidado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: matColor.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        item.materialType.displayName.substring(0, 1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: matColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.supplierName ?? 'Proveedor de Patio',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandDark,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.brandYellowLight.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      NumberFormatter.formatCurrency(item.totalCost),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.brandYellowDeep,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.brandMuted),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => onDelete(item),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode({
    required Color nodeColor,
    required Color innerColor,
    required String label,
    required String value,
    bool isWarning = false,
    bool isSuccess = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: nodeColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F1D2B4F),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: innerColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: isWarning
                ? AppColors.warning
                : (isSuccess ? AppColors.success : AppColors.brandMuted),
            letterSpacing: 0.5,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: isWarning
                ? AppColors.warning
                : (isSuccess ? AppColors.success : AppColors.brandDark),
          ),
        ),
      ],
    );
  }

  // ── Tarjeta Compacta (Stitch Order Card Compact) ───────────────────────────
  Widget _buildCompactCard(BuildContext context, PurchaseItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfacePure,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderAmberSubtle, width: 1),
        boxShadow: const [AppShadows.soft],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.brandDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(
                    Icons.scale_rounded,
                    color: AppColors.brandYellow,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.materialType.displayName} • ${item.quality.displayName}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.brandDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${NumberFormatter.formatNumber(item.netQuantity)} kg neto • ${NumberFormatter.formatCurrency(item.totalCost)}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brandMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: AppColors.successBg,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: AppColors.success,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surfacePure,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderAmberSubtle),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.brandYellowLight.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.scale_outlined,
                color: AppColors.brandYellowDeep,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Sin compras registradas aún',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.brandDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Usa el simulador superior o el botón "+" para registrar material',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.brandMuted,
            ),
          ),
        ],
      ),
    );
  }
}
