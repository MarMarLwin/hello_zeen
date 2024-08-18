import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common_widget/cancel_dialog.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      ConfirmDialog.show(
        context: context,
        title: 'Error',
        content: error.toString(),
      );
    }
  }
}
