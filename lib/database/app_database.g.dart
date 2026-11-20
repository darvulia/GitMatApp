// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MaterialsTableTable extends MaterialsTable
    with TableInfo<$MaterialsTableTable, MaterialsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialTypeMeta = const VerificationMeta(
    'materialType',
  );
  @override
  late final GeneratedColumn<String> materialType = GeneratedColumn<String>(
    'material_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultUnitMeta = const VerificationMeta(
    'defaultUnit',
  );
  @override
  late final GeneratedColumn<String> defaultUnit = GeneratedColumn<String>(
    'default_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kg'),
  );
  static const VerificationMeta _defaultPricePerUnitMeta =
      const VerificationMeta('defaultPricePerUnit');
  @override
  late final GeneratedColumn<double> defaultPricePerUnit =
      GeneratedColumn<double>(
        'default_price_per_unit',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    materialType,
    defaultUnit,
    defaultPricePerUnit,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materials_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaterialsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('material_type')) {
      context.handle(
        _materialTypeMeta,
        materialType.isAcceptableOrUnknown(
          data['material_type']!,
          _materialTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materialTypeMeta);
    }
    if (data.containsKey('default_unit')) {
      context.handle(
        _defaultUnitMeta,
        defaultUnit.isAcceptableOrUnknown(
          data['default_unit']!,
          _defaultUnitMeta,
        ),
      );
    }
    if (data.containsKey('default_price_per_unit')) {
      context.handle(
        _defaultPricePerUnitMeta,
        defaultPricePerUnit.isAcceptableOrUnknown(
          data['default_price_per_unit']!,
          _defaultPricePerUnitMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaterialsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaterialsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      materialType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_type'],
      )!,
      defaultUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_unit'],
      )!,
      defaultPricePerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_price_per_unit'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaterialsTableTable createAlias(String alias) {
    return $MaterialsTableTable(attachedDatabase, alias);
  }
}

class MaterialsTableData extends DataClass
    implements Insertable<MaterialsTableData> {
  final int id;
  final String name;
  final String materialType;
  final String defaultUnit;
  final double defaultPricePerUnit;
  final bool isActive;
  final DateTime createdAt;
  const MaterialsTableData({
    required this.id,
    required this.name,
    required this.materialType,
    required this.defaultUnit,
    required this.defaultPricePerUnit,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['material_type'] = Variable<String>(materialType);
    map['default_unit'] = Variable<String>(defaultUnit);
    map['default_price_per_unit'] = Variable<double>(defaultPricePerUnit);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaterialsTableCompanion toCompanion(bool nullToAbsent) {
    return MaterialsTableCompanion(
      id: Value(id),
      name: Value(name),
      materialType: Value(materialType),
      defaultUnit: Value(defaultUnit),
      defaultPricePerUnit: Value(defaultPricePerUnit),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory MaterialsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaterialsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      materialType: serializer.fromJson<String>(json['materialType']),
      defaultUnit: serializer.fromJson<String>(json['defaultUnit']),
      defaultPricePerUnit: serializer.fromJson<double>(
        json['defaultPricePerUnit'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'materialType': serializer.toJson<String>(materialType),
      'defaultUnit': serializer.toJson<String>(defaultUnit),
      'defaultPricePerUnit': serializer.toJson<double>(defaultPricePerUnit),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaterialsTableData copyWith({
    int? id,
    String? name,
    String? materialType,
    String? defaultUnit,
    double? defaultPricePerUnit,
    bool? isActive,
    DateTime? createdAt,
  }) => MaterialsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    materialType: materialType ?? this.materialType,
    defaultUnit: defaultUnit ?? this.defaultUnit,
    defaultPricePerUnit: defaultPricePerUnit ?? this.defaultPricePerUnit,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  MaterialsTableData copyWithCompanion(MaterialsTableCompanion data) {
    return MaterialsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      materialType: data.materialType.present
          ? data.materialType.value
          : this.materialType,
      defaultUnit: data.defaultUnit.present
          ? data.defaultUnit.value
          : this.defaultUnit,
      defaultPricePerUnit: data.defaultPricePerUnit.present
          ? data.defaultPricePerUnit.value
          : this.defaultPricePerUnit,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaterialsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('materialType: $materialType, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('defaultPricePerUnit: $defaultPricePerUnit, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    materialType,
    defaultUnit,
    defaultPricePerUnit,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaterialsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.materialType == this.materialType &&
          other.defaultUnit == this.defaultUnit &&
          other.defaultPricePerUnit == this.defaultPricePerUnit &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class MaterialsTableCompanion extends UpdateCompanion<MaterialsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> materialType;
  final Value<String> defaultUnit;
  final Value<double> defaultPricePerUnit;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const MaterialsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.materialType = const Value.absent(),
    this.defaultUnit = const Value.absent(),
    this.defaultPricePerUnit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MaterialsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String materialType,
    this.defaultUnit = const Value.absent(),
    this.defaultPricePerUnit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       materialType = Value(materialType);
  static Insertable<MaterialsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? materialType,
    Expression<String>? defaultUnit,
    Expression<double>? defaultPricePerUnit,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (materialType != null) 'material_type': materialType,
      if (defaultUnit != null) 'default_unit': defaultUnit,
      if (defaultPricePerUnit != null)
        'default_price_per_unit': defaultPricePerUnit,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MaterialsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? materialType,
    Value<String>? defaultUnit,
    Value<double>? defaultPricePerUnit,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return MaterialsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      materialType: materialType ?? this.materialType,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      defaultPricePerUnit: defaultPricePerUnit ?? this.defaultPricePerUnit,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (materialType.present) {
      map['material_type'] = Variable<String>(materialType.value);
    }
    if (defaultUnit.present) {
      map['default_unit'] = Variable<String>(defaultUnit.value);
    }
    if (defaultPricePerUnit.present) {
      map['default_price_per_unit'] = Variable<double>(
        defaultPricePerUnit.value,
      );
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('materialType: $materialType, ')
          ..write('defaultUnit: $defaultUnit, ')
          ..write('defaultPricePerUnit: $defaultPricePerUnit, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTableTable extends PurchasesTable
    with TableInfo<$PurchasesTableTable, PurchasesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _materialTypeMeta = const VerificationMeta(
    'materialType',
  );
  @override
  late final GeneratedColumn<String> materialType = GeneratedColumn<String>(
    'material_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kg'),
  );
  static const VerificationMeta _grossQuantityMeta = const VerificationMeta(
    'grossQuantity',
  );
  @override
  late final GeneratedColumn<double> grossQuantity = GeneratedColumn<double>(
    'gross_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteQuantityMeta = const VerificationMeta(
    'wasteQuantity',
  );
  @override
  late final GeneratedColumn<double> wasteQuantity = GeneratedColumn<double>(
    'waste_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _netQuantityMeta = const VerificationMeta(
    'netQuantity',
  );
  @override
  late final GeneratedColumn<double> netQuantity = GeneratedColumn<double>(
    'net_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wastePercentageMeta = const VerificationMeta(
    'wastePercentage',
  );
  @override
  late final GeneratedColumn<double> wastePercentage = GeneratedColumn<double>(
    'waste_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    materialType,
    quality,
    unit,
    grossQuantity,
    wasteQuantity,
    netQuantity,
    wastePercentage,
    unitPrice,
    totalCost,
    supplierName,
    notes,
    purchaseDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchasesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('material_type')) {
      context.handle(
        _materialTypeMeta,
        materialType.isAcceptableOrUnknown(
          data['material_type']!,
          _materialTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materialTypeMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('gross_quantity')) {
      context.handle(
        _grossQuantityMeta,
        grossQuantity.isAcceptableOrUnknown(
          data['gross_quantity']!,
          _grossQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grossQuantityMeta);
    }
    if (data.containsKey('waste_quantity')) {
      context.handle(
        _wasteQuantityMeta,
        wasteQuantity.isAcceptableOrUnknown(
          data['waste_quantity']!,
          _wasteQuantityMeta,
        ),
      );
    }
    if (data.containsKey('net_quantity')) {
      context.handle(
        _netQuantityMeta,
        netQuantity.isAcceptableOrUnknown(
          data['net_quantity']!,
          _netQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_netQuantityMeta);
    }
    if (data.containsKey('waste_percentage')) {
      context.handle(
        _wastePercentageMeta,
        wastePercentage.isAcceptableOrUnknown(
          data['waste_percentage']!,
          _wastePercentageMeta,
        ),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchasesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchasesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      materialType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_type'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      grossQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_quantity'],
      )!,
      wasteQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waste_quantity'],
      )!,
      netQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_quantity'],
      )!,
      wastePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waste_percentage'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchasesTableTable createAlias(String alias) {
    return $PurchasesTableTable(attachedDatabase, alias);
  }
}

class PurchasesTableData extends DataClass
    implements Insertable<PurchasesTableData> {
  final int id;
  final String materialType;
  final String quality;
  final String unit;
  final double grossQuantity;
  final double wasteQuantity;
  final double netQuantity;
  final double wastePercentage;
  final double unitPrice;
  final double totalCost;
  final String? supplierName;
  final String? notes;
  final DateTime purchaseDate;
  final DateTime createdAt;
  const PurchasesTableData({
    required this.id,
    required this.materialType,
    required this.quality,
    required this.unit,
    required this.grossQuantity,
    required this.wasteQuantity,
    required this.netQuantity,
    required this.wastePercentage,
    required this.unitPrice,
    required this.totalCost,
    this.supplierName,
    this.notes,
    required this.purchaseDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['material_type'] = Variable<String>(materialType);
    map['quality'] = Variable<String>(quality);
    map['unit'] = Variable<String>(unit);
    map['gross_quantity'] = Variable<double>(grossQuantity);
    map['waste_quantity'] = Variable<double>(wasteQuantity);
    map['net_quantity'] = Variable<double>(netQuantity);
    map['waste_percentage'] = Variable<double>(wastePercentage);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total_cost'] = Variable<double>(totalCost);
    if (!nullToAbsent || supplierName != null) {
      map['supplier_name'] = Variable<String>(supplierName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesTableCompanion toCompanion(bool nullToAbsent) {
    return PurchasesTableCompanion(
      id: Value(id),
      materialType: Value(materialType),
      quality: Value(quality),
      unit: Value(unit),
      grossQuantity: Value(grossQuantity),
      wasteQuantity: Value(wasteQuantity),
      netQuantity: Value(netQuantity),
      wastePercentage: Value(wastePercentage),
      unitPrice: Value(unitPrice),
      totalCost: Value(totalCost),
      supplierName: supplierName == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierName),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      purchaseDate: Value(purchaseDate),
      createdAt: Value(createdAt),
    );
  }

  factory PurchasesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchasesTableData(
      id: serializer.fromJson<int>(json['id']),
      materialType: serializer.fromJson<String>(json['materialType']),
      quality: serializer.fromJson<String>(json['quality']),
      unit: serializer.fromJson<String>(json['unit']),
      grossQuantity: serializer.fromJson<double>(json['grossQuantity']),
      wasteQuantity: serializer.fromJson<double>(json['wasteQuantity']),
      netQuantity: serializer.fromJson<double>(json['netQuantity']),
      wastePercentage: serializer.fromJson<double>(json['wastePercentage']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      supplierName: serializer.fromJson<String?>(json['supplierName']),
      notes: serializer.fromJson<String?>(json['notes']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'materialType': serializer.toJson<String>(materialType),
      'quality': serializer.toJson<String>(quality),
      'unit': serializer.toJson<String>(unit),
      'grossQuantity': serializer.toJson<double>(grossQuantity),
      'wasteQuantity': serializer.toJson<double>(wasteQuantity),
      'netQuantity': serializer.toJson<double>(netQuantity),
      'wastePercentage': serializer.toJson<double>(wastePercentage),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalCost': serializer.toJson<double>(totalCost),
      'supplierName': serializer.toJson<String?>(supplierName),
      'notes': serializer.toJson<String?>(notes),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchasesTableData copyWith({
    int? id,
    String? materialType,
    String? quality,
    String? unit,
    double? grossQuantity,
    double? wasteQuantity,
    double? netQuantity,
    double? wastePercentage,
    double? unitPrice,
    double? totalCost,
    Value<String?> supplierName = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? purchaseDate,
    DateTime? createdAt,
  }) => PurchasesTableData(
    id: id ?? this.id,
    materialType: materialType ?? this.materialType,
    quality: quality ?? this.quality,
    unit: unit ?? this.unit,
    grossQuantity: grossQuantity ?? this.grossQuantity,
    wasteQuantity: wasteQuantity ?? this.wasteQuantity,
    netQuantity: netQuantity ?? this.netQuantity,
    wastePercentage: wastePercentage ?? this.wastePercentage,
    unitPrice: unitPrice ?? this.unitPrice,
    totalCost: totalCost ?? this.totalCost,
    supplierName: supplierName.present ? supplierName.value : this.supplierName,
    notes: notes.present ? notes.value : this.notes,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchasesTableData copyWithCompanion(PurchasesTableCompanion data) {
    return PurchasesTableData(
      id: data.id.present ? data.id.value : this.id,
      materialType: data.materialType.present
          ? data.materialType.value
          : this.materialType,
      quality: data.quality.present ? data.quality.value : this.quality,
      unit: data.unit.present ? data.unit.value : this.unit,
      grossQuantity: data.grossQuantity.present
          ? data.grossQuantity.value
          : this.grossQuantity,
      wasteQuantity: data.wasteQuantity.present
          ? data.wasteQuantity.value
          : this.wasteQuantity,
      netQuantity: data.netQuantity.present
          ? data.netQuantity.value
          : this.netQuantity,
      wastePercentage: data.wastePercentage.present
          ? data.wastePercentage.value
          : this.wastePercentage,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      notes: data.notes.present ? data.notes.value : this.notes,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesTableData(')
          ..write('id: $id, ')
          ..write('materialType: $materialType, ')
          ..write('quality: $quality, ')
          ..write('unit: $unit, ')
          ..write('grossQuantity: $grossQuantity, ')
          ..write('wasteQuantity: $wasteQuantity, ')
          ..write('netQuantity: $netQuantity, ')
          ..write('wastePercentage: $wastePercentage, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('supplierName: $supplierName, ')
          ..write('notes: $notes, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    materialType,
    quality,
    unit,
    grossQuantity,
    wasteQuantity,
    netQuantity,
    wastePercentage,
    unitPrice,
    totalCost,
    supplierName,
    notes,
    purchaseDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchasesTableData &&
          other.id == this.id &&
          other.materialType == this.materialType &&
          other.quality == this.quality &&
          other.unit == this.unit &&
          other.grossQuantity == this.grossQuantity &&
          other.wasteQuantity == this.wasteQuantity &&
          other.netQuantity == this.netQuantity &&
          other.wastePercentage == this.wastePercentage &&
          other.unitPrice == this.unitPrice &&
          other.totalCost == this.totalCost &&
          other.supplierName == this.supplierName &&
          other.notes == this.notes &&
          other.purchaseDate == this.purchaseDate &&
          other.createdAt == this.createdAt);
}

class PurchasesTableCompanion extends UpdateCompanion<PurchasesTableData> {
  final Value<int> id;
  final Value<String> materialType;
  final Value<String> quality;
  final Value<String> unit;
  final Value<double> grossQuantity;
  final Value<double> wasteQuantity;
  final Value<double> netQuantity;
  final Value<double> wastePercentage;
  final Value<double> unitPrice;
  final Value<double> totalCost;
  final Value<String?> supplierName;
  final Value<String?> notes;
  final Value<DateTime> purchaseDate;
  final Value<DateTime> createdAt;
  const PurchasesTableCompanion({
    this.id = const Value.absent(),
    this.materialType = const Value.absent(),
    this.quality = const Value.absent(),
    this.unit = const Value.absent(),
    this.grossQuantity = const Value.absent(),
    this.wasteQuantity = const Value.absent(),
    this.netQuantity = const Value.absent(),
    this.wastePercentage = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.notes = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchasesTableCompanion.insert({
    this.id = const Value.absent(),
    required String materialType,
    required String quality,
    this.unit = const Value.absent(),
    required double grossQuantity,
    this.wasteQuantity = const Value.absent(),
    required double netQuantity,
    this.wastePercentage = const Value.absent(),
    required double unitPrice,
    required double totalCost,
    this.supplierName = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime purchaseDate,
    this.createdAt = const Value.absent(),
  }) : materialType = Value(materialType),
       quality = Value(quality),
       grossQuantity = Value(grossQuantity),
       netQuantity = Value(netQuantity),
       unitPrice = Value(unitPrice),
       totalCost = Value(totalCost),
       purchaseDate = Value(purchaseDate);
  static Insertable<PurchasesTableData> custom({
    Expression<int>? id,
    Expression<String>? materialType,
    Expression<String>? quality,
    Expression<String>? unit,
    Expression<double>? grossQuantity,
    Expression<double>? wasteQuantity,
    Expression<double>? netQuantity,
    Expression<double>? wastePercentage,
    Expression<double>? unitPrice,
    Expression<double>? totalCost,
    Expression<String>? supplierName,
    Expression<String>? notes,
    Expression<DateTime>? purchaseDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (materialType != null) 'material_type': materialType,
      if (quality != null) 'quality': quality,
      if (unit != null) 'unit': unit,
      if (grossQuantity != null) 'gross_quantity': grossQuantity,
      if (wasteQuantity != null) 'waste_quantity': wasteQuantity,
      if (netQuantity != null) 'net_quantity': netQuantity,
      if (wastePercentage != null) 'waste_percentage': wastePercentage,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalCost != null) 'total_cost': totalCost,
      if (supplierName != null) 'supplier_name': supplierName,
      if (notes != null) 'notes': notes,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchasesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? materialType,
    Value<String>? quality,
    Value<String>? unit,
    Value<double>? grossQuantity,
    Value<double>? wasteQuantity,
    Value<double>? netQuantity,
    Value<double>? wastePercentage,
    Value<double>? unitPrice,
    Value<double>? totalCost,
    Value<String?>? supplierName,
    Value<String?>? notes,
    Value<DateTime>? purchaseDate,
    Value<DateTime>? createdAt,
  }) {
    return PurchasesTableCompanion(
      id: id ?? this.id,
      materialType: materialType ?? this.materialType,
      quality: quality ?? this.quality,
      unit: unit ?? this.unit,
      grossQuantity: grossQuantity ?? this.grossQuantity,
      wasteQuantity: wasteQuantity ?? this.wasteQuantity,
      netQuantity: netQuantity ?? this.netQuantity,
      wastePercentage: wastePercentage ?? this.wastePercentage,
      unitPrice: unitPrice ?? this.unitPrice,
      totalCost: totalCost ?? this.totalCost,
      supplierName: supplierName ?? this.supplierName,
      notes: notes ?? this.notes,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (materialType.present) {
      map['material_type'] = Variable<String>(materialType.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (grossQuantity.present) {
      map['gross_quantity'] = Variable<double>(grossQuantity.value);
    }
    if (wasteQuantity.present) {
      map['waste_quantity'] = Variable<double>(wasteQuantity.value);
    }
    if (netQuantity.present) {
      map['net_quantity'] = Variable<double>(netQuantity.value);
    }
    if (wastePercentage.present) {
      map['waste_percentage'] = Variable<double>(wastePercentage.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesTableCompanion(')
          ..write('id: $id, ')
          ..write('materialType: $materialType, ')
          ..write('quality: $quality, ')
          ..write('unit: $unit, ')
          ..write('grossQuantity: $grossQuantity, ')
          ..write('wasteQuantity: $wasteQuantity, ')
          ..write('netQuantity: $netQuantity, ')
          ..write('wastePercentage: $wastePercentage, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalCost: $totalCost, ')
          ..write('supplierName: $supplierName, ')
          ..write('notes: $notes, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WasteRecordsTableTable extends WasteRecordsTable
    with TableInfo<$WasteRecordsTableTable, WasteRecordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WasteRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchases_table (id)',
    ),
  );
  static const VerificationMeta _materialTypeMeta = const VerificationMeta(
    'materialType',
  );
  @override
  late final GeneratedColumn<String> materialType = GeneratedColumn<String>(
    'material_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasteAmountMeta = const VerificationMeta(
    'wasteAmount',
  );
  @override
  late final GeneratedColumn<double> wasteAmount = GeneratedColumn<double>(
    'waste_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kg'),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    materialType,
    wasteAmount,
    unit,
    reason,
    notes,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'waste_records_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WasteRecordsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('material_type')) {
      context.handle(
        _materialTypeMeta,
        materialType.isAcceptableOrUnknown(
          data['material_type']!,
          _materialTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materialTypeMeta);
    }
    if (data.containsKey('waste_amount')) {
      context.handle(
        _wasteAmountMeta,
        wasteAmount.isAcceptableOrUnknown(
          data['waste_amount']!,
          _wasteAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wasteAmountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WasteRecordsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WasteRecordsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      ),
      materialType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_type'],
      )!,
      wasteAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waste_amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $WasteRecordsTableTable createAlias(String alias) {
    return $WasteRecordsTableTable(attachedDatabase, alias);
  }
}

class WasteRecordsTableData extends DataClass
    implements Insertable<WasteRecordsTableData> {
  final int id;
  final int? purchaseId;
  final String materialType;
  final double wasteAmount;
  final String unit;
  final String reason;
  final String? notes;
  final DateTime recordedAt;
  const WasteRecordsTableData({
    required this.id,
    this.purchaseId,
    required this.materialType,
    required this.wasteAmount,
    required this.unit,
    required this.reason,
    this.notes,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<int>(purchaseId);
    }
    map['material_type'] = Variable<String>(materialType);
    map['waste_amount'] = Variable<double>(wasteAmount);
    map['unit'] = Variable<String>(unit);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  WasteRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return WasteRecordsTableCompanion(
      id: Value(id),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      materialType: Value(materialType),
      wasteAmount: Value(wasteAmount),
      unit: Value(unit),
      reason: Value(reason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      recordedAt: Value(recordedAt),
    );
  }

  factory WasteRecordsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WasteRecordsTableData(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int?>(json['purchaseId']),
      materialType: serializer.fromJson<String>(json['materialType']),
      wasteAmount: serializer.fromJson<double>(json['wasteAmount']),
      unit: serializer.fromJson<String>(json['unit']),
      reason: serializer.fromJson<String>(json['reason']),
      notes: serializer.fromJson<String?>(json['notes']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int?>(purchaseId),
      'materialType': serializer.toJson<String>(materialType),
      'wasteAmount': serializer.toJson<double>(wasteAmount),
      'unit': serializer.toJson<String>(unit),
      'reason': serializer.toJson<String>(reason),
      'notes': serializer.toJson<String?>(notes),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  WasteRecordsTableData copyWith({
    int? id,
    Value<int?> purchaseId = const Value.absent(),
    String? materialType,
    double? wasteAmount,
    String? unit,
    String? reason,
    Value<String?> notes = const Value.absent(),
    DateTime? recordedAt,
  }) => WasteRecordsTableData(
    id: id ?? this.id,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    materialType: materialType ?? this.materialType,
    wasteAmount: wasteAmount ?? this.wasteAmount,
    unit: unit ?? this.unit,
    reason: reason ?? this.reason,
    notes: notes.present ? notes.value : this.notes,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  WasteRecordsTableData copyWithCompanion(WasteRecordsTableCompanion data) {
    return WasteRecordsTableData(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      materialType: data.materialType.present
          ? data.materialType.value
          : this.materialType,
      wasteAmount: data.wasteAmount.present
          ? data.wasteAmount.value
          : this.wasteAmount,
      unit: data.unit.present ? data.unit.value : this.unit,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WasteRecordsTableData(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('materialType: $materialType, ')
          ..write('wasteAmount: $wasteAmount, ')
          ..write('unit: $unit, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    materialType,
    wasteAmount,
    unit,
    reason,
    notes,
    recordedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WasteRecordsTableData &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.materialType == this.materialType &&
          other.wasteAmount == this.wasteAmount &&
          other.unit == this.unit &&
          other.reason == this.reason &&
          other.notes == this.notes &&
          other.recordedAt == this.recordedAt);
}

class WasteRecordsTableCompanion
    extends UpdateCompanion<WasteRecordsTableData> {
  final Value<int> id;
  final Value<int?> purchaseId;
  final Value<String> materialType;
  final Value<double> wasteAmount;
  final Value<String> unit;
  final Value<String> reason;
  final Value<String?> notes;
  final Value<DateTime> recordedAt;
  const WasteRecordsTableCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.materialType = const Value.absent(),
    this.wasteAmount = const Value.absent(),
    this.unit = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  WasteRecordsTableCompanion.insert({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    required String materialType,
    required double wasteAmount,
    this.unit = const Value.absent(),
    required String reason,
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
  }) : materialType = Value(materialType),
       wasteAmount = Value(wasteAmount),
       reason = Value(reason);
  static Insertable<WasteRecordsTableData> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<String>? materialType,
    Expression<double>? wasteAmount,
    Expression<String>? unit,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (materialType != null) 'material_type': materialType,
      if (wasteAmount != null) 'waste_amount': wasteAmount,
      if (unit != null) 'unit': unit,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  WasteRecordsTableCompanion copyWith({
    Value<int>? id,
    Value<int?>? purchaseId,
    Value<String>? materialType,
    Value<double>? wasteAmount,
    Value<String>? unit,
    Value<String>? reason,
    Value<String?>? notes,
    Value<DateTime>? recordedAt,
  }) {
    return WasteRecordsTableCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      materialType: materialType ?? this.materialType,
      wasteAmount: wasteAmount ?? this.wasteAmount,
      unit: unit ?? this.unit,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (materialType.present) {
      map['material_type'] = Variable<String>(materialType.value);
    }
    if (wasteAmount.present) {
      map['waste_amount'] = Variable<double>(wasteAmount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WasteRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('materialType: $materialType, ')
          ..write('wasteAmount: $wasteAmount, ')
          ..write('unit: $unit, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MaterialsTableTable materialsTable = $MaterialsTableTable(this);
  late final $PurchasesTableTable purchasesTable = $PurchasesTableTable(this);
  late final $WasteRecordsTableTable wasteRecordsTable =
      $WasteRecordsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    materialsTable,
    purchasesTable,
    wasteRecordsTable,
  ];
}

typedef $$MaterialsTableTableCreateCompanionBuilder =
    MaterialsTableCompanion Function({
      Value<int> id,
      required String name,
      required String materialType,
      Value<String> defaultUnit,
      Value<double> defaultPricePerUnit,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$MaterialsTableTableUpdateCompanionBuilder =
    MaterialsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> materialType,
      Value<String> defaultUnit,
      Value<double> defaultPricePerUnit,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

class $$MaterialsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MaterialsTableTable> {
  $$MaterialsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultPricePerUnit => $composableBuilder(
    column: $table.defaultPricePerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MaterialsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MaterialsTableTable> {
  $$MaterialsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultPricePerUnit => $composableBuilder(
    column: $table.defaultPricePerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaterialsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaterialsTableTable> {
  $$MaterialsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultUnit => $composableBuilder(
    column: $table.defaultUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultPricePerUnit => $composableBuilder(
    column: $table.defaultPricePerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MaterialsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaterialsTableTable,
          MaterialsTableData,
          $$MaterialsTableTableFilterComposer,
          $$MaterialsTableTableOrderingComposer,
          $$MaterialsTableTableAnnotationComposer,
          $$MaterialsTableTableCreateCompanionBuilder,
          $$MaterialsTableTableUpdateCompanionBuilder,
          (
            MaterialsTableData,
            BaseReferences<
              _$AppDatabase,
              $MaterialsTableTable,
              MaterialsTableData
            >,
          ),
          MaterialsTableData,
          PrefetchHooks Function()
        > {
  $$MaterialsTableTableTableManager(
    _$AppDatabase db,
    $MaterialsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaterialsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaterialsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaterialsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> materialType = const Value.absent(),
                Value<String> defaultUnit = const Value.absent(),
                Value<double> defaultPricePerUnit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaterialsTableCompanion(
                id: id,
                name: name,
                materialType: materialType,
                defaultUnit: defaultUnit,
                defaultPricePerUnit: defaultPricePerUnit,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String materialType,
                Value<String> defaultUnit = const Value.absent(),
                Value<double> defaultPricePerUnit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaterialsTableCompanion.insert(
                id: id,
                name: name,
                materialType: materialType,
                defaultUnit: defaultUnit,
                defaultPricePerUnit: defaultPricePerUnit,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaterialsTableTable, MaterialsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MaterialsTableTable,
                    MaterialsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaterialsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaterialsTableTable,
      MaterialsTableData,
      $$MaterialsTableTableFilterComposer,
      $$MaterialsTableTableOrderingComposer,
      $$MaterialsTableTableAnnotationComposer,
      $$MaterialsTableTableCreateCompanionBuilder,
      $$MaterialsTableTableUpdateCompanionBuilder,
      (
        MaterialsTableData,
        BaseReferences<_$AppDatabase, $MaterialsTableTable, MaterialsTableData>,
      ),
      MaterialsTableData,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableTableCreateCompanionBuilder =
    PurchasesTableCompanion Function({
      Value<int> id,
      required String materialType,
      required String quality,
      Value<String> unit,
      required double grossQuantity,
      Value<double> wasteQuantity,
      required double netQuantity,
      Value<double> wastePercentage,
      required double unitPrice,
      required double totalCost,
      Value<String?> supplierName,
      Value<String?> notes,
      required DateTime purchaseDate,
      Value<DateTime> createdAt,
    });
typedef $$PurchasesTableTableUpdateCompanionBuilder =
    PurchasesTableCompanion Function({
      Value<int> id,
      Value<String> materialType,
      Value<String> quality,
      Value<String> unit,
      Value<double> grossQuantity,
      Value<double> wasteQuantity,
      Value<double> netQuantity,
      Value<double> wastePercentage,
      Value<double> unitPrice,
      Value<double> totalCost,
      Value<String?> supplierName,
      Value<String?> notes,
      Value<DateTime> purchaseDate,
      Value<DateTime> createdAt,
    });

final class $$PurchasesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchasesTableTable,
          PurchasesTableData
        > {
  $$PurchasesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WasteRecordsTableTable,
    List<WasteRecordsTableData>
  >
  _wasteRecordsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.wasteRecordsTable,
        aliasName: 'purchases_table__id__waste_records_table__purchase_id',
      );

  $$WasteRecordsTableTableProcessedTableManager get wasteRecordsTableRefs {
    final manager = $$WasteRecordsTableTableTableManager(
      $_db,
      $_db.wasteRecordsTable,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _wasteRecordsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchasesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTableTable> {
  $$PurchasesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossQuantity => $composableBuilder(
    column: $table.grossQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wasteQuantity => $composableBuilder(
    column: $table.wasteQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netQuantity => $composableBuilder(
    column: $table.netQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wastePercentage => $composableBuilder(
    column: $table.wastePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wasteRecordsTableRefs(
    Expression<bool> Function($$WasteRecordsTableTableFilterComposer f) f,
  ) {
    final $$WasteRecordsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wasteRecordsTable,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WasteRecordsTableTableFilterComposer(
            $db: $db,
            $table: $db.wasteRecordsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTableTable> {
  $$PurchasesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossQuantity => $composableBuilder(
    column: $table.grossQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wasteQuantity => $composableBuilder(
    column: $table.wasteQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netQuantity => $composableBuilder(
    column: $table.netQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wastePercentage => $composableBuilder(
    column: $table.wastePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTableTable> {
  $$PurchasesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get grossQuantity => $composableBuilder(
    column: $table.grossQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wasteQuantity => $composableBuilder(
    column: $table.wasteQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netQuantity => $composableBuilder(
    column: $table.netQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wastePercentage => $composableBuilder(
    column: $table.wastePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> wasteRecordsTableRefs<T extends Object>(
    Expression<T> Function($$WasteRecordsTableTableAnnotationComposer a) f,
  ) {
    final $$WasteRecordsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.wasteRecordsTable,
          getReferencedColumn: (t) => t.purchaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WasteRecordsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.wasteRecordsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PurchasesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTableTable,
          PurchasesTableData,
          $$PurchasesTableTableFilterComposer,
          $$PurchasesTableTableOrderingComposer,
          $$PurchasesTableTableAnnotationComposer,
          $$PurchasesTableTableCreateCompanionBuilder,
          $$PurchasesTableTableUpdateCompanionBuilder,
          (PurchasesTableData, $$PurchasesTableTableReferences),
          PurchasesTableData,
          PrefetchHooks Function({bool wasteRecordsTableRefs})
        > {
  $$PurchasesTableTableTableManager(
    _$AppDatabase db,
    $PurchasesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> materialType = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> grossQuantity = const Value.absent(),
                Value<double> wasteQuantity = const Value.absent(),
                Value<double> netQuantity = const Value.absent(),
                Value<double> wastePercentage = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<String?> supplierName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesTableCompanion(
                id: id,
                materialType: materialType,
                quality: quality,
                unit: unit,
                grossQuantity: grossQuantity,
                wasteQuantity: wasteQuantity,
                netQuantity: netQuantity,
                wastePercentage: wastePercentage,
                unitPrice: unitPrice,
                totalCost: totalCost,
                supplierName: supplierName,
                notes: notes,
                purchaseDate: purchaseDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String materialType,
                required String quality,
                Value<String> unit = const Value.absent(),
                required double grossQuantity,
                Value<double> wasteQuantity = const Value.absent(),
                required double netQuantity,
                Value<double> wastePercentage = const Value.absent(),
                required double unitPrice,
                required double totalCost,
                Value<String?> supplierName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime purchaseDate,
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesTableCompanion.insert(
                id: id,
                materialType: materialType,
                quality: quality,
                unit: unit,
                grossQuantity: grossQuantity,
                wasteQuantity: wasteQuantity,
                netQuantity: netQuantity,
                wastePercentage: wastePercentage,
                unitPrice: unitPrice,
                totalCost: totalCost,
                supplierName: supplierName,
                notes: notes,
                purchaseDate: purchaseDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PurchasesTableTable, PurchasesTableData>(table),
                  $$PurchasesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wasteRecordsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (wasteRecordsTableRefs) db.wasteRecordsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wasteRecordsTableRefs)
                    await $_getPrefetchedDataByColumns<
                      PurchasesTableData,
                      $PurchasesTableTable,
                      WasteRecordsTableData,
                      $WasteRecordsTableTable
                    >(
                      currentTable: table,
                      referencedTable: $$PurchasesTableTableReferences
                          ._wasteRecordsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PurchasesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).wasteRecordsTableRefs,
                      currentColumn: 'id',
                      referencedColumn: 'purchase_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PurchasesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTableTable,
      PurchasesTableData,
      $$PurchasesTableTableFilterComposer,
      $$PurchasesTableTableOrderingComposer,
      $$PurchasesTableTableAnnotationComposer,
      $$PurchasesTableTableCreateCompanionBuilder,
      $$PurchasesTableTableUpdateCompanionBuilder,
      (PurchasesTableData, $$PurchasesTableTableReferences),
      PurchasesTableData,
      PrefetchHooks Function({bool wasteRecordsTableRefs})
    >;
typedef $$WasteRecordsTableTableCreateCompanionBuilder =
    WasteRecordsTableCompanion Function({
      Value<int> id,
      Value<int?> purchaseId,
      required String materialType,
      required double wasteAmount,
      Value<String> unit,
      required String reason,
      Value<String?> notes,
      Value<DateTime> recordedAt,
    });
typedef $$WasteRecordsTableTableUpdateCompanionBuilder =
    WasteRecordsTableCompanion Function({
      Value<int> id,
      Value<int?> purchaseId,
      Value<String> materialType,
      Value<double> wasteAmount,
      Value<String> unit,
      Value<String> reason,
      Value<String?> notes,
      Value<DateTime> recordedAt,
    });

final class $$WasteRecordsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WasteRecordsTableTable,
          WasteRecordsTableData
        > {
  $$WasteRecordsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchasesTableTable _purchaseIdTable(_$AppDatabase db) => db
      .purchasesTable
      .createAlias('waste_records_table__purchase_id__purchases_table__id');

  $$PurchasesTableTableProcessedTableManager? get purchaseId {
    final $_column = $_itemColumn<int>('purchase_id');
    if ($_column == null) return null;
    final manager = $$PurchasesTableTableTableManager(
      $_db,
      $_db.purchasesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WasteRecordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WasteRecordsTableTable> {
  $$WasteRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wasteAmount => $composableBuilder(
    column: $table.wasteAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchasesTableTableFilterComposer get purchaseId {
    final $$PurchasesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchasesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableTableFilterComposer(
            $db: $db,
            $table: $db.purchasesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WasteRecordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WasteRecordsTableTable> {
  $$WasteRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wasteAmount => $composableBuilder(
    column: $table.wasteAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchasesTableTableOrderingComposer get purchaseId {
    final $$PurchasesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchasesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableTableOrderingComposer(
            $db: $db,
            $table: $db.purchasesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WasteRecordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WasteRecordsTableTable> {
  $$WasteRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get materialType => $composableBuilder(
    column: $table.materialType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wasteAmount => $composableBuilder(
    column: $table.wasteAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  $$PurchasesTableTableAnnotationComposer get purchaseId {
    final $$PurchasesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchasesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.purchasesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WasteRecordsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WasteRecordsTableTable,
          WasteRecordsTableData,
          $$WasteRecordsTableTableFilterComposer,
          $$WasteRecordsTableTableOrderingComposer,
          $$WasteRecordsTableTableAnnotationComposer,
          $$WasteRecordsTableTableCreateCompanionBuilder,
          $$WasteRecordsTableTableUpdateCompanionBuilder,
          (WasteRecordsTableData, $$WasteRecordsTableTableReferences),
          WasteRecordsTableData,
          PrefetchHooks Function({bool purchaseId})
        > {
  $$WasteRecordsTableTableTableManager(
    _$AppDatabase db,
    $WasteRecordsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WasteRecordsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WasteRecordsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WasteRecordsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                Value<String> materialType = const Value.absent(),
                Value<double> wasteAmount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => WasteRecordsTableCompanion(
                id: id,
                purchaseId: purchaseId,
                materialType: materialType,
                wasteAmount: wasteAmount,
                unit: unit,
                reason: reason,
                notes: notes,
                recordedAt: recordedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                required String materialType,
                required double wasteAmount,
                Value<String> unit = const Value.absent(),
                required String reason,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => WasteRecordsTableCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                materialType: materialType,
                wasteAmount: wasteAmount,
                unit: unit,
                reason: reason,
                notes: notes,
                recordedAt: recordedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WasteRecordsTableTable, WasteRecordsTableData>(
                    table,
                  ),
                  $$WasteRecordsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (purchaseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.purchaseId,
                        referencedTable: $$WasteRecordsTableTableReferences
                            ._purchaseIdTable(db),
                        referencedColumn: $$WasteRecordsTableTableReferences
                            ._purchaseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WasteRecordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WasteRecordsTableTable,
      WasteRecordsTableData,
      $$WasteRecordsTableTableFilterComposer,
      $$WasteRecordsTableTableOrderingComposer,
      $$WasteRecordsTableTableAnnotationComposer,
      $$WasteRecordsTableTableCreateCompanionBuilder,
      $$WasteRecordsTableTableUpdateCompanionBuilder,
      (WasteRecordsTableData, $$WasteRecordsTableTableReferences),
      WasteRecordsTableData,
      PrefetchHooks Function({bool purchaseId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MaterialsTableTableTableManager get materialsTable =>
      $$MaterialsTableTableTableManager(_db, _db.materialsTable);
  $$PurchasesTableTableTableManager get purchasesTable =>
      $$PurchasesTableTableTableManager(_db, _db.purchasesTable);
  $$WasteRecordsTableTableTableManager get wasteRecordsTable =>
      $$WasteRecordsTableTableTableManager(_db, _db.wasteRecordsTable);
}
