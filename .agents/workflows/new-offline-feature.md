---
description: Crea una nueva funcionalidad en MatApp bajo Clean Architecture, persistencia 100% offline con Drift SQLite y diseño UI/UX Kinetic Amber (Stitch 6865743278819428915).
---

# Workflow: Nueva Funcionalidad Offline-First (Clean Architecture)

Utiliza este flujo paso a paso para agregar cualquier nueva capacidad al sistema de compra de metales y control de mermas:

## 1. Capa de Dominio (`lib/features/<feature>/domain/`)
1. Define o actualiza la entidad inmutable en `domain/entities/` extendiendo `Equatable`.
2. Si incluye cálculos de negocio (pesaje bruto, merma de tierra, peso neto, liquidación), consulta el skill `metal-purchase-domain`.
3. Declara el contrato en `domain/repositories/` y los casos de uso necesarios en `domain/usecases/`.

## 2. Capa de Datos y Persistencia Local (`lib/database/` y `data/`)
1. Si requiere cambios en tablas SQLite, aplica el skill `offline-drift-persistence` en `lib/database/app_database.dart`.
// turbo
2. Regenera el código de Drift si se modificó `app_database.dart`:
   `C:\dev\flutter\bin\dart.bat run build_runner build --delete-conflicting-outputs`
3. Implementa el repositorio en `data/repositories/` mapeando excepciones a `DatabaseFailure` o `ValidationFailure`.

## 3. Capa de Presentación (`lib/features/<feature>/presentation/`)
1. Crea los providers reactivos (`StreamProvider` / `Provider`) en `presentation/providers/`.
2. Diseña la pantalla y widgets en `presentation/screens/` y `presentation/widgets/` aplicando el skill `stitch-ui-ux-sync` (Proyecto Stitch `6865743278819428915`: fondo `#FFFDF8`, tarjetas `#FFFFFF` `rounded-3xl`, inputs `#FFFBF3` `rounded-2xl`, acentos `#F4B23E` y `#1D2B4F`).
3. Usa `DateFormatter` y `NumberFormatter` de `lib/core/utils/` para todo formato de fecha, peso y moneda.

## 4. Pruebas y Verificación
1. Agrega pruebas unitarias en `test/` cubriendo la nueva lógica de dominio.
// turbo
2. Ejecuta `C:\dev\flutter\bin\flutter.bat analyze` y `C:\dev\flutter\bin\flutter.bat test`.
