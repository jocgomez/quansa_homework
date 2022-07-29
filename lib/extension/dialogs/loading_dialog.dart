import 'package:flutter/material.dart';
import 'package:quansa_homework/extension/dialog_builder.dart';

class LoadingDialog extends DialogBuilder {
  @override
  Widget buildAlertDialog(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.4),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56)),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.width * 0.05,
              horizontal: size.width * 0.05,
            ),
            child: SizedBox(
              width: size.width * 0.1,
              height: size.width * 0.1,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
