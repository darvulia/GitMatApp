// Ejemplo de implementación de componentes Stitch Project 6865743278819428915
// Paleta: Kinetic Amber (#F4B23E, #1D2B4F, #FFFDF8, #FFFBF3, #D69121, #7E889B)

import 'package:flutter/material.dart';

class Stitch6865Tokens {
  static const Color brandYellow = Color(0xFFF4B23E);
  static const Color brandYellowLight = Color(0xFFFCE9C8);
  static const Color brandYellowDeep = Color(0xFFD69121);
  static const Color brandDark = Color(0xFF1D2B4F);
  static const Color brandDarkSurface = Color(0xFF25355E);
  static const Color scaffoldCream = Color(0xFFFFFDF8);
  static const Color warmInputBg = Color(0xFFFFFBF3);
  static const Color pureCard = Color(0xFFFFFFFF);
  static const Color brandMuted = Color(0xFF7E889B);
  static const Color borderAmber100 = Color(0xFFFEF3C7);
  static const Color borderAmber200 = Color(0xFFFDE68A);
  static const Color borderAmber300 = Color(0xFFFCD34D);

  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x121D2B4F),
    blurRadius: 24,
    offset: Offset(0, 8),
    spreadRadius: -4,
  );

  static const BoxShadow navShadow = BoxShadow(
    color: Color(0x26F4B23E),
    blurRadius: 20,
    offset: Offset(0, -4),
  );
}

/// Contenedor de campo de formulario cálido (Stitch Warm Input Field)
class StitchWarmInputField extends StatelessWidget {
  final String label;
  final Widget child;
  final Widget? leading;

  const StitchWarmInputField({
    super.key,
    required this.label,
    required this.child,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Stitch6865Tokens.warmInputBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Stitch6865Tokens.borderAmber200),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            SizedBox(width: 24, child: Center(child: leading)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Stitch6865Tokens.brandMuted,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
