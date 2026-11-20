---
description: Implementa o actualiza una pantalla de MatApp siguiendo el diseño UI/UX de Google Stitch (Proyecto ID 6865743278819428915) en modo 100% offline.
---

# Workflow: Implementar Pantalla desde Google Stitch (`6865743278819428915`)

Sigue estos pasos ordenados para transformar o actualizar cualquier pantalla de **MatApp** conforme al diseño de Google Stitch Project `6865743278819428915` (*Kinetic Amber*):

## 1. Sincronización de Especificación UI/UX
1. Lee la guía y tokens en `.agents/skills/stitch-ui-ux-sync/SKILL.md` y `.agents/skills/stitch-ui-ux-sync/references/stitch-6865743278819428915-tokens.md`.
2. Si requieres consultar la versión más reciente del proyecto en Stitch, invoca `get_project` o `get_screen` en el servidor MCP `stitch` para el proyecto `6865743278819428915` (Screen `80b201ee89ba4a3981a886baebd77f2e`).

## 2. Verificación de Tokens de Tema (`lib/core/theme/`)
1. Confirma que `lib/core/theme/app_colors.dart` y `lib/core/theme/app_theme.dart` expongan los colores del proyecto `6865743278819428915`:
   - `brandYellow`: `Color(0xFFF4B23E)`
   - `brandYellowLight`: `Color(0xFFFCE9C8)`
   - `brandYellowDeep`: `Color(0xFFD69121)`
   - `brandDark`: `Color(0xFF1D2B4F)`
   - `scaffoldBackground`: `Color(0xFFFFFDF8)`
   - `surfaceWarm`: `Color(0xFFFFFBF3)`
   - `brandMuted`: `Color(0xFF7E889B)`

## 3. Construcción de Componentes UI/UX (100% Offline)
1. Estructura la pantalla con fondo `Color(0xFFFFFDF8)` y padding inferior suficiente (`100px`) cuando conviva con la barra de navegación inferior flotante.
2. Implementa las tarjetas con `BorderRadius.circular(24)`, fondo blanco, borde `1px solid Color(0xFFFEF3C7)` y `softShadow`.
3. Implementa los campos de entrada con el contenedor cálido `Color(0xFFFFFBF3)`, `BorderRadius.circular(16)`, borde `Color(0xFFFDE68A)` y micro-etiqueta superior en mayúsculas (`10px`, `FontWeight.w700`, `Color(0xFF7E889B)`).
4. Conecta los datos exclusivamente mediante `ConsumerWidget` / `ConsumerStatefulWidget` (Riverpod) hacia la base de datos local Drift, asegurando cero llamadas de red.

## 4. Validación y Despliegue en Emulador
// turbo
1. Ejecuta el análisis estático:
   `C:\dev\flutter\bin\flutter.bat analyze`
// turbo
2. Ejecuta los tests unitarios:
   `C:\dev\flutter\bin\flutter.bat test`
3. Compila, despliega en `emulator-5554` y captura un screenshot con `adb exec-out screencap -p` para confirmar la fidelidad visual con el diseño de Stitch `6865743278819428915`.
