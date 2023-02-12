import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../data/base_mapper.dart';
import '../data/local/base_hive_storage.dart';
import '../data/model/base_hive_object.dart';

export 'package:get/instance_manager.dart';
export 'package:jbbase_app/utils/config/app_config.dart';

export '../data/base_mapper.dart';
export '../data/local/local_storage.dart';

abstract class BaseMappingRepo<Entity, Model> extends GetxService {
  final mapper = BaseMapper<Entity, Model>();

  Entity mappingEntity(Model model) {
    return mapper.mappingEntity(model);
  }

  Model mappingModel(Entity entity) {
    return mapper.mappingModel(entity);
  }
}

abstract class BaseCRUDRepo<Entity> {
  Future<int> add(Entity e);

  Future<List<int>> addAll(List<Entity> es);

  Future<Entity?> getById(int id);

  Future<List<Entity>> getAll();

  Future<void> update(Entity e);

  Future<void> updateAll(List<Entity> es);

  Future<void> delete(Entity e);

  Future<void> deleteAll(List<Entity> es);

  Future<void> clear();
}

abstract class BaseHiveCRUDRepo<Entity> extends BaseCRUDRepo<Entity> {
  Stream<BoxEvent> watch({dynamic key});
}

abstract class BaseHiveRepo<Entity, Model extends BaseHiveObject, HiveStorage extends BaseHiveStorage<Model>>
    extends BaseMappingRepo<Entity, Model> implements BaseHiveCRUDRepo<Entity> {
  late HiveStorage storage;

  @override
  void onInit() {
    super.onInit();
    storage = Get.find<HiveStorage>();
  }

  @override
  Future<int> add(Entity e) {
    return storage.add(mappingModel(e));
  }

  @override
  Future<List<int>> addAll(List<Entity> es) {
    return storage.addAll(es.map(mappingModel).toList());
  }

  @override
  Future<Entity?> getById(int id) async {
    final m = await storage.getById(id);
    return m == null ? null : mappingEntity(m);
  }

  @override
  Future<List<Entity>> getAll() async {
    return (await storage.getAll()).map(mappingEntity).toList();
  }

  @override
  Future<void> update(Entity e) {
    return storage.update(mappingModel(e));
  }

  @override
  Future<void> updateAll(List<Entity> es) {
    return storage.updateAll(es.map(mappingModel).toList());
  }

  @override
  Future<void> delete(Entity e) {
    return storage.delete(mappingModel(e));
  }

  @override
  Future<void> deleteAll(List<Entity> es) {
    return storage.deleteAll(es.map(mappingModel).toList());
  }

  @override
  Future<void> clear() {
    return storage.clear();
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    return storage.watch().map(
          (e) => BoxEvent(
            e.key,
            e.value == null ? null : mappingEntity(e.value..id = e.key),
            e.deleted,
          ),
        );
  }
}
