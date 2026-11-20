# Regla 01: Arquitectura 100% Offline-First (Zero Network Dependency)

MatApp se utiliza en patios de compra de metales e instalaciones industriales donde la conectividad a Internet puede ser nula o intermitente. La aplicación debe funcionar al **100% sin conexión** en todo momento.

## 1. Restricciones de Red y Recursos Externos
- **Cero Peticiones HTTP en Runtime**: No agregues paquetes como `http`, `dio`, `graphql` o `firebase_*` para la operación de la app.
- **Imágenes y Vectores Locales**:
  - Prohibido usar `Image.network` o `NetworkImage`.
  - Usa exclusivamente `Icon`, `CustomPainter` o recursos locales declarados en `pubspec.yaml` bajo `assets/`.
- **Tipografía Offline**:
  - Si se usa una familia tipográfica personalizada (como `Plus Jakarta Sans`), los archivos `.ttf`/`.otf` deben incluirse en `assets/fonts/` o usar el stack de fuentes nativo del sistema (`Roboto` / `SF Pro`) con pesos tipográficos calibrados.
  - Nunca dependas de descargas en tiempo de ejecución de Google Fonts.

## 2. Persistencia Local con Drift (SQLite)
- **Fuente Única de Verdad**: `AppDatabase` (`lib/database/app_database.dart`) sobre SQLite local (`matapp.sqlite`).
- **Transacciones Atómicas**: Toda operación que afecte múltiples registros o actualice catálogos debe ejecutarse de forma segura.
- **Datos Semilla (Seeding) Automáticos**:
  - En `onCreate`, la base de datos debe poblar automáticamente los 4 metales base (**Cobre, Bronce, Aluminio, Acero**) y sus calidades iniciales para que la app sea operable desde el primer arranque sin requerir sincronización externa.
- **Integridad de Datos**:
  - Prohibido borrar físicamente materiales o calidades que tengan compras históricas asociadas; usa borrado lógico (`isActive = false`) para preservar la integridad de reportes pasados.

## 3. Formateo de Fechas y Moneda sin Excepciones de Locale
- **Prevención de `LocaleDataException`**:
  - No utilices `DateFormat(pattern, 'es_MX')` de `intl` que depende de `initializeDateFormatting()` asíncrono.
  - Utiliza `DateFormatter` (`lib/core/utils/date_formatter.dart`) y `NumberFormatter` (`lib/core/utils/number_formatter.dart`), implementados con manipulación de cadenas nativa en Dart, garantizando ejecución instantánea y libre de errores en cualquier dispositivo o test.
