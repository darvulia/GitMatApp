class NumberFormatter {
  NumberFormatter._();

  /// Formatea un peso/cantidad con unidad (ej: "1,250.5 kg")
  static String formatWeight(double value, String unit) =>
      '${formatNumber(value)} $unit';

  /// Formatea un valor monetario (ej: "$1,250.00")
  static String formatCurrency(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '\$$intPart.${parts[1]}';
  }

  /// Formatea un porcentaje (ej: "15.0%")
  static String formatPercent(double value) => '${value.toStringAsFixed(1)}%';

  /// Formatea un número con separadores de miles
  static String formatNumber(double value) {
    if (value == value.roundToDouble()) {
      final s = value.toInt().toString();
      return s.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    }
    final s = value.toStringAsFixed(2);
    final parts = s.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    final dec = parts[1].endsWith('0') ? parts[1].substring(0, 1) : parts[1];
    return '$intPart.$dec';
  }
}
