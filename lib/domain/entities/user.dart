import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';

@jsonSerializable
class User extends Equatable {
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

  const User({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [id];
}
