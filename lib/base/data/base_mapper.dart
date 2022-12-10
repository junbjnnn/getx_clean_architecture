import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:jbbase_app/base/data/app_error.dart';
import 'package:jbbase_app/utils/service/log_service.dart';

class BaseMapper<E, M> {
  E buildEntityMapper(M model, E entityMapped) {
    return entityMapped;
  }

  M buildModelMapper(E entity, M modelMapped) {
    return modelMapped;
  }

  E mappingEntity(M model) {
    try {
      final E entity = _mappingFrom<E, M>(model);

      return buildEntityMapper(model, entity);
    } catch (e) {
      L.error(e);
      throw AppException(
        AppExceptionType.mapping,
        'Cannot mapping ${E.runtimeType} to ${M.runtimeType}',
        error: e,
      );
    }
  }

  M mappingModel(E entity) {
    try {
      final M model = _mappingFrom<M, E>(entity);

      return buildModelMapper(entity, model);
    } catch (e) {
      L.error(e);
      throw AppException(
        AppExceptionType.mapping,
        'Cannot mapping ${E.runtimeType} to ${M.runtimeType}',
        error: e,
      );
    }
  }

  V _mappingFrom<V, K>(K object) {
    try {
      final output = JsonMapper.deserialize<V>(JsonMapper.serialize(object));

      return output!;
    } catch (e) {
      L.error(e);
      throw AppException(
        AppExceptionType.mapping,
        'Cannot mapping ${E.runtimeType} to ${M.runtimeType}',
        error: e,
      );
    }
  }
}
