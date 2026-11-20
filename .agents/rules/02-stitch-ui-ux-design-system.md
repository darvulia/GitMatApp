# Regla 02: Sistema de Diseño UI/UX — Google Stitch Project `6865743278819428915`

Toda pantalla, diálogo, tarjeta, formulario o componente de **MatApp** debe seguir fielmente el diseño y la experiencia de usuario del proyecto de Google Stitch **`6865743278819428915`** (*Screen ID: `80b201ee89ba4a3981a886baebd77f2e` / Design System: `Kinetic Amber Delivery`*).

---

## 1. Tokens de Color (`AppColors`)

| Token | Hex | Color Flutter | Uso Principal |
|---|---|---|---|
| `brandYellow` / `primaryAmber` | `#F4B23E` | `Color(0xFFF4B23E)` | Barra inferior flotante, bordes de avatar, progreso activo, indicadores primarios |
| `brandYellowLight` | `#FCE9C8` | `Color(0xFFFCE9C8)` | Fondos suaves de chips y contenedores (`amber-100`: `Color(0xFFFEF3C7)`) |
| `brandYellowDeep` | `#D69121` | `Color(0xFFD69121)` | Íconos sobre fondos ámbar claros, badges y enlaces de acción (`#7F5600` texto fuerte) |
| `brandDark` / `navyDeep` | `#1D2B4F` | `Color(0xFF1D2B4F)` | Títulos, texto primario, botón CTA principal, botón central `+`, cajas de ícono activas |
| `brandDarkSurface` | `#25355E` | `Color(0xFF25355E)` | Superficie oscura secundaria y estados `hover`/`pressed` |
| `scaffoldBackground` / `cream` | `#FFFDF8` | `Color(0xFFFFFDF8)` | Fondo base de `Scaffold` y `AppBar` (cálido, legible bajo luz solar) |
| `surfaceWarm` | `#FFFBF3` | `Color(0xFFFFFBF3)` | Fondo de inputs de formulario y sub-tarjetas de metadatos |
| `surfacePure` / `creamCard` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Superficie de tarjetas elevadas (`OrderCard`, `FormCard`, `SummaryCard`) |
| `brandMuted` | `#7E889B` | `Color(0xFF7E889B)` | Micro-etiquetas (`UPPERCASE`), subtítulos y timestamps |
| `borderAmberSubtle` | `#FEF3C7` | `Color(0xFFFEF3C7)` | Borde exterior de tarjetas blancas (`1px`) |
| `borderAmberInput` | `#FDE68A` | `Color(0xFFFDE68A)` | Borde de campos de entrada cálidos (`1px`, opacidad ~70%) |
| `borderNavAmber` | `#FCD34D` | `Color(0xFFFCD34D)` | Borde de la barra de navegación inferior flotante |

---

## 2. Sombras y Elevación Físicas (`AppShadows`)

Evita sombras grises genéricas de Material (`elevation: 4`). Utiliza exclusivamente estas dos sombras definidas en Stitch:

1. **Sombra de Tarjeta (`softShadow`)**:
   ```dart
   BoxShadow(
     color: Color(0x121D2B4F), // rgba(29, 43, 79, 0.07)
     blurRadius: 24,
     offset: Offset(0, 8),
     spreadRadius: -4,
   )
   ```
2. **Sombra de Barra de Navegación (`navShadow`)**:
   ```dart
   BoxShadow(
     color: Color(0x26F4B23E), // rgba(244, 178, 62, 0.15)
     blurRadius: 20,
     offset: Offset(0, -4),
   )
   ```

---

## 3. Anatomía de Componentes obligatorios (Stitch `6865743278819428915`)

### A. Encabezado de Perfil / Operador (`UserProfileHeader`)
- **Izquierda**: Avatar circular (`48x48`) con anillo exterior `#F4B23E` (`padding: 2px`) y círculo interior `#1D2B4F` con ícono/iniciales en `#F4B23E`.
- **Texto**: Micro-etiqueta superior en mayúsculas (`11px`, `w600`, `#7E889B`, `letterSpacing: 0.8`, ej. `PATIO CENTRAL • OFFLINE`) + Título principal (`18px`, `w700`, `#1D2B4F`, ej. `Control de Metales`).
- **Derecha**: Botón cuadrado redondeado (`40x40`, `BorderRadius.circular(16)`), fondo `#FFFFFF`, borde `#FEF3C7`, `softShadow`, con punto indicador (`10x10`) en la esquina superior derecha.

### B. Grid de 4 Acciones Rápidas (`ServiceCategoriesGrid`)
- Fila o Grid de 4 columnas con separación de `12px`.
- Cada ítem consta de un contenedor cuadrado de `56x56` con `BorderRadius.circular(16)`:
  - **Variante Estándar**: Fondo `#F4B23E` con opacidad `0.15`, borde `1px` `#F4B23E` con opacidad `0.30`, ícono `24px` en `#D69121`.
  - **Variante Destacada (Activa)**: Fondo sólido `#1D2B4F`, sombra suave, ícono `24px` en `#F4B23E`.
- Texto inferior: `11px`, `FontWeight.w600`, color `#1D2B4F`, centrado.

### C. Tarjeta de Formulario Cálida (`WarmBookingFormCard`)
- Contenedor `#FFFFFF`, `BorderRadius.circular(24)`, `padding: EdgeInsets.all(16)`, borde `1px solid #FEF3C7`, `softShadow`.
- **Cabecera de Tarjeta**: Punto circular `#F4B23E` (`10x10`) + Título (`14px`, `w700`, `#1D2B4F`) + Badge cápsula a la derecha (fondo `#FFFBEB`, texto `#D69121`, `11px`, `w600`, `BorderRadius.circular(999)`).
- **Campos de Entrada (`WarmInputContainer`)**:
  - Fondo `#FFFBF3`, borde `1px solid #FDE68A`, `BorderRadius.circular(16)`, `padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10)`.
  - Ícono o indicador circular a la izquierda + Columna con etiqueta en mayúsculas (`10px`, `w700`, `#7E889B`) y campo de texto/valor debajo (`13px`, `w600`, `#1D2B4F`).
- **Grid 2 Columnas de Metadatos** (ej. *Fecha / Calidad* o *Peso Neto / % Merma*): Dos bloques paralelos con estilo `WarmInputContainer`.
- **Botón CTA Principal**: Ancho completo, `BorderRadius.circular(16)`, fondo `#1D2B4F`, texto blanco en mayúsculas (`12px`, `w700`, `letterSpacing: 0.8`) + flecha/ícono en `#F4B23E`.

### D. Tarjetas de Operaciones / Compras con Línea de Progreso (`ActiveOrderTimelineCard` & `CompactOrderCard`)
- **Tarjeta Detallada**:
  - Cabecera con ícono `36x36` (`BorderRadius.circular(12)`, fondo `#FFFBEB`, ícono `#D69121`), folio/material en negrita (`12px`, `#1D2B4F`), subtítulo de hora/fecha (`10px`, `#7E889B`), y badge cápsula de estado (`bg: #FEF3C7`, texto `#D69121`, `10px`, `w700`, `UPPERCASE`).
  - **Timeline / Desglose en 3 Puntos Horizontales**: Conectados por línea horizontal (`2px`, tramo activo en `#F4B23E`):
    1. *Peso Bruto* (nodo `#F4B23E` con centro `#1D2B4F`)
    2. *Merma Tierra* (nodo `#1D2B4F` con borde `#F4B23E`)
    3. *Peso Neto / Pago* (nodo completado o activo)
  - Pie de tarjeta con avatar circular de iniciales (`28x28`, fondo `#FEF3C7`, texto `#1D2B4F` `11px` `w700`), etiqueta de calidad/proveedor y botón de acción rápida (`padding: 12x6`, fondo `#FFFBEB`, texto `#D69121`, `BorderRadius.circular(12)`).
- **Tarjeta Compacta**:
  - Contenedor `#FFFFFF`, `BorderRadius.circular(24)`, `padding: 14px`, ícono izquierdo `40x40` (`BorderRadius.circular(16)`, fondo `#1D2B4F`, ícono `#F4B23E`), título + resumen (`Peso Neto • $Total`), e indicador circular derecho (`24x24`, fondo `#F0FDF4`, check `#16A34A`).

### E. Barra de Navegación Inferior Flotante (`FloatingAmberBottomNav`)
- Flotante en la parte inferior (`left: 20, right: 20, bottom: 16`), fondo `#F4B23E`, `BorderRadius.circular(24)`, borde `1px solid #FCD34D`, `navShadow`.
- 4 pestañas de navegación con ícono `20px` y texto `9px-10px` (`w700` cuando está activa en `#1D2B4F`, `w600` con opacidad `0.70` cuando está inactiva).
- **Botón Central Flotante (`-mt-6`)**: Círculo de `48x48` que sobresale por encima de la barra, fondo `#1D2B4F`, ícono `+` en `#F4B23E`, borde `2px solid #F4B23E`, sombra pronunciada, que abre directamente el registro de **Nueva Compra**.

---

## 4. Directrices de Experiencia de Usuario (UX) para Operadores de Patio
1. **Legibilidad en Exteriores**: Mantén siempre alto contraste (`#1D2B4F` sobre `#FFFDF8` / `#FFFFFF` / `#F4B23E`). Nunca uses texto gris claro sobre fondo crema.
2. **Áreas Táctiles Amplias**: Todos los botones e ítems interactivos deben tener un área táctil mínima de `44x44` dp para facilitar su uso con guantes o en movimiento.
3. **Feedback Visual Instantáneo**:
   - En el formulario de compra, cada pulsación en los campos de *Peso Bruto*, *Peso Tierra* o *Precio/Kg* debe actualizar en vivo la tarjeta de liquidación sin requerir presionar un botón "Calcular".
   - Los estados vacíos deben incluir un ícono ilustrativo dentro de un contenedor ámbar suave y un botón de acción directa.
