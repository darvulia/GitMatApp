import '../entities/waste_entry.dart';

abstract class WasteRepository {
  Stream<List<WasteEntry>> watchWasteRecords();
  Future<List<WasteEntry>> getWasteRecords();
  Future<int> insertWasteRecord(WasteEntry entry);
  Future<int> deleteWasteRecord(int id);
}
