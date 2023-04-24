import 'package:hive/hive.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:uuid/uuid.dart';

abstract class IHiveBoxRepository<T extends HiveObject> {
  Future<Box<T>> openBox();

  bool get openned;

  Future<String?> deleteKey(dynamic key);

  Future clear();

  Future<String?> add(T model);

  Future<String?> update(dynamic key, T model);

  List<T> getAll();
  Future<List<T>> safeGetAll();

  int count();
  Future<int> safeCount();

  T? getKey(dynamic key);
  Future<String?> deleteAll(List<dynamic> keys);
}

class HiveBoxRepository<T extends HiveObject> extends IHiveBoxRepository<T> {
  Box<T>? box;
  String boxName = "mainBox";

  HiveBoxRepository(this.boxName) {
    openBox();
  }

  Future<Box<T>> openBox() async {
    await HiveBoxes.init();
    if (box != null) {
      return box!;
    } else {
      return box = await Hive.openBox<T>(boxName);
    }
  }

  bool get openned => box?.isOpen ?? false;

  Future<String?> deleteKey(dynamic key) async {
    await box!.delete(key);
  }

  Future<String?> deleteAll(List<dynamic> keys) async {
    await box!.deleteAll(keys);
  }

  Future clear() async {
    await box!.clear();
  }

  Future<String?> add(T model) async {
    await box!.put(Uuid().v1(), model);
  }

  Future<String?> update(dynamic key, T model) async {
    await box!.put(key, model);
  }

  List<T> getAll() {
    return box!.values.toList();
  }

  Future<List<T>> safeGetAll() async {
    await openBox();
    return box!.values.toList();
  }

  int count() {
    return box!.values.length;
  }

  Future<int> safeCount() async {
    await openBox();
    return box!.values.length;
  }

  T? getKey(dynamic key) {
    return box!.get(key);
  }
}
