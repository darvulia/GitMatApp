import 'package:flutter/material.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_formatter.dart';
import 'package:matapp/features/purchases/presentation/screens/new_purchase_screen.dart';

class SimulateBookingCard extends StatefulWidget {
  const SimulateBookingCard({super.key});

  @override
  State<SimulateBookingCard> createState() => _SimulateBookingCardState();
}

class _SimulateBookingCardState extends State<SimulateBookingCard> {
  MetalType _selectedMaterial = MetalType.cobre;
  MaterialQuality _selectedQuality = MaterialQuality.primera;

  final _grossController = TextEditingController(text: '120.0');
  final _dirtController = TextEditingController(text: '6.0');

  double get _suggestedPrice {
    switch (_selectedMaterial) {
      case MetalType.cobre:
        return _selectedQuality == MaterialQuality.primera ? 150.0 : 130.0;
      case MetalType.bronce:
        return _selectedQuality == MaterialQuality.primera ? 95.0 : 80.0;
      case MetalType.aluminio:
        return _selectedQuality == MaterialQuality.primera ? 45.0 : 35.0;
      case MetalType.acero:
        return _selectedQuality == MaterialQuality.primera ? 6.5 : 5.0;
    }
  }

  double get _grossWeight => double.tryParse(_grossController.text.trim()) ?? 0.0;
  double get _dirtWeight => double.tryParse(_dirtController.text.trim()) ?? 0.0;

  double get _netWeight => (_grossWeight - _dirtWeight).clamp(0.0, double.infinity);
  double get _wastePct => _grossWeight > 0 ? (_dirtWeight / _grossWeight) * 100 : 0.0;
  double get _totalEstimated => _netWeight * _suggestedPrice;

  @override
  void dispose() {
    _grossController.dispose();
    _dirtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          // ── Cabecera de la tarjeta con estilo Stitch ───────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.brandYellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'Simulador de Compra & Pesaje',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.brandYellowLight.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'TIEMPO REAL',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brandYellowDeep,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Campo 1: Selección de Material y Calidad ───────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceWarm,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderAmberInput),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.layers_outlined,
                  color: AppColors.brandYellowDeep,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MATERIAL & CALIDAD',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Row(
                        children: [
                          DropdownButton<MetalType>(
                            value: _selectedMaterial,
                            isDense: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.brandDark),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.brandDark,
                            ),
                            items: MetalType.values.map((mat) {
                              return DropdownMenuItem(
                                value: mat,
                                child: Text(mat.displayName),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedMaterial = val);
                            },
                          ),
                          const Text(' • ', style: TextStyle(color: AppColors.brandMuted)),
                          DropdownButton<MaterialQuality>(
                            value: _selectedQuality,
                            isDense: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.brandDark),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brandDark,
                            ),
                            items: MaterialQuality.values.map((q) {
                              return DropdownMenuItem(
                                value: q,
                                child: Text(q.displayName),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedQuality = val);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // ── Campo 2 y 3: Peso Bruto y Merma de Tierra en Paralelo ──────────
          Row(
            children: [
              // Peso Bruto
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderAmberInput),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PESO BRUTO (KG)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandMuted,
                          letterSpacing: 0.6,
                        ),
                      ),
                      TextField(
                        controller: _grossController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandDark,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Merma Tierra
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderAmberInput),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MERMA TIERRA (KG)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.warning,
                          letterSpacing: 0.6,
                        ),
                      ),
                      TextField(
                        controller: _dirtController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.warning,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── Métricas en Vivo de Pre-liquidación (Grid 2 columnas) ───────────
          Row(
            children: [
              // Peso Neto y % Merma
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderAmberInput),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MATERIAL NETO',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandMuted,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '${NumberFormatter.formatNumber(_netWeight)} kg',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(-${_wastePct.toStringAsFixed(1)}%)',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Total a Pagar
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWarm,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderAmberInput),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TOTAL A PAGAR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandMuted,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        NumberFormatter.formatCurrency(_totalEstimated),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.brandDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Botón CTA Principal de Stitch (Navy + Flecha Ámbar) ─────────────
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const NewPurchaseScreen(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.brandDark,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [AppShadows.button],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'REGISTRAR COMPRA FORMAL',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.brandYellow,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
