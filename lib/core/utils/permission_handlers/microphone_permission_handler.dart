import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../translations/locale_keys.g.dart';
import '../../widgets/dialogs/adaptive_alert_dialog.dart';

class MicrophonePermissionHandler {
  // Handle microphone permission
  static Future<void> handlePermission({
    required BuildContext context,
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
  }) async {
    // Check microphone permission status
    PermissionStatus microphoneStatus = await Permission.microphone.status;
    print("Microphone Permission Status: $microphoneStatus");

    if (microphoneStatus.isGranted) {
      // If permission is granted, execute onPermissionGranted callback
      onPermissionGranted();
    } else if (microphoneStatus.isDenied) {
      // Request permission if it's denied
      PermissionStatus newMicrophoneStatus = await Permission.microphone.request();
      print("New Microphone Permission Status: $newMicrophoneStatus");

      if (newMicrophoneStatus.isGranted) {
        // If the permission is granted, execute onPermissionGranted callback
        onPermissionGranted();
      } else if (newMicrophoneStatus.isPermanentlyDenied) {
        // If the permission is permanently denied, redirect to settings
        print("Microphone permission permanently denied. Redirecting to settings...");
        _showPermissionDialog(context);
        // onPermissionDenied();
      } else {
        onPermissionDenied();
      }
    } else if (microphoneStatus.isPermanentlyDenied) {
      print("Microphone permission permanently denied. Redirecting to settings...");
      _showPermissionDialog(context);
      // onPermissionDenied();
    } else {
      onPermissionDenied();
    }
  }

  // Show dialog for microphone permission
  static _showPermissionDialog(BuildContext context) {
    AdaptiveAlertDialog.show(context,
      title: LocaleKeys.microphonePermissionRequired.tr(),
      content: LocaleKeys.microphoneAccessIsRequiredToSecurelyRecordYourVoiceForVerificationDuringTheSignInAndSignUpProcess.tr(),
      yesButtonTitle: LocaleKeys.settings.tr(),
      noButtonTitle: LocaleKeys.cancel.tr(),
      onYesPressed: () async {
        await openAppSettings(); // Redirect user to settings
      },
      onNoPressed: () {},
    );
  }
}
