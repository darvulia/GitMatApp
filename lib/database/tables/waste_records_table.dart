import 'package:drift/drift.dart';
import 'purchases_table.dart';

/// Tabla para seguimiento de mermas e impurezas (tierra, óxido, humedad, otros materiales mezclados)
class WasteRecordsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Referencia opcional a la compra asociada
  IntColumn get purchaseId => integer().nullable().references(PurchasesTable, #id)();

  TextColumn get materialType => text()();                     // acero, bronce, cobre, aluminio
  RealColumn get wasteAmount => real()();                      // Cantidad de merma
  TextColumn get unit => text().withDefault(const Constant('kg'))(); // kg, ton, lb
  
  TextColumn get reason => text()();                           // Tierra, grasa, plástico, humedad, etc.
  TextColumn get notes => text().nullable()();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
}
