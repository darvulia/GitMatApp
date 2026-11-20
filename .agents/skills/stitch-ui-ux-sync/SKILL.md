---
name: stitch-ui-ux-sync
description: >-
  Use this skill whenever creating, updating, or styling Flutter screens, widgets, themes,
  or UX interactions in MatApp. Synchronizes and translates the UI/UX design from Google Stitch
  project 6865743278819428915 (Kinetic Amber / Mobile App UI) into 100% offline Flutter code.
---

# Stitch UI/UX Design & Translation Skill (`6865743278819428915`)

Este skill guía la creación y actualización de interfaces en **MatApp** basándose estrictamente en el diseño de **Google Stitch Project `6865743278819428915`** (*Screen ID: `80b201ee89ba4a3981a886baebd77f2e` — Mobile App UI & Design System `assets/d708c4059f7548cdb6a1aa8aeb0a9e04` — Kinetic Amber*).

---

## 1. Cuándo Activar este Skill
- Al diseñar o rediseñar cualquier pantalla de MatApp (`Purchases`, `New Purchase`, `Waste/Mermas`, `Reports`, `Materials & Qualities`).
- Al modificar `lib/core/theme/app_colors.dart` o `lib/core/theme/app_theme.dart`.
- Al construir componentes reutilizables (tarjetas, inputs, barra de navegación flotante, badges, timelines).
- Al consultar o sincronizar cambios desde el servidor MCP `stitch`.

---

## 2. Procedimiento Paso a Paso

### Paso 1: Consultar la Especificación Local o vía Stitch MCP
1. Revisa la referencia local completa de tokens y estructura HTML extraída del proyecto `6865743278819428915` en:
   - [stitch-6865743278819428915-tokens.md](./references/stitch-6865743278819428915-tokens.md)
   - [kinetic_amber_widgets.dart](./examples/kinetic_amber_widgets.dart)
2. Si el usuario solicita sincronizar nuevos cambios desde Google Stitch en vivo, utiliza el servidor MCP `stitch` con:
   - `get_project` (`name: "projects/6865743278819428915"`)
   - `get_screen` (`name: "projects/6865743278819428915/screens/80b201ee89ba4a3981a886baebd77f2e"`)

### Paso 2: Aplicar la Paleta y Geometría "Kinetic Amber"
Asegúrate de que todo widget utilice los tokens exactos del proyecto `6865743278819428915`:
- **Fondo del Scaffold**: `Color(0xFFFFFDF8)` (`#FFFDF8`)
- **Tarjetas Principales**: `Color(0xFFFFFFFF)` con `BorderRadius.circular(24)`, borde `1px solid Color(0xFFFEF3C7)` y sombra suave `BoxShadow(color: Color(0x121D2B4F), blurRadius: 24, offset: Offset(0, 8), spreadRadius: -4)`.
- **Contenedores de Input Cálidos**: `Color(0xFFFFFBF3)` con `BorderRadius.circular(16)`, borde `1px solid Color(0xFFFDE68A)`, micro-etiqueta en mayúsculas `10px` (`Color(0xFF7E889B)`, `FontWeight.w700`) y valor/input en `Color(0xFF1D2B4F)` (`FontWeight.w600`).
- **Botón Principal (CTA)**: Fondo `Color(0xFF1D2B4F)` (`#1D2B4F`), texto blanco en mayúsculas (`12px-13px`, `FontWeight.w700`, `letterSpacing: 0.8`), ícono de acción en `Color(0xFFF4B23E)` (`#F4B23E`), `BorderRadius.circular(16)`.
- **Barra de Navegación Inferior Flotante**:
  - Contenedor flotante con `margin: EdgeInsets.fromLTRB(20, 0, 20, 16)`, fondo `Color(0xFFF4B23E)`, `BorderRadius.circular(24)`, borde `Color(0xFFFCD34D)`, sombra `BoxShadow(color: Color(0x26F4B23E), blurRadius: 20, offset: Offset(0, -4))`.
  - Botón central elevado (`-24px`) circular `48x48`, fondo `Color(0xFF1D2B4F)`, borde `2px solid Color(0xFFF4B23E)`, ícono `+` en `Color(0xFFF4B23E)`.

### Paso 3: Reglas de Adaptación UX al Dominio de Metales (100% Offline)
Adapta cada bloque estructural del diseño `6865743278819428915` al flujo de compra de metales:
1. **`UserProfileHeader`** $\rightarrow$ Muestra el estado operativo del patio (`PATIO DE METALES • OFFLINE`), título de la vista (`MatApp Operaciones`) y botón de acceso rápido/resumen del día con indicador activo.
2. **`ServiceCategoriesGrid` (4 botones rápidos)** $\rightarrow$ Filtros rápidos por metal (`Cobre`, `Bronce`, `Aluminio`, `Acero`) o accesos directos (`Nueva Compra`, `Mermas`, `Precios`, `Reportes`) con el ítem activo en `#1D2B4F` + `#F4B23E` y los demás en `#F4B23E` al 15%.
3. **`BookingSearchCard` (Tarjeta de formulario cálido)** $\rightarrow$ Formulario interactivo de **Registro / Simulador de Compra y Pesaje** con campos `#FFFBF3` para *Material/Calidad*, *Peso Bruto (kg)*, *Merma de Tierra (kg)*, sub-tarjetas en 2 columnas para *Fecha* y *Precio/kg*, y botón CTA `#1D2B4F` con flecha `#F4B23E`.
4. **`ActiveTrackingSection` (Tarjeta con Timeline de 3 puntos)** $\rightarrow$ Tarjetas de compras registradas donde la línea de tiempo horizontal de 3 nodos muestra visualmente:
   - **Nodo 1**: `Bruto` (ej. `100.0 kg`)
   - **Nodo 2**: `Tierra/Merma` (ej. `-5.0 kg / 5%`)
   - **Nodo 3**: `Neto` (ej. `95.0 kg`)
   - **Footer**: Iniciales del metal/calidad en círculo `#FEF3C7`, nombre del proveedor/calidad y badge con el **Total Liquidado** en `#FFFBEB` / `#D69121`.

---

## 3. Verificación Obligatoria
1. Verifica que **ningún** widget use recursos de red (`Image.network`, fuentes remotas).
2. Verifica que no existan desbordamientos (`RenderFlex overflow`) en pantallas de `390x844` o `414x896` usando `SingleChildScrollView` / `ListView` con padding inferior suficiente (`bottom: 100`) para que la barra flotante no oculte contenido.
3. Ejecuta `flutter analyze` para confirmar `0 issues`.
