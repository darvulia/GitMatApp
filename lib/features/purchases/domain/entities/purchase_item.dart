import '../../../../core/constants/material_types.dart';

class PurchaseItem {
  final int? id;
  final MetalType materialType;
  final MaterialQuality quality;
  final UnitType unit;
  final double grossQuantity;
  final double wasteQuantity;
  final double netQuantity;
  final double wastePercentage;
  final double unitPrice;
  final double totalCost;
  final String? supplierName;
  final String? notes;
  final DateTime purchaseDate;
  final DateTime? createdAt;

  const PurchaseItem({
    this.id,
    required this.materialType,
    required this.quality,
    this.unit = UnitType.kilogramos,
    required this.grossQuantity,
    this.wasteQuantity = 0.0,
    required this.netQuantity,
    this.wastePercentage = 0.0,
    required this.unitPrice,
    required this.totalCost,
    this.supplierName,
    this.notes,
    required this.purchaseDate,
    this.createdAt,
  });

  /// Factory constructor para calcular automáticamente peso neto y merma
  factory PurchaseItem.create({
    int? id,
    required MetalType materialType,
    required MaterialQuality quality,
    UnitType unit = UnitType.kilogramos,
    required double grossQuantity,
    double wasteQuantity = 0.0,
    required double unitPrice,
    String? supplierName,
    String? notes,
    DateTime? purchaseDate,
  }) {
    final net = (grossQuantity - wasteQuantity).clamp(0.0, double.infinity);
    final wastePct = grossQuantity > 0 ? (wasteQuantity / grossQuantity) * 100 : 0.0;
    final total = net * unitPrice;

    return PurchaseItem(
      id: id,
      materialType: materialType,
      quality: quality,
      unit: unit,
      grossQuantity: grossQuantity,
      wasteQuantity: wasteQuantity,
      netQuantity: net,
      wastePercentage: double.parse(wastePct.toStringAsFixed(2)),
      unitPrice: unitPrice,
      totalCost: double.parse(total.toStringAsFixed(2)),
      supplierName: supplierName?.trim().isEmpty == true ? null : supplierName?.trim(),
      notes: notes?.trim().isEmpty == true ? null : notes?.trim(),
      purchaseDate: purchaseDate ?? DateTime.now(),
      createdAt: DateTime.now(),
    );
  }
}
