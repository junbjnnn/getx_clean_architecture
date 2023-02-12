import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jbbase_app/base/data/model/base_hive_object.dart';

abstract class BaseHiveStorage<M extends BaseHiveObject> extends GetxService {
  late Box<M> box;

  String get _boxName => M.toString();

  @override
  Future<void> onInit() async {
    super.onInit();
    openBoxIfNeeded();
  }

  Future<void> openBoxIfNeeded() async {
    if (!Hive.isBoxOpen(_boxName)) {
      box = await Hive.openBox<M>(_boxName);
    }
  }

  Future<int> add(M m) async {
    await openBoxIfNeeded();
    return box.add(m);
  }

  Future<List<int>> addAll(List<M> ms) async {
    await openBoxIfNeeded();

    final ids = (await box.addAll(ms)).toList();
    for (var i = 0; i < ids.length; i++) {
      ms[i].id = ids[i];
    }
    return ids;
  }

  Future<M?> getById(int id) async {
    await openBoxIfNeeded();
    return box.get(id);
  }

  Future<List<M>> getAll() async {
    await openBoxIfNeeded();
    return box.keys.map((e) => box.get(e)?..id = e).whereType<M>().toList();
  }

  Future<void> update(M m) async {
    await openBoxIfNeeded();
    return box.put(m.id ?? 0, m);
  }

  Future<void> updateAll(List<M> ms) async {
    await openBoxIfNeeded();
    final map = {for (var m in ms) m.id: m};
    return box.putAll(map);
  }

  Future<void> delete(M m) async {
    await openBoxIfNeeded();
    return box.delete(m.id);
  }

  Future<void> deleteAll(List<M> ms) async {
    await openBoxIfNeeded();
    return box.deleteAll(ms.map((e) => e.id));
  }

  Future<void> clear() async {
    await openBoxIfNeeded();
    await box.clear();
  }

  Stream<BoxEvent> watch({dynamic key}) {
    return box.watch(key: key);
  }
}
