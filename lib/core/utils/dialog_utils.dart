

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(context,
      {String? message, bool isDismissible = false}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Titel"),
          content: Row(
            children: [
              Text(message ?? ""),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  static void hideDialog(context) {
    Navigator.pop(context);
  }

  static void showMessageDialog(
    context, {
    String? titel,
    String? content,
    String? negActionTitle,
    String? posActionTitle,
    Function? posAction,
    Function? negAction,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: titel != null ? Text(titel) : null,
          content: content != null ? Text(content) : null,
          actions: [
            if (posActionTitle != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                },
                child: Text(posActionTitle),
              ),
            if(negActionTitle != null)
              TextButton(onPressed: () {
                negAction?.call();
                Navigator.pop(context);
              }, child: Text(negActionTitle))
          ],
        );
      },
    );
  }
}
