import 'package:flutter/material.dart';

/// Paleta oficial y tokens de diseño del proyecto Google Stitch `6865743278819428915`
/// Sistema: Kinetic Amber Delivery & Booking
class AppColors {
  AppColors._();

  // ── Paleta Kinetic Amber Oficial (Stitch 6865743278819428915) ─────────────
  static const Color brandYellow = Color(0xFFF4B23E);       // Primary Amber
  static const Color brandYellowLight = Color(0xFFFCE9C8);  // Amber suave
  static const Color brandYellowDeep = Color(0xFFD69121);   // Amber profundo (#7F5600 acento)
  static const Color brandDark = Color(0xFF1D2B4F);         // Navy Deep (Texto y CTA)
  static const Color brandDarkSurface = Color(0xFF25355E);  // Navy Surface
  static const Color scaffoldBackground = Color(0xFFFFFDF8);// Cream Background
  static const Color surfaceWarm = Color(0xFFFFFBF3);       // Warm Input Surface
  static const Color surfacePure = Color(0xFFFFFFFF);       // Cream Card Surface
  static const Color brandMuted = Color(0xFF7E889B);        // Muted Text (Micro-labels)

  // ── Bordes y divisores cálidos ─────────────────────────────────────────────
  static const Color borderAmberSubtle = Color(0xFFFEF3C7); // amber-100 para tarjetas
  static const Color borderAmberInput = Color(0xFFFDE68A);  // amber-200 para inputs
  static const Color borderNavAmber = Color(0xFFFCD34D);    // amber-300 para nav

  // ── Semánticos y estados ───────────────────────────────────────────────────
  static const Color success = Color(0xFF16A34A);           // Verde éxito
  static const Color successBg = Color(0xFFF0FDF4);
  static const Color warning = Color(0xFFD97706);           // Alerta / Merma
  static const Color warningBg = Color(0xFFFFFBEB);
  static const Color error = Color(0xFFBA1A1A);             // Error
  static const Color errorBg = Color(0xFFFEF2F2);
  static const Color info = Color(0xFF0284C7);

  // ── Metales ────────────────────────────────────────────────────────────────
  static const Color colorAcero = Color(0xFF64748B);
  static const Color colorBronce = Color(0xFFD97706);
  static const Color colorCobre = Color(0xFFB45309);
  static const Color colorAluminio = Color(0xFF0284C7);

  // ── Aliases para compatibilidad con código existente ───────────────────────
  static const Color primary = brandYellow;
  static const Color primaryDark = brandDark;
  static const Color primaryLight = brandYellowLight;
  static const Color secondary = brandYellowDeep;
  static const Color secondaryDark = brandDarkSurface;
  static const Color secondaryLight = brandYellow;
  static const Color background = scaffoldBackground;
  static const Color surface = surfacePure;
  static const Color surfaceVariant = surfaceWarm;
  static const Color textPrimary = brandDark;
  static const Color textSecondary = brandMuted;
  static const Color textDisabled = Color(0xFFA0AAB9);
  static const Color waste = warning;
  static const Color divider = Color(0xFFF1EDE6);
  static const Color border = borderAmberSubtle;
}

/// Sombras físicas calibradas del proyecto Stitch 6865743278819428915
class AppShadows {
  AppShadows._();

  static const BoxShadow soft = BoxShadow(
    color: Color(0x121D2B4F), // rgba(29, 43, 79, 0.07)
    blurRadius: 24,
    offset: Offset(0, 8),
    spreadRadius: -4,
  );

  static const BoxShadow nav = BoxShadow(
    color: Color(0x26F4B23E), // rgba(244, 178, 62, 0.15)
    blurRadius: 20,
    offset: Offset(0, -4),
  );

  static const BoxShadow button = BoxShadow(
    color: Color(0x1A1D2B4F),
    blurRadius: 10,
    offset: Offset(0, 4),
  );
}
