import '../entities/material_entity.dart';

abstract class MaterialsRepository {
  Stream<List<MaterialEntity>> watchMaterials();
  Future<List<MaterialEntity>> getMaterials();
}
