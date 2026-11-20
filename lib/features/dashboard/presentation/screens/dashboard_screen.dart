import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../purchases/domain/entities/purchase_item.dart';
import '../../../purchases/presentation/providers/purchases_provider.dart';
import '../../../purchases/presentation/screens/new_purchase_screen.dart';
import '../widgets/active_operations_section.dart';
import '../widgets/operator_header.dart';
import '../widgets/quick_services_grid.dart';
import '../widgets/simulate_booking_card.dart';

class DashboardScreen extends ConsumerWidget {
  final ValueChanged<int>? onNavigateTab;

  const DashboardScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesAsync = ref.watch(purchasesListStreamProvider);
    final summaryAsync = ref.watch(purchasesSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.brandDark,
          backgroundColor: AppColors.brandYellow,
          onRefresh: () async {
            ref.invalidate(purchasesListStreamProvider);
            ref.invalidate(purchasesSummaryProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Encabezado de Operador / Perfil ────────────────────────
                OperatorHeader(
                  onNotificationTap: () => _showDaySummaryModal(context, summaryAsync.valueOrNull),
                ),
                const SizedBox(height: 20),

                // ── 2. Grid de 4 Acciones Rápidas (Stitch Services) ───────────
                QuickServicesGrid(
                  onNewPurchase: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const NewPurchaseScreen()),
                    );
                  },
                  onWasteTap: () => onNavigateTab?.call(2),
                  onPricesTap: () => _showPriceCatalogSheet(context),
                  onReportsTap: () => onNavigateTab?.call(3),
                ),
                const SizedBox(height: 20),

                // ── 3. Tarjeta de Simulación & Registro Rápido ────────────────
                const SimulateBookingCard(),
                const SizedBox(height: 20),

                // ── 4. Mini Indicadores de Totales en Patio ───────────────────
                summaryAsync.when(
                  data: (summary) => _buildQuickMetricsBanner(summary),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),

                // ── 5. Lotes y Compras Recientes con Timeline Stitch ─────────
                purchasesAsync.when(
                  data: (purchases) => ActiveOperationsSection(
                    purchases: purchases,
                    onViewAll: () => onNavigateTab?.call(1),
                    onDelete: (item) => _confirmDeletePurchase(context, ref, item),
                  ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: AppColors.brandYellowDeep),
                    ),
                  ),
                  error: (err, _) => Center(
                    child: Text('Error al cargar datos: $err', style: const TextStyle(color: AppColors.error)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Mini Indicadores Rápidos (Totales en Patio) ────────────────────────────
  Widget _buildQuickMetricsBanner(Map<String, dynamic> summary) {
    final totalSpent = summary['totalSpent'] as double? ?? 0.0;
    final totalNet = summary['totalNet'] as double? ?? 0.0;
    final totalWaste = summary['totalWaste'] as double? ?? 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfacePure,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderAmberSubtle),
        boxShadow: const [AppShadows.soft],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMetricColumn('INVERSIÓN TOTAL', NumberFormatter.formatCurrency(totalSpent), AppColors.brandDark),
          Container(width: 1, height: 32, color: AppColors.divider),
          _buildMetricColumn('NETO PATIO', '${NumberFormatter.formatNumber(totalNet)} kg', AppColors.success),
          Container(width: 1, height: 32, color: AppColors.divider),
          _buildMetricColumn('MERMA TIERRA', '${NumberFormatter.formatNumber(totalWaste)} kg', AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.brandMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  // ── Modal de Catálogo de Precios por Kilogramo ─────────────────────────────
  void _showPriceCatalogSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfacePure,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Catálogo de Precios Sugeridos / Kg',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Precios base actualizados para compra en patio',
                style: TextStyle(fontSize: 13, color: AppColors.brandMuted),
              ),
              const SizedBox(height: 16),
              _buildPriceRow(MetalType.cobre, '\$150.00 / kg', '\$130.00 / kg', AppColors.colorCobre),
              _buildPriceRow(MetalType.bronce, '\$95.00 / kg', '\$80.00 / kg', AppColors.colorBronce),
              _buildPriceRow(MetalType.aluminio, '\$45.00 / kg', '\$35.00 / kg', AppColors.colorAluminio),
              _buildPriceRow(MetalType.acero, '\$6.50 / kg', '\$5.00 / kg', AppColors.colorAcero),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriceRow(MetalType mat, String firstGrade, String secondGrade, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceWarm,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderAmberInput),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Text(
                mat.displayName,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.brandDark),
              ),
            ],
          ),
          Row(
            children: [
              Text('1ra: $firstGrade', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.brandDark)),
              const SizedBox(width: 12),
              Text('2da: $secondGrade', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.brandMuted)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Resumen de Operación del Día ───────────────────────────────────────────
  void _showDaySummaryModal(BuildContext context, Map<String, dynamic>? summary) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfacePure,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        final totalSpent = summary?['totalSpent'] as double? ?? 0.0;
        final totalNet = summary?['totalNet'] as double? ?? 0.0;
        final totalWaste = summary?['totalWaste'] as double? ?? 0.0;
        final count = summary?['totalPurchases'] as int? ?? 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Resumen de Turno • Patio Central',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.brandDark),
              ),
              const SizedBox(height: 14),
              Text('• Lotes procesados: $count', style: const TextStyle(fontSize: 14, color: AppColors.brandDark)),
              const SizedBox(height: 6),
              Text('• Material neto recibido: ${NumberFormatter.formatNumber(totalNet)} kg', style: const TextStyle(fontSize: 14, color: AppColors.brandDark)),
              const SizedBox(height: 6),
              Text('• Tierra descontada (merma): ${NumberFormatter.formatNumber(totalWaste)} kg', style: const TextStyle(fontSize: 14, color: AppColors.warning)),
              const SizedBox(height: 6),
              Text('• Total pagado a proveedores: ${NumberFormatter.formatCurrency(totalSpent)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.brandDark)),
            ],
          ),
        );
      },
    );
  }

  // ── Confirmar Eliminación ──────────────────────────────────────────────────
  void _confirmDeletePurchase(BuildContext context, WidgetRef ref, PurchaseItem item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfacePure,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('¿Eliminar registro?', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.brandDark)),
        content: Text(
          'Se eliminará el lote de ${item.materialType.displayName} de ${NumberFormatter.formatWeight(item.netQuantity, item.unit.symbol)}.',
          style: const TextStyle(color: AppColors.brandMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar', style: TextStyle(color: AppColors.brandMuted, fontWeight: FontWeight.w700)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              if (item.id != null) {
                await ref.read(purchasesRepositoryProvider).deletePurchase(item.id!);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registro eliminado'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
