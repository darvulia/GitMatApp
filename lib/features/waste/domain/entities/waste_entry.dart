import '../../../../core/constants/material_types.dart';

class WasteEntry {
  final int? id;
  final int? purchaseId;
  final MetalType materialType;
  final double wasteAmount;
  final UnitType unit;
  final String reason;
  final String? notes;
  final DateTime recordedAt;

  const WasteEntry({
    this.id,
    this.purchaseId,
    required this.materialType,
    required this.wasteAmount,
    this.unit = UnitType.kilogramos,
    required this.reason,
    this.notes,
    required this.recordedAt,
  });
}
