import 'package:jbbase_app/base/data/model/pretty_json_mixin.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true, name: 'data')
class UserModel extends HiveObject with PrettyJsonMixin {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  int? age;

  @HiveField(3)
  List<String>? friends;

  @override
  @JsonProperty(ignore: true)
  BoxBase? get box;
}
