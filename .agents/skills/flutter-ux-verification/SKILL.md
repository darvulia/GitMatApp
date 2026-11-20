---
name: flutter-ux-verification
description: >-
  Use this skill to verify code quality, run unit/widget tests, deploy MatApp to the
  Android emulator (emulator-5554), and perform visual UI/UX screenshot and interaction
  validation via ADB.
---

# Flutter UI/UX & Emulator Verification Skill

Este skill estandariza el proceso de verificación técnica y visual de **MatApp** en Windows con el emulador de Android (`Medium_Phone_API_37.0` / `emulator-5554`).

---

## 1. Rutas del Entorno Local
- **Flutter CLI**: `C:\dev\flutter\bin\flutter.bat`
- **Dart CLI**: `C:\dev\flutter\bin\dart.bat`
- **ADB CLI**: `C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe`
- **Paquete Android**: `com.purchmat.matapp`
- **Actividad Principal**: `com.purchmat.matapp/.MainActivity`

---

## 2. Flujo de Validación en 4 Etapas

### Etapa 1: Análisis Estático (Zero Warnings / Zero Errors)
```powershell
C:\dev\flutter\bin\flutter.bat analyze
```
*Criterio de éxito*: `No issues found!`.

### Etapa 2: Ejecución de Pruebas Unitarias y de Dominio
```powershell
C:\dev\flutter\bin\flutter.bat test
```
*Criterio de éxito*: `All tests passed!`.

### Etapa 3: Compilación e Instalación en Emulador (`emulator-5554`)
Si la aplicación no está en ejecución con `flutter run`, compila e instala el APK de depuración directamente:
```powershell
C:\dev\flutter\bin\flutter.bat build apk --debug
C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 install -r build\app\outputs\flutter-apk\app-debug.apk
C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 shell am start -n com.purchmat.matapp/.MainActivity
```

### Etapa 4: Auditoría Visual UI/UX e Interacción
1. Captura la pantalla actual del emulador para inspeccionar fidelidad con el proyecto Stitch `6865743278819428915`:
   ```powershell
   C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 exec-out screencap -p > current_ui_audit.png
   ```
2. Revisa `logcat` en busca de excepciones de Flutter (`FlutterError`, `RenderFlex overflowed`, `LocaleDataException`):
   ```powershell
   C:\Users\Nebular\AppData\Local\Android\Sdk\platform-tools\adb.exe -s emulator-5554 logcat -d | Select-String -Pattern "EXCEPTION CAUGHT BY|Error"
   ```
3. Verifica que la paleta (`#FFFDF8`, `#F4B23E`, `#1D2B4F`), bordes redondeados (`16px` / `24px`) y la barra inferior flotante se visualicen sin cortes ni solapamientos.
