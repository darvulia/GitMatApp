import 'package:drift/drift.dart';

/// Tabla catálogo de materiales
class MaterialsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get materialType => text()(); // acero, bronce, cobre, aluminio
  TextColumn get defaultUnit => text().withDefault(const Constant('kg'))();
  RealColumn get defaultPricePerUnit => real().withDefault(const Constant(0.0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
