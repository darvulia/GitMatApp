import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../domain/entities/purchase_item.dart';
import '../providers/purchases_provider.dart';
import '../widgets/purchase_card.dart';


class PurchasesListScreen extends ConsumerStatefulWidget {
  const PurchasesListScreen({super.key});

  @override
  ConsumerState<PurchasesListScreen> createState() => _PurchasesListScreenState();
}

class _PurchasesListScreenState extends ConsumerState<PurchasesListScreen> {
  MetalType? _filterMaterial;

  @override
  Widget build(BuildContext context) {
    final purchasesAsync = ref.watch(purchasesListStreamProvider);
    final summaryAsync = ref.watch(purchasesSummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Registro de Compras', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.brandDark)),
        backgroundColor: AppColors.scaffoldBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.brandDark),
            onPressed: () {
              ref.invalidate(purchasesListStreamProvider);
              ref.invalidate(purchasesSummaryProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Resumen superior de totales ────────────────────────────────────
          summaryAsync.when(
            data: (summary) => _buildSummaryHeader(summary),
            loading: () => const SizedBox(height: 70, child: Center(child: CircularProgressIndicator())),
            error: (err, stack) => const SizedBox.shrink(),
          ),

          // ── Chips de filtro por tipo de material ───────────────────────────
          _buildFilterChips(),

          // ── Lista de compras ───────────────────────────────────────────────
          Expanded(
            child: purchasesAsync.when(
              data: (purchases) {
                final filtered = _filterMaterial == null
                    ? purchases
                    : purchases.where((p) => p.materialType == _filterMaterial).toList();

                if (filtered.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 110, top: 4),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return PurchaseCard(
                      purchase: item,
                      onDelete: () => _confirmDelete(item),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Error al cargar compras: $err',
                    style: const TextStyle(color: AppColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(Map<String, dynamic> summary) {
    final totalSpent = summary['totalSpent'] as double? ?? 0.0;
    final totalNet = summary['totalNet'] as double? ?? 0.0;
    final totalWaste = summary['totalWaste'] as double? ?? 0.0;
    final avgWastePct = summary['avgWastePercentage'] as double? ?? 0.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryColumn(
            label: 'TOTAL GASTADO',
            value: NumberFormatter.formatCurrency(totalSpent),
            color: AppColors.secondary,
          ),
          Container(width: 1, height: 36, color: AppColors.divider),
          _buildSummaryColumn(
            label: 'MATERIAL NETO',
            value: '${NumberFormatter.formatNumber(totalNet)} kg',
            color: AppColors.success,
          ),
          Container(width: 1, height: 36, color: AppColors.divider),
          _buildSummaryColumn(
            label: 'MERMA (${avgWastePct.toStringAsFixed(1)}%)',
            value: '${NumberFormatter.formatNumber(totalWaste)} kg',
            color: AppColors.waste,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textDisabled,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Todos'),
            selected: _filterMaterial == null,
            onSelected: (_) => setState(() => _filterMaterial = null),
          ),
          const SizedBox(width: 8),
          ...MetalType.values.map((mat) {
            final isSelected = _filterMaterial == mat;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(mat.displayName),
                selected: isSelected,
                onSelected: (_) => setState(() => _filterMaterial = mat),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: AppColors.textDisabled.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sin registros de compras',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Presiona "Nueva Compra" para registrar material',
            style: TextStyle(color: AppColors.textDisabled, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(PurchaseItem item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('¿Eliminar compra?'),
        content: Text(
          'Se eliminará el registro de ${item.materialType.displayName} '
          '(${NumberFormatter.formatWeight(item.netQuantity, item.unit.symbol)}).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              if (item.id != null) {
                await ref.read(purchasesRepositoryProvider).deletePurchase(item.id!);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registro eliminado'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
