import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';

@jsonSerializable
class UserModel extends Equatable {
  @JsonProperty()
  final String id;

  @JsonProperty()
  final String? firstName;

  @JsonProperty()
  final String? lastName;

  @JsonProperty()
  final String? email;

  @JsonProperty()
  final String? phoneNumber;

  @JsonProperty()
  final String? avatar;

  @JsonProperty()
  final List<String> fcmTokens = [];

  @JsonProperty(converterParams: {'format': 'MM/dd/yyyy'})
  final DateTime? createdDate;

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.createdDate,
  });

  @override
  List<Object?> get props => [id];
}
