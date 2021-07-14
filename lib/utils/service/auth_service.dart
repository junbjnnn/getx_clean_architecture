import 'package:get/get.dart';
import 'package:int_quest/data/providers/local/storage_provider.dart';

class AuthService extends GetxService {
  final StorageProvider _storageProvider = Get.find();

  bool hasLogin() => true;
}
