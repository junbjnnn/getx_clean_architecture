import 'package:int_quest/domain/models/user.dart';

import 'firebase_provider.dart';

class UserProvider extends FirestoreProvider {
  final String _userPath = "/users";

  Future<User?> getUser(String id) {
    try {
      return getDocumentAt("$_userPath/$id");
    } catch (e) {
      throw e;
    }
  }

  Future<List<User>> getAllUser() {
    try {
      return getCollectionAt("$_userPath");
    } catch (e) {
      throw e;
    }
  }
}
