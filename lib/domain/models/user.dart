import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class User {
  @JsonProperty(name: 'id')
  String? id;

  @JsonProperty(name: 'firstName')
  String? firstName;

  @JsonProperty(name: 'lastName')
  String? lastName;

  @JsonProperty(name: 'email')
  String? email;

  @JsonProperty(name: 'phoneNumber')
  String? phoneNumber;

  @JsonProperty(name: 'avatar')
  String? avatar;

  @JsonProperty(name: 'jobDescription')
  String? jobDescription;

  @JsonProperty(name: 'allowShareInfo')
  bool allowShareInfo = true;

  @JsonProperty(name: 'isActive')
  bool isActive = true;

  @JsonProperty(name: 'deactiveTime')
  DateTime? deactiveTime;

  @JsonProperty(name: 'gender')
  String? gender;

  List<String> _fcmTokens = [];

  @JsonProperty(name: 'fcmTokens')
  void setLastName(dynamic value) {
    _fcmTokens = value;
  }

  @JsonProperty(name: 'fcmTokens')
  List<String> getFcmTokens() => _fcmTokens;
  // List<String> get fcmTokens => _fcmTokens;

  //Only for locally
  bool isDeleted = false;

  @JsonProperty(converterParams: {'format': 'MM-dd-yyyy H:m:s'})
  DateTime? lastPromotionDate = DateTime(2008, 05, 13, 22, 33, 44);

  @JsonProperty(converterParams: {'format': 'MM/dd/yyyy'})
  DateTime? hireDate = DateTime(2003, 02, 28);

  //https://pub.dev/packages/dart_json_mapper#custom-types
  // custom type
}
