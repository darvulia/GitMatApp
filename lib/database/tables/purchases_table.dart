import 'package:drift/drift.dart';

/// Tabla de registro de compras de material con control de calidad y merma
class PurchasesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Tipo y calidad del material
  TextColumn get materialType => text()(); // acero, bronce, cobre, aluminio
  TextColumn get quality => text()();      // primera, segunda, tercera, chatarra
  TextColumn get unit => text().withDefault(const Constant('kg'))(); // kg, ton, lb

  // Cantidades y cálculo de merma
  RealColumn get grossQuantity => real()();                       // Peso bruto comprado
  RealColumn get wasteQuantity => real().withDefault(const Constant(0.0))(); // Merma por suciedad
  RealColumn get netQuantity => real()();                         // Peso neto aprovechable
  RealColumn get wastePercentage => real().withDefault(const Constant(0.0))(); // % de merma calculada

  // Costos monetarios
  RealColumn get unitPrice => real()();                           // Precio pactado por unidad
  RealColumn get totalCost => real()();                           // Costo total pagado

  // Información complementaria
  TextColumn get supplierName => text().nullable()();             // Proveedor o vendedor
  TextColumn get notes => text().nullable()();                    // Observaciones sobre suciedad/estado
  DateTimeColumn get purchaseDate => dateTime()();               // Fecha de la transacción
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
