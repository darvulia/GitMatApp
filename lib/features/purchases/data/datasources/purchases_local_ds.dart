import 'package:drift/drift.dart';
import '../../../../database/app_database.dart';

class PurchasesLocalDataSource {
  final AppDatabase db;

  PurchasesLocalDataSource(this.db);

  Stream<List<PurchasesTableData>> watchAllPurchases() {
    return (db.select(db.purchasesTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.purchaseDate, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<PurchasesTableData>> getAllPurchases() {
    return (db.select(db.purchasesTable)
          ..orderBy([
            (t) => OrderingTerm(expression: t.purchaseDate, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<int> insertPurchase(PurchasesTableCompanion entry) {
    return db.into(db.purchasesTable).insert(entry);
  }

  Future<bool> updatePurchase(PurchasesTableData entry) {
    return db.update(db.purchasesTable).replace(entry);
  }

  Future<int> deletePurchase(int id) {
    return (db.delete(db.purchasesTable)..where((t) => t.id.equals(id))).go();
  }
}
