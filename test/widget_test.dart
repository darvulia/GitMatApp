import 'package:flutter_test/flutter_test.dart';
import 'package:matapp/core/constants/material_types.dart';
import 'package:matapp/features/purchases/domain/entities/purchase_item.dart';

void main() {
  group('PurchaseItem Domain Tests', () {
    test('Calcula peso neto, % de merma y total a pagar correctamente', () {
      final item = PurchaseItem.create(
        materialType: MetalType.cobre,
        quality: MaterialQuality.primera,
        unit: UnitType.kilogramos,
        grossQuantity: 100.0,
        wasteQuantity: 10.0, // 10 kg de tierra/suciedad
        unitPrice: 150.0,    // $150 por kg
        supplierName: 'Don Juan',
      );

      // Peso neto = 100 - 10 = 90 kg
      expect(item.netQuantity, 90.0);
      // Merma = 10%
      expect(item.wastePercentage, 10.0);
      // Total = 90 kg * $150 = $13,500
      expect(item.totalCost, 13500.0);
      expect(item.materialType, MetalType.cobre);
    });

    test('Maneja compra limpia con merma en cero', () {
      final item = PurchaseItem.create(
        materialType: MetalType.aluminio,
        quality: MaterialQuality.primera,
        grossQuantity: 50.0,
        wasteQuantity: 0.0,
        unitPrice: 30.0,
      );

      expect(item.netQuantity, 50.0);
      expect(item.wastePercentage, 0.0);
      expect(item.totalCost, 1500.0);
    });
  });
}
