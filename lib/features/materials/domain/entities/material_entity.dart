import '../../../../core/constants/material_types.dart';

class MaterialEntity {
  final int id;
  final String name;
  final MetalType materialType;
  final String defaultUnit;
  final double defaultPricePerUnit;
  final bool isActive;

  const MaterialEntity({
    required this.id,
    required this.name,
    required this.materialType,
    this.defaultUnit = 'kg',
    this.defaultPricePerUnit = 0.0,
    this.isActive = true,
  });
}
