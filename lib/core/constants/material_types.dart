// Tipos de metales soportados por la aplicación
enum MetalType {
  acero('Acero', 'steel'),
  bronce('Bronce', 'bronze'),
  cobre('Cobre', 'copper'),
  aluminio('Aluminio', 'aluminum');

  const MetalType(this.displayName, this.key);

  final String displayName;
  final String key;
}

// Unidades de medida para las compras
enum UnitType {
  kilogramos('Kilogramos', 'kg'),
  toneladas('Toneladas', 'ton'),
  libras('Libras', 'lb');

  const UnitType(this.displayName, this.symbol);

  final String displayName;
  final String symbol;
}

// Calidad del material
enum MaterialQuality {
  primera('Primera', 1),
  segunda('Segunda', 2),
  tercera('Tercera', 3),
  chatarra('Chatarra', 4);

  const MaterialQuality(this.displayName, this.level);

  final String displayName;
  final int level;
}
