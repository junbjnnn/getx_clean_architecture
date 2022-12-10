import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService extends GetxService {
  Future<bool> requestPhotosPermission();
  Future<bool> requestCameraPermission();
  Future<bool> requestStoragePermission();
  Future<bool> openAppSetting();
}

class PermissionServiceImpl extends PermissionService {
  @override
  Future<bool> requestPhotosPermission() async {
    if ((await Permission.photos.isGranted) || (await Permission.photosAddOnly.isGranted)) {
      return true;
    }
    final status = await Permission.photos.request();

    return status == PermissionStatus.granted || status == PermissionStatus.limited;
  }

  @override
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();

    return status == PermissionStatus.granted;
  }

  @override
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();

    return status == PermissionStatus.granted;
  }

  @override
  Future<bool> openAppSetting() {
    return openAppSettings();
  }
}
