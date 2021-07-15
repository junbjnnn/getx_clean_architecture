import 'package:int_quest/data/models/user_model.dart';

import 'firebase_provider.dart';

class UserProvider extends FirestoreProvider {
  final String _userPath = "/users";

  Future<UserModel?> getUser(String id) {
    try {
      return getDocumentAt("$_userPath/$id");
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUser() {
    try {
      return getCollectionAt(_userPath);
    } catch (e) {
      rethrow;
    }
  }
}
