import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class User {
  @JsonProperty()
  String? id;

  @JsonProperty()
  String? firstName;

  @JsonProperty()
  String? lastName;

  @JsonProperty()
  String? email;

  @JsonProperty()
  String? phoneNumber;

  @JsonProperty()
  String? avatar;

  @JsonProperty()
  String? jobDescription;

  @JsonProperty()
  bool allowShareInfo = true;

  @JsonProperty()
  bool isActive = true;

  @JsonProperty()
  DateTime? deactiveTime;

  @JsonProperty()
  String? gender;

  @JsonProperty()
  List<String> fcmTokens = [];

  //Only for locally
  bool isDeleted = false;

  @JsonProperty(converterParams: {'format': 'MM/dd/yyyy'})
  DateTime? createdDate1;

  //https://pub.dev/packages/dart_json_mapper#custom-types
  // custom type
}
