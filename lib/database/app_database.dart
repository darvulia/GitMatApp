import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../core/constants/app_constants.dart';
import 'tables/materials_table.dart';
import 'tables/purchases_table.dart';
import 'tables/waste_records_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [MaterialsTable, PurchasesTable, WasteRecordsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => AppConstants.dbVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Catálogo inicial de materiales base
          await into(materialsTable).insert(
            MaterialsTableCompanion.insert(
              name: 'Acero Estructural / Chatarra',
              materialType: 'acero',
              defaultUnit: const Value('kg'),
              defaultPricePerUnit: const Value(6.0),
            ),
          );
          await into(materialsTable).insert(
            MaterialsTableCompanion.insert(
              name: 'Bronce Pieza / Viruta',
              materialType: 'bronce',
              defaultUnit: const Value('kg'),
              defaultPricePerUnit: const Value(90.0),
            ),
          );
          await into(materialsTable).insert(
            MaterialsTableCompanion.insert(
              name: 'Cobre de 1ra (Hilo limpio / Tubo)',
              materialType: 'cobre',
              defaultUnit: const Value('kg'),
              defaultPricePerUnit: const Value(150.0),
            ),
          );
          await into(materialsTable).insert(
            MaterialsTableCompanion.insert(
              name: 'Aluminio Perfil / Grueso',
              materialType: 'aluminio',
              defaultUnit: const Value('kg'),
              defaultPricePerUnit: const Value(30.0),
            ),
          );
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.dbName));
    return NativeDatabase.createInBackground(file);
  });
}
