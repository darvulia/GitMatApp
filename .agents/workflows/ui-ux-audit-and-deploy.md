---
description: Ejecuta una auditoría completa de UI/UX (basada en Stitch 6865743278819428915), verifica operación 100% offline, corre pruebas y despliega en el emulador Android.
---

# Workflow: Auditoría UI/UX, Verificación Offline y Despliegue

Ejecuta este flujo antes de cerrar cualquier iteración de interfaz o funcionalidad en **MatApp**:

## 1. Auditoría de Cumplimiento 100% Offline
1. Verifica que no existan referencias a `Image.network`, `NetworkImage`, `http` o descargas de fuentes en tiempo de ejecución en `lib/`.
2. Confirma que el formateo de fechas y moneda utilice `DateFormatter` y `NumberFormatter` nativos.

## 2. Auditoría Visual contra Stitch Project `6865743278819428915`
1. Comprueba el cumplimiento de la paleta **Kinetic Amber**:
   - Fondo base: `#FFFDF8`
   - Primario Ámbar: `#F4B23E`
   - Primario Oscuro (Navy): `#1D2B4F`
   - Superficie de Inputs Cálidos: `#FFFBF3` con borde `#FDE68A`
   - Tarjetas: `#FFFFFF` con radio `24px`, borde `#FEF3C7` y sombra suave `rgba(29, 43, 79, 0.07)`
   - Barra de navegación inferior: Flotante en `#F4B23E`, radio `24px`, con botón central circular `#1D2B4F` (`+` en `#F4B23E`).

## 3. Verificación de Calidad de Código y Pruebas
// turbo
1. Análisis estático:
   `C:\dev\flutter\bin\flutter.bat analyze`
// turbo
2. Pruebas unitarias de cálculos de compra y merma:
   `C:\dev\flutter\bin\flutter.bat test`

## 4. Despliegue y Validación en Emulador (`emulator-5554`)
// turbo
1. Compila el APK debug:
   `C:\dev\flutter\bin\flutter.bat build apk --debug`
// turbo
2. Instala y lanza en el emulador activo:
   `C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 install -r build\app\outputs\flutter-apk\app-debug.apk`
   `C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 shell am start -n com.purchmat.matapp/.MainActivity`
3. Captura screenshot y revisa `logcat` para garantizar 0 errores en tiempo de ejecución.
