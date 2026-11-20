import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../purchases/presentation/providers/purchases_provider.dart';

class WasteListScreen extends ConsumerWidget {
  const WasteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesAsync = ref.watch(purchasesListStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoría de Merma por Suciedad'),
      ),
      body: purchasesAsync.when(
        data: (purchases) {
          // Filtrar compras que tuvieron merma > 0
          final wasteItems = purchases.where((p) => p.wasteQuantity > 0).toList();

          if (wasteItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: 64,
                    color: AppColors.success,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No hay registros con merma',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Todas las compras registradas están limpias',
                    style: TextStyle(color: AppColors.textDisabled, fontSize: 13),
                  ),
                ],
              ),
            );
          }

          // Total acumulado de merma
          double totalWasteKg = 0.0;
          for (final item in wasteItems) {
            totalWasteKg += item.wasteQuantity;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Tarjeta informativa
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.waste.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.waste.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.waste, size: 36),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Merma Total Descontada',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          ),
                          Text(
                            '${NumberFormatter.formatNumber(totalWasteKg)} kg descartados',
                            style: const TextStyle(
                              color: AppColors.waste,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'En ${wasteItems.length} lotes con impurezas / tierra',
                            style: const TextStyle(color: AppColors.textDisabled, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'LOTES CON IMPUREZAS DETECTADAS',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),

              ...wasteItems.map((item) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.waste.withValues(alpha: 0.2),
                      child: const Icon(Icons.delete_sweep, color: AppColors.waste),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.materialType.displayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.waste.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${item.wastePercentage.toStringAsFixed(1)}% merma',
                            style: const TextStyle(
                              color: AppColors.waste,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          'Bruto: ${NumberFormatter.formatWeight(item.grossQuantity, item.unit.symbol)} → '
                          'Descuento: -${NumberFormatter.formatWeight(item.wasteQuantity, item.unit.symbol)}',
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        ),
                        if (item.notes != null && item.notes!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Detalle: "${item.notes!}"',
                            style: const TextStyle(
                              color: AppColors.textDisabled,
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          'Fecha: ${DateFormatter.formatDate(item.purchaseDate)}'
                          '${item.supplierName != null ? ' • Prov: ${item.supplierName}' : ''}',
                          style: const TextStyle(color: AppColors.textDisabled, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
