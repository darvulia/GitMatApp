# Regla 03: Clean Architecture, Riverpod y Estándares de Código

MatApp sigue una separación estricta por capas bajo **Clean Architecture** organizada por módulos funcionales (`lib/features/<feature>/`).

## 1. Estructura de Capas por Feature
Cada módulo dentro de `lib/features/{purchases,waste,reports,materials}` debe respetar:

1. **`domain/` (Puro Dart — Cero dependencias de UI o BD)**:
   - `entities/`: Clases inmutables con `Equatable` y métodos de dominio puros (ej. `PurchaseCalculation.calculate(...)`).
   - `repositories/`: Interfaces abstractas (`abstract class ...Repository`).
   - `usecases/`: Casos de uso con responsabilidad única.
2. **`data/` (Implementación e Infraestructura Local)**:
   - `models/`: Mapeo entre filas generadas por Drift y entidades de dominio.
   - `datasources/`: Acceso directo a `AppDatabase` (SQLite local).
   - `repositories/`: Implementación concreta de los repositorios de dominio, capturando excepciones locales y transformándolas en `DatabaseFailure` o `ValidationFailure`.
3. **`presentation/` (UI/UX Stitch + Estado Reactivo)**:
   - `providers/`: Providers de `flutter_riverpod` (`StreamProvider`, `FutureProvider`, `StateNotifierProvider` / `NotifierProvider`).
   - `screens/`: Pantallas construidas con el sistema de diseño **Kinetic Amber** (`6865743278819428915`).
   - `widgets/`: Componentes reutilizables desacoplados y granulares.

## 2. Reglas de Gestión de Estado (Riverpod)
- **Prohibido acceder a `AppDatabase` desde `Widget`s**: Todo widget debe consumir datos exclusivamente a través de `ref.watch(...)` o ejecutar acciones con `ref.read(...)`.
- **Streams Reactivos para Listados y Métricas**: Usa `StreamProvider` conectado a `watchPurchases()`, `watchMaterials()`, etc., para que cualquier alta o edición actualice automáticamente el Dashboard, el Control de Merma y los Reportes.
- **Manejo Explícito de `AsyncValue`**: Todo `AsyncValue` en la UI debe manejar `.when(data: ..., loading: ..., error: ...)` con componentes visuales coherentes con la paleta `#FFFDF8` / `#1D2B4F` / `#F4B23E`.

## 3. Calidad y Pruebas Obligatorias
- Todo cambio en fórmulas de pesaje, merma o liquidación debe contar con pruebas unitarias en `test/`.
- El comando `flutter analyze` debe reportar **0 issues** antes de finalizar cualquier entrega.
