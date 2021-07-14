import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

extension MappableDocumentSnapshot on DocumentSnapshot<Map<String, dynamic>> {
  T? mapObject<T>() {
    if (!exists || this.data() == null) {
      return null;
    }
    final data = this.data();
    data!['id'] = id;
    return JsonMapper.fromMap<T>(data);
  }
}

extension MappableQuerySnapshot on QuerySnapshot<Map<String, dynamic>> {
  List<T> mapList<T>() {
    return docs
        .map((doc) => doc.mapObject<T>())
        .where((e) => e != null)
        .map((e) => e!)
        .toList();
  }
}
