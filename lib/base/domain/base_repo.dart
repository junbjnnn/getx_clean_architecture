import '../data/base_mapper.dart';

export 'package:get/instance_manager.dart';
export 'package:jbbase_app/utils/config/app_config.dart';

export '../data/base_mapper.dart';
export '../data/local/local_storage.dart';

abstract class BaseRepo {
  Entity mappingEntity<Entity, Model>(Model model) {
    final mapper = BaseMapper<Entity, Model>();

    return mapper.mappingEntity(model);
  }
}
