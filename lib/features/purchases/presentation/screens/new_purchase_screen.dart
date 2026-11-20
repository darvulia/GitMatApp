import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/purchase_item.dart';
import '../providers/purchases_provider.dart';

class NewPurchaseScreen extends ConsumerStatefulWidget {
  const NewPurchaseScreen({super.key});

  @override
  ConsumerState<NewPurchaseScreen> createState() => _NewPurchaseScreenState();
}

class _NewPurchaseScreenState extends ConsumerState<NewPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();

  MetalType _selectedMaterial = MetalType.acero;
  MaterialQuality _selectedQuality = MaterialQuality.primera;
  final UnitType _selectedUnit = UnitType.kilogramos;

  final _grossController = TextEditingController();
  final _wasteController = TextEditingController(text: '0');
  final _priceController = TextEditingController();
  final _supplierController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  // Cálculos dinámicos
  double get _gross => double.tryParse(_grossController.text) ?? 0.0;
  double get _waste => double.tryParse(_wasteController.text) ?? 0.0;
  double get _unitPrice => double.tryParse(_priceController.text) ?? 0.0;
  double get _net => (_gross - _waste).clamp(0.0, double.infinity);
  double get _wastePercentage => _gross > 0 ? (_waste / _gross) * 100 : 0.0;
  double get _totalCost => _net * _unitPrice;

  @override
  void initState() {
    super.initState();
    _applyDefaultPrice();
  }

  void _applyDefaultPrice() {
    double defaultPrice = 6.0;
    switch (_selectedMaterial) {
      case MetalType.acero:
        defaultPrice = 6.0;
        break;
      case MetalType.bronce:
        defaultPrice = 90.0;
        break;
      case MetalType.cobre:
        defaultPrice = 150.0;
        break;
      case MetalType.aluminio:
        defaultPrice = 30.0;
        break;
    }
    _priceController.text = defaultPrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _grossController.dispose();
    _wasteController.dispose();
    _priceController.dispose();
    _supplierController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _savePurchase() async {
    if (!_formKey.currentState!.validate()) return;
    if (_net <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El peso neto debe ser mayor a 0 kg'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final purchase = PurchaseItem.create(
        materialType: _selectedMaterial,
        quality: _selectedQuality,
        unit: _selectedUnit,
        grossQuantity: _gross,
        wasteQuantity: _waste,
        unitPrice: _unitPrice,
        supplierName: _supplierController.text,
        notes: _notesController.text,
        purchaseDate: _selectedDate,
      );

      final repo = ref.read(purchasesRepositoryProvider);
      await repo.insertPurchase(purchase);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Compra de ${_selectedMaterial.displayName} registrada con éxito',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar compra: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Compra de Material'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── 1. Selector de Tipo de Material ──────────────────────────────
            const Text(
              'TIPO DE MATERIAL',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: MetalType.values.map((mat) {
                final isSelected = mat == _selectedMaterial;
                Color matColor;
                switch (mat) {
                  case MetalType.acero:
                    matColor = AppColors.colorAcero;
                    break;
                  case MetalType.bronce:
                    matColor = AppColors.colorBronce;
                    break;
                  case MetalType.cobre:
                    matColor = AppColors.colorCobre;
                    break;
                  case MetalType.aluminio:
                    matColor = AppColors.colorAluminio;
                    break;
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedMaterial = mat;
                          _applyDefaultPrice();
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? matColor.withValues(alpha: 0.25)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? matColor : AppColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.category,
                              color: isSelected ? matColor : AppColors.textDisabled,
                              size: 20,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              mat.displayName,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── 2. Calidad de Material ───────────────────────────────────────
            const Text(
              'CALIDAD DEL MATERIAL',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: MaterialQuality.values.map((q) {
                final isSelected = q == _selectedQuality;
                return ChoiceChip(
                  label: Text(q.displayName),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedQuality = q);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── 3. Pesos: Bruto y Merma por Suciedad ─────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _grossController,
                    label: 'Peso Bruto (${_selectedUnit.symbol})',
                    hint: '0.00',
                    prefixIcon: Icons.scale_outlined,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Requerido';
                      final val = double.tryParse(v);
                      if (val == null || val <= 0) return 'Mayor a 0';
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    controller: _wasteController,
                    label: 'Merma suciedad (${_selectedUnit.symbol})',
                    hint: '0.00',
                    prefixIcon: Icons.cleaning_services_outlined,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Requerido (0 si limpio)';
                      final val = double.tryParse(v);
                      if (val == null || val < 0) return 'Inválido';
                      if (_gross > 0 && val >= _gross) return 'Menor a peso bruto';
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── 4. Precio Unitario y Fecha ────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _priceController,
                    label: 'Precio por ${_selectedUnit.symbol} (\$)',
                    hint: '0.00',
                    prefixIcon: Icons.attach_money,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Requerido';
                      final val = double.tryParse(v);
                      if (val == null || val <= 0) return 'Mayor a 0';
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18, color: AppColors.primaryLight),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fecha de compra',
                                  style: TextStyle(color: AppColors.textDisabled, fontSize: 10),
                                ),
                                Text(
                                  DateFormatter.formatDate(_selectedDate),
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── 5. Tarjeta de Cálculo en Vivo (Neto, Merma %, Total) ──────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _waste > 0 ? AppColors.secondary.withValues(alpha: 0.5) : AppColors.primary.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Peso Neto Aprovechable:', style: TextStyle(color: AppColors.textSecondary)),
                      Text(
                        NumberFormatter.formatWeight(_net, _selectedUnit.symbol),
                        style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  if (_waste > 0) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Descuento por Merma/Suciedad:', style: TextStyle(color: AppColors.textSecondary)),
                        Text(
                          '-${NumberFormatter.formatWeight(_waste, _selectedUnit.symbol)} (${_wastePercentage.toStringAsFixed(1)}%)',
                          style: const TextStyle(color: AppColors.waste, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL A PAGAR:',
                        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        NumberFormatter.formatCurrency(_totalCost),
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── 6. Proveedor y Observaciones ──────────────────────────────────
            AppTextField(
              controller: _supplierController,
              label: 'Proveedor / Vendedor (Opcional)',
              hint: 'Nombre del recolector o empresa',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _notesController,
              label: 'Notas / Observaciones sobre suciedad (Opcional)',
              hint: 'Ej: Traía tierra y grasa adherida',
              prefixIcon: Icons.notes,
            ),
            const SizedBox(height: 28),

            // ── 7. Botón Guardar ──────────────────────────────────────────────
            AppButton(
              text: 'GUARDAR REGISTRO DE COMPRA',
              icon: Icons.check_circle_outline,
              isLoading: _isLoading,
              onPressed: _savePurchase,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
