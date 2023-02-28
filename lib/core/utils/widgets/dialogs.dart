import 'package:flutter/cupertino.dart';

class Dialogs {
  static showCuprtinoAlertDialog({
    required String title,
    String? description,
    required List<CupertinoDialogAction> actions,
    required BuildContext context,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: description != null ? Text(description) : null,
          actions: actions,
        );
      },
    );
  }
}
