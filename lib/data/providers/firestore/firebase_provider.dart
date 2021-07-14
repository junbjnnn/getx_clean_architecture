import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:int_quest/base/data/firestore_snapshot_mapping.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreProvider() {
    print("init FirestoreProvider");
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}

extension BaseRequestFirestore on FirestoreProvider {
  Future<T?> getDocumentAt<T>(String path) async {
    try {
      final doc = await _firestore.doc(path).get();
      return doc.mapObject<T>();
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Stream<T?> getStreamAt<T>(String path) {
    try {
      final snapshot = _firestore.doc(path).snapshots();
      return snapshot.map((event) => event.mapObject<T>());
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Future<List<T>> getCollectionAt<T>(
    String collectionPath,
  ) async {
    try {
      QuerySnapshot<Map<String, dynamic>> collection =
          await _firestore.collection(collectionPath).get();
      return collection.mapList<T>();
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Stream<List<T>> getStreamCollectionAt<T>(String collectionPath) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
      snapshot = _firestore.collection(collectionPath).snapshots();
      return snapshot.map((event) => event.mapList<T>());
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Future<void> createDocument<T>(String docPath, T object) async {
    try {
      await _firestore.doc(docPath).set(JsonMapper.toMap(object)!);
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Future<T?> addDocumentIntoCollection<T>(
      String collectionPath, T object) async {
    try {
      final map = JsonMapper.toMap(object)!;
      return _firestore
          .collection(collectionPath)
          .add(map)
          .then((value) => value.get())
          .then((value) => value.mapObject<T>());
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Future<void> updateDocument<T>(String path, T object) async {
    try {
      await _firestore.doc(path).update(JsonMapper.toMap(object)!);
    } catch (e) {
      // TODO: Hanlde AppException
      throw e;
    }
  }

  Future<void> deleteDocument(String path) async {
    try {
      await _firestore.doc(path).delete();
    } catch (e) {
      throw e;
    }
  }
}
