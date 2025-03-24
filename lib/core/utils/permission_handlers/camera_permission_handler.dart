import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../translations/locale_keys.g.dart';
import '../../../widgets/dialogs/adaptive_alert_dialog.dart';

class CameraPermissionHandler {
  // Handle camera permission
  static Future<void> handlePermission({
    required BuildContext context,
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
  }) async {
    // Check camera permission status
    PermissionStatus cameraStatus = await Permission.camera.status;
    print("Camera Permission Status: $cameraStatus");

    if (cameraStatus.isGranted) {
      // If permission is granted, execute onPermissionGranted callback
      onPermissionGranted();
    } else if (cameraStatus.isDenied) {
      // Request permission if it's denied
      PermissionStatus newCameraStatus = await Permission.camera.request();
      print("New Camera Permission Status: $newCameraStatus");

      if (newCameraStatus.isGranted) {
        // If the permission is granted, execute onPermissionGranted callback
        onPermissionGranted();
      } else if (newCameraStatus.isPermanentlyDenied) {
        // If the permission is permanently denied, redirect to settings
        print("Camera permission permanently denied. Redirecting to settings...");
        _showPermissionDialog(context);
        // onPermissionDenied();
      } else {
        onPermissionDenied();
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      print("Camera permission permanently denied. Redirecting to settings...");
      _showPermissionDialog(context);
      // onPermissionDenied();
    } else {
      onPermissionDenied();
    }
  }

  // Show dialog for camera permission
  static _showPermissionDialog(BuildContext context) {
    AdaptiveAlertDialog.show(context,
      title: LocaleKeys.cameraPermissionRequired.tr(),
      content: LocaleKeys.cameraAccessIsRequiredToSecurelyCaptureYourPictureForVerificationDuringTheSignInAndSignUpProcess.tr(),
      yesButtonTitle: LocaleKeys.settings.tr(),
      noButtonTitle: LocaleKeys.cancel.tr(),
      onYesPressed: () async {
        await openAppSettings(); // Redirect user to settings
      },
      onNoPressed: () {},
    );
  }
}
