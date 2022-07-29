import 'package:flutter/material.dart';
import 'package:quansa_homework/extension/dialog_builder.dart';

/// Se busca implementar - OCP
class DialogExtension {
  Future<void> build(BuildContext context, DialogBuilder builder) async {
    return showDialog(
      context: context,
      builder: builder.buildAlertDialog,
      useRootNavigator: false,
    );
  }

  void dispose(BuildContext context) {
    Navigator.of(context).pop();
  }
}
