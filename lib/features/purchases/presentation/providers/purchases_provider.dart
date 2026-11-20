import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../database/app_database.dart';
import '../../data/datasources/purchases_local_ds.dart';
import '../../data/repositories/purchases_repository_impl.dart';
import '../../domain/entities/purchase_item.dart';
import '../../domain/repositories/purchases_repository.dart';

/// Instancia única de la base de datos SQLite local
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Data source local de compras
final purchasesLocalDataSourceProvider = Provider<PurchasesLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return PurchasesLocalDataSource(db);
});

/// Repositorio de compras
final purchasesRepositoryProvider = Provider<PurchasesRepository>((ref) {
  final ds = ref.watch(purchasesLocalDataSourceProvider);
  return PurchasesRepositoryImpl(ds);
});

/// Stream reactivo de la lista de compras
final purchasesListStreamProvider = StreamProvider.autoDispose<List<PurchaseItem>>((ref) {
  final repo = ref.watch(purchasesRepositoryProvider);
  return repo.watchPurchases();
});

/// Resumen global de compras y mermas
final purchasesSummaryProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  // Se recalcula automáticamente cada vez que cambia la lista de compras
  ref.watch(purchasesListStreamProvider);
  final repo = ref.watch(purchasesRepositoryProvider);
  return repo.getPurchasesSummary();
});
