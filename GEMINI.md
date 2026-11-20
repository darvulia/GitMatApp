# MatApp — Workspace Rules & Project Guidelines

MatApp (`com.purchmat.matapp`) es una aplicación móvil **100% Offline-First** desarrollada en **Flutter** bajo **Clean Architecture**, diseñada para la gestión, pesaje, cálculo de merma por tierra y liquidación de compra de metales (**Acero, Bronce, Cobre y Aluminio**) clasificados por calidades.

Toda la interfaz de usuario y experiencia (UI/UX) está basada estrictamente en el diseño del proyecto de **Google Stitch ID `6865743278819428915`** (*Flutter UI App Design — Kinetic Amber Delivery / Mobile App UI*).

---

## 1. Reglas Críticas de Arquitectura 100% Offline (Offline-First)

1. **Cero Dependencia de Red**:
   - **PROHIBIDO** utilizar `Image.network`, `NetworkImage`, `http`, `dio` o llamadas a APIs externas en tiempo de ejecución.
   - **PROHIBIDO** cargar fuentes tipográficas por red en tiempo de ejecución (`GoogleFonts` con `allowRuntimeFetching = true`). Toda fuente o ícono debe estar empaquetado localmente en `assets/` o renderizarse con vectores nativos (`Icons` / `CustomPainter` / `SvgPicture.asset`).
2. **Persistencia Local Garantizada**:
   - Toda la información (materiales, calidades, precios por kg, compras, pesajes y mermas por tierra) reside localmente en **SQLite** mediante **Drift** (`lib/database/app_database.dart`).
   - Las lecturas de UI deben ser reactivas (`Stream`) para reflejar cambios al instante sin recargas manuales.
3. **Formateo Seguro sin Dependencia de Locales Remotos**:
   - **PROHIBIDO** usar `DateFormat(..., 'es_MX')` o `NumberFormat(..., 'es_MX')` sin inicialización síncrona garantizada. Utiliza siempre los formateadores nativos puros en `lib/core/utils/date_formatter.dart` y `lib/core/utils/number_formatter.dart` para evitar `LocaleDataException`.

---

## 2. Reglas de Diseño UI/UX — Google Stitch Project `6865743278819428915`

El lenguaje visual sigue el sistema **"Kinetic Amber"** del proyecto `6865743278819428915`: autoridad cálida, contraste táctil para lectura en exteriores (patio de metales) y jerarquía limpia.

### Paleta de Colores Oficial (`AppColors`)
- **Primary Amber (`brand-yellow`)**: `#F4B23E` — Barra de navegación inferior flotante, bordes de avatar, indicadores activos, acentos principales.
- **Amber Light (`brand-yellow-light`)**: `#FCE9C8` / `#FEF3C7` — Fondos suaves de badges, chips y contenedores de íconos (`#F4B23E` al 15%).
- **Amber Deep (`brand-yellow-deep`)**: `#D69121` / `#7F5600` — Texto e íconos sobre fondos ámbar claros, etiquetas de acción secundaria.
- **Navy Deep (`brand-dark`)**: `#1D2B4F` — Texto primario, encabezados, botones CTA principales, botón central flotante (FAB), tarjetas destacadas.
- **Navy Surface (`brand-dark-surface`)**: `#25355E` — Variaciones de superficie oscura y estados presionados.
- **Cream Background (`scaffoldBackground`)**: `#FFFDF8` / `#FDFBF7` — Fondo general de todas las pantallas (`Scaffold`).
- **Warm Input Surface (`surfaceWarm`)**: `#FFFBF3` / `#F7F5EE` — Fondo de campos de formulario y sub-tarjetas de metadatos con borde `#FDE68A` (`amber-200`).
- **Pure Card Surface (`cream-card`)**: `#FFFFFF` — Tarjetas principales con borde sutil `#FEF3C7` (`amber-100`) o `#E8E3D5`.
- **Muted Text (`brand-muted`)**: `#7E889B` — Micro-etiquetas en mayúsculas, subtítulos y marcas de tiempo.
- **Semánticos**: Éxito `#16A34A` (fondo `#F0FDF4`), Alerta/Merma `#D97706` (fondo `#FFFBEB`), Error `#BA1A1A` (fondo `#FEF2F2`).

### Geometría, Bordes y Sombras
- **Tarjetas Principales (`Order / Form Cards`)**: `BorderRadius.circular(24.0)` (`rounded-3xl`), fondo `#FFFFFF`, borde `1px solid #FEF3C7`, sombra suave `BoxShadow(color: Color(0x121D2B4F), blurRadius: 24, offset: Offset(0, 8), spreadRadius: -4)`.
- **Campos de Entrada (`Warm Inputs`)**: `BorderRadius.circular(16.0)` (`rounded-2xl`), fondo `#FFFBF3`, borde `1px solid #FDE68A` (al enfocar: `1.5px solid #1D2B4F`), micro-etiqueta superior en mayúsculas (`10px`, `FontWeight.w700`, `#7E889B`, `letterSpacing: 0.8`) + valor inferior (`13px-15px`, `FontWeight.w600`, `#1D2B4F`).
- **Grid de Acciones Rápidas (4 Columnas)**: Botones cuadrados redondeados de `56x56` (`BorderRadius.circular(16.0)`), estado normal con fondo `#F4B23E` al 15% y borde `#F4B23E` al 30%; estado destacado con fondo `#1D2B4F` e ícono `#F4B23E`.
- **Barra de Navegación Inferior Flotante (Floating Pill Nav)**:
  - Posicionada de forma flotante (`margin: EdgeInsets.fromLTRB(20, 0, 20, 16)`), fondo `#F4B23E`, `BorderRadius.circular(24.0)`, borde `#FCD34D`, sombra `BoxShadow(color: Color(0x26F4B23E), blurRadius: 20, offset: Offset(0, -4))`.
  - **Botón Central Destacado (FAB)**: Elevado sobre la barra (`-24px`), circular `48x48`, fondo `#1D2B4F`, ícono `+` en `#F4B23E`, borde `2px solid #F4B23E`.
- **Botón de Acción Principal (CTA)**: Ancho completo, altura `50px-52px`, `BorderRadius.circular(16.0)`, fondo `#1D2B4F`, texto blanco en mayúsculas (`12px-13px`, `FontWeight.w700`, `letterSpacing: 1.0`) acompañado de ícono de flecha en `#F4B23E`.

---

## 3. Reglas de Dominio y Negocio (Compra de Metales y Merma)

1. **Materiales Soportados**: `Acero`, `Bronce`, `Cobre`, `Aluminio`.
2. **Clasificación por Calidad**: Cada compra está vinculada obligatoriamente a un material y un grado de calidad (ej. *Cobre Primera*, *Cobre Segunda*, *Bronce Limpio*, *Aluminio Duro*, etc.) que define el precio sugerido por kilogramo.
3. **Fórmulas Invariantes de Pesaje y Merma por Tierra**:
   - $\text{Peso Neto (kg)} = \text{Peso Bruto (kg)} - \text{Peso Tierra / Merma (kg)}$
   - $\text{Porcentaje de Merma (\%)} = \left(\frac{\text{Peso Tierra}}{\text{Peso Bruto}}\right) \times 100$
   - $\text{Total Pagado (\$)} = \text{Peso Neto (kg)} \times \text{Precio por Kg (\$)}$
4. **Validaciones Estrictas**:
   - `grossWeightKg > 0`
   - `dirtWeightKg >= 0` y `dirtWeightKg < grossWeightKg`
   - `pricePerKg > 0`
   - La UI debe precalcular y mostrar en tiempo real el **Peso Neto**, **% de Merma** y **Total a Liquidar** mientras el operador captura los datos.

---

## 4. Estructura Modular y Customizations
- **Rules detalladas**: `.agents/rules/`
- **Skills especializados**: `.agents/skills/`
- **Workflows operativos**: `.agents/workflows/`
- Cuando realices cambios en UI, activa el skill `stitch-ui-ux-sync`.
- Cuando modifiques base de datos, activa el skill `offline-drift-persistence`.
- Cuando modifiques cálculos o lógica de compra/merma, activa el skill `metal-purchase-domain`.
- Antes de dar por terminada una tarea visual o funcional, ejecuta la validación del skill `flutter-ux-verification`.
