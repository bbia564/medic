import 'package:flutter/material.dart';
import 'package:medication_record/widgets/camera_permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> checkAndRequestCameraPermissions(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      final requestStatus = await Permission.camera.request();
      if (requestStatus.isPermanentlyDenied) {
        // await openAppSettings();
        showDialog(
            context: context,
            builder: (context) {
              return CameraPermissionDialog(
                callback: () async {
                  await openAppSettings();
                },
              );
            });
        return false;
      }
      return requestStatus.isGranted;
    } else if (status.isGranted) {
      return true;
    }
    return false;
  }

  Future<bool> checkAndRequestPhotoPermissions(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      final requestStatus = await Permission.camera.request();
      if (requestStatus.isPermanentlyDenied) {
        showDialog(
            context: context,
            builder: (context) {
              return CameraPermissionDialog(
                callback: () async {
                  await openAppSettings();
                },
              );
            });
        return false;
      }
      return requestStatus.isGranted;
    } else if (status.isGranted) {
      return true;
    }
    return false;
  }
}
