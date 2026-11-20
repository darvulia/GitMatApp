import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../purchases/domain/entities/purchase_item.dart';
import '../../../purchases/presentation/providers/purchases_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesAsync = ref.watch(purchasesListStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen y Métricas'),
      ),
      body: purchasesAsync.when(
        data: (purchases) {
          if (purchases.isEmpty) {
            return const Center(
              child: Text(
                'Sin datos suficientes para generar reportes',
                style: TextStyle(color: AppColors.textDisabled),
              ),
            );
          }

          // Agrupación por tipo de material
          final mapByMaterial = <MetalType, List<PurchaseItem>>{};
          for (final mat in MetalType.values) {
            mapByMaterial[mat] = [];
          }
          for (final p in purchases) {
            mapByMaterial[p.materialType]?.add(p);
          }

          double grandTotalSpent = 0.0;
          double grandTotalNet = 0.0;
          double grandTotalWaste = 0.0;

          for (final p in purchases) {
            grandTotalSpent += p.totalCost;
            grandTotalNet += p.netQuantity;
            grandTotalWaste += p.wasteQuantity;
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Tarjeta global de totales
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.surfaceVariant, AppColors.surface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BALANCE GENERAL DE COMPRAS',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      NumberFormatter.formatCurrency(grandTotalSpent),
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStat('Lotes Comprados', '${purchases.length}'),
                        _buildStat('Material Neto', '${NumberFormatter.formatNumber(grandTotalNet)} kg'),
                        _buildStat('Merma Suciedad', '${NumberFormatter.formatNumber(grandTotalWaste)} kg'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'DESGLOSE POR TIPO DE MATERIAL',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),

              // Tarjetas individuales por material
              ...MetalType.values.map((mat) {
                final list = mapByMaterial[mat] ?? [];
                final color = _getMaterialColor(mat);

                double matSpent = 0.0;
                double matNet = 0.0;
                double matWaste = 0.0;

                for (final item in list) {
                  matSpent += item.totalCost;
                  matNet += item.netQuantity;
                  matWaste += item.wasteQuantity;
                }

                final wastePct = (matNet + matWaste) > 0
                    ? (matWaste / (matNet + matWaste)) * 100
                    : 0.0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              mat.displayName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${list.length} compras',
                              style: const TextStyle(
                                color: AppColors.textDisabled,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMiniMetric('Neto', '${NumberFormatter.formatNumber(matNet)} kg', AppColors.success),
                            _buildMiniMetric('Merma', '${NumberFormatter.formatNumber(matWaste)} kg (${wastePct.toStringAsFixed(1)}%)', AppColors.waste),
                            _buildMiniMetric('Gastado', NumberFormatter.formatCurrency(matSpent), AppColors.secondary),
                          ],
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

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textDisabled, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildMiniMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textDisabled, fontSize: 10)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
