import 'package:drift/drift.dart';
import '../../../../core/constants/material_types.dart';
import '../../../../database/app_database.dart';
import '../../domain/entities/purchase_item.dart';
import '../../domain/repositories/purchases_repository.dart';
import '../datasources/purchases_local_ds.dart';

class PurchasesRepositoryImpl implements PurchasesRepository {
  final PurchasesLocalDataSource localDataSource;

  PurchasesRepositoryImpl(this.localDataSource);

  @override
  Stream<List<PurchaseItem>> watchPurchases() {
    return localDataSource.watchAllPurchases().map(
          (rows) => rows.map(_toEntity).toList(),
        );
  }

  @override
  Future<List<PurchaseItem>> getPurchases() async {
    final rows = await localDataSource.getAllPurchases();
    return rows.map(_toEntity).toList();
  }

  @override
  Future<int> insertPurchase(PurchaseItem purchase) {
    final companion = PurchasesTableCompanion.insert(
      materialType: purchase.materialType.key,
      quality: purchase.quality.name,
      unit: Value(purchase.unit.symbol),
      grossQuantity: purchase.grossQuantity,
      wasteQuantity: Value(purchase.wasteQuantity),
      netQuantity: purchase.netQuantity,
      wastePercentage: Value(purchase.wastePercentage),
      unitPrice: purchase.unitPrice,
      totalCost: purchase.totalCost,
      supplierName: Value(purchase.supplierName),
      notes: Value(purchase.notes),
      purchaseDate: purchase.purchaseDate,
    );
    return localDataSource.insertPurchase(companion);
  }

  @override
  Future<bool> updatePurchase(PurchaseItem purchase) {
    if (purchase.id == null) {
      throw ArgumentError('No se puede actualizar una compra sin ID');
    }
    final data = PurchasesTableData(
      id: purchase.id!,
      materialType: purchase.materialType.key,
      quality: purchase.quality.name,
      unit: purchase.unit.symbol,
      grossQuantity: purchase.grossQuantity,
      wasteQuantity: purchase.wasteQuantity,
      netQuantity: purchase.netQuantity,
      wastePercentage: purchase.wastePercentage,
      unitPrice: purchase.unitPrice,
      totalCost: purchase.totalCost,
      supplierName: purchase.supplierName,
      notes: purchase.notes,
      purchaseDate: purchase.purchaseDate,
      createdAt: purchase.createdAt ?? DateTime.now(),
    );
    return localDataSource.updatePurchase(data);
  }

  @override
  Future<int> deletePurchase(int id) {
    return localDataSource.deletePurchase(id);
  }

  @override
  Future<Map<String, dynamic>> getPurchasesSummary() async {
    final purchases = await getPurchases();
    double totalGross = 0.0;
    double totalWaste = 0.0;
    double totalNet = 0.0;
    double totalSpent = 0.0;

    for (final p in purchases) {
      totalGross += p.grossQuantity;
      totalWaste += p.wasteQuantity;
      totalNet += p.netQuantity;
      totalSpent += p.totalCost;
    }

    final avgWastePct = totalGross > 0 ? (totalWaste / totalGross) * 100 : 0.0;

    return {
      'count': purchases.length,
      'totalGross': totalGross,
      'totalWaste': totalWaste,
      'totalNet': totalNet,
      'totalSpent': totalSpent,
      'avgWastePercentage': avgWastePct,
    };
  }

  PurchaseItem _toEntity(PurchasesTableData data) {
    return PurchaseItem(
      id: data.id,
      materialType: _parseMaterialType(data.materialType),
      quality: _parseQuality(data.quality),
      unit: _parseUnit(data.unit),
      grossQuantity: data.grossQuantity,
      wasteQuantity: data.wasteQuantity,
      netQuantity: data.netQuantity,
      wastePercentage: data.wastePercentage,
      unitPrice: data.unitPrice,
      totalCost: data.totalCost,
      supplierName: data.supplierName,
      notes: data.notes,
      purchaseDate: data.purchaseDate,
      createdAt: data.createdAt,
    );
  }

  MetalType _parseMaterialType(String key) {
    return MetalType.values.firstWhere(
      (e) => e.key == key || e.name == key,
      orElse: () => MetalType.acero,
    );
  }

  MaterialQuality _parseQuality(String name) {
    return MaterialQuality.values.firstWhere(
      (e) => e.name == name || e.displayName.toLowerCase() == name.toLowerCase(),
      orElse: () => MaterialQuality.primera,
    );
  }

  UnitType _parseUnit(String symbol) {
    return UnitType.values.firstWhere(
      (e) => e.symbol == symbol || e.name == symbol,
      orElse: () => UnitType.kilogramos,
    );
  }
}
