import '../entities/purchase_item.dart';

abstract class PurchasesRepository {
  /// Stream reactivo de todas las compras ordenadas por fecha descendente
  Stream<List<PurchaseItem>> watchPurchases();

  /// Obtiene la lista actual de compras
  Future<List<PurchaseItem>> getPurchases();

  /// Registra una nueva compra
  Future<int> insertPurchase(PurchaseItem purchase);

  /// Actualiza una compra existente
  Future<bool> updatePurchase(PurchaseItem purchase);

  /// Elimina una compra por id
  Future<int> deletePurchase(int id);

  /// Resumen total de compras y merma acumulada
  Future<Map<String, dynamic>> getPurchasesSummary();
}
