import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../theme/app_pallete.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesButtonTitle;
  final String noButtonTitle;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const AdaptiveAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.yesButtonTitle,
    required this.noButtonTitle,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the platform is iOS or Android, and show the appropriate dialog
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _buildCupertinoDialog(context);
    } else {
      return _buildMaterialDialog(context);
    }
  }

  // Cupertino (iOS-style) AlertDialog
  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: Text(noButtonTitle, style: TextStyle(color: AppPalette.warningColor)),
          onPressed: () {
            Navigator.of(context).pop();
            onNoPressed();
          },
        ),
        CupertinoDialogAction(
          child: Text(yesButtonTitle),
          onPressed: () {
            Navigator.of(context).pop();
            onYesPressed();
          },
        ),
      ],
    );
  }

  // Material (Android-style) AlertDialog
  Widget _buildMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: AppPalette.primaryTextColor)),
      content: Text(content, style: TextStyle(color: AppPalette.primaryTextColor)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onNoPressed();
          },
          child: Text(noButtonTitle),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onYesPressed();
          },
          child: Text(yesButtonTitle),
        ),
      ],
    );
  }

  // Method to show the dialog
  static void show(
      BuildContext context, {
        required String title,
        required String content,
        required String yesButtonTitle,
        required String noButtonTitle,
        required VoidCallback onYesPressed,
        required VoidCallback onNoPressed,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdaptiveAlertDialog(
          title: title,
          content: content,
          yesButtonTitle: yesButtonTitle,
          noButtonTitle: noButtonTitle,
          onYesPressed: onYesPressed,
          onNoPressed: onNoPressed,
        );
      },
    );
  }
}
