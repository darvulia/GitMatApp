---
name: offline-drift-persistence
description: >-
  Use this skill when creating, modifying, querying, or migrating local SQLite tables,
  DAOs, seed data, or repositories in MatApp using Drift. Ensures 100% offline data
  integrity and proper code generation.
---

# Offline Drift Persistence Skill

Este skill define el procedimiento exacto para trabajar con la base de datos **SQLite 100% Offline** de MatApp mediante **Drift** (`lib/database/app_database.dart`).

---

## 1. Esquema Base de MatApp
La base de datos local consta de 3 tablas relacionales principales:
1. **`MaterialsTable` (`materials`)**:
   - `id`, `code` (`COPPER`, `BRONZE`, `ALUMINUM`, `STEEL`), `name`, `description`, `colorHex`, `isActive`, `createdAt`.
2. **`QualityGradesTable` (`quality_grades`)**:
   - `id`, `materialId` (FK $\rightarrow$ `materials.id`), `name` (ej. *Cobre Primera*, *Bronce Limpio*), `defaultPricePerKg`, `typicalDirtPercent`, `description`, `isActive`.
3. **`PurchasesTable` (`purchases`)**:
   - `id`, `folio`, `materialId` (FK), `qualityGradeId` (FK), `supplierName`, `grossWeightKg`, `dirtWeightKg`, `netWeightKg`, `wastePercentage`, `pricePerKg`, `totalPaid`, `notes`, `purchasedAt`.

---

## 2. Procedimiento para Modificar o Agregar Consultas / Tablas

### Paso 1: Edición de `lib/database/app_database.dart`
- Mantén todas las columnas tipadas (`RealColumn`, `IntColumn`, `TextColumn`, `BoolColumn`, `DateTimeColumn`).
- Si agregas una tabla o columna nueva:
  1. Incrementa `schemaVersion` en `AppDatabase`.
  2. Agrega la migración correspondiente en `MigrationStrategy.onUpgrade` usando `Migrator m` (`m.addColumn(...)` o `m.createTable(...)`) para nunca perder datos locales del usuario offline.

### Paso 2: Regeneración de Código Drift (`app_database.g.dart`)
Ejecuta siempre el generador de código con la ruta del SDK de Flutter configurada:
```powershell
C:\dev\flutter\bin\dart.bat run build_runner build --delete-conflicting-outputs
```

### Paso 3: Consultas Reactivas (`Stream`)
- Para cualquier listado o tarjeta de métricas en la UI, expón un método `Stream<List<...>> watch...()` en `AppDatabase` haciendo `join` entre `purchases`, `materials` y `qualityGrades`.
- Esto garantiza que al registrar una compra o ajustar un precio por kilogramo, todas las pantallas se actualicen automáticamente sin conexión.

---

## 3. Verificación Obligatoria
1. Verifica que `lib/database/app_database.g.dart` se haya generado sin errores.
2. Ejecuta `C:\dev\flutter\bin\flutter.bat test` para validar la integridad de las consultas y repositorios.
