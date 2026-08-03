import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

abstract final class AppToast {
  static const _duration = Duration(seconds: 4);

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, ToastificationType.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, ToastificationType.error);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, ToastificationType.info);
  }

  static void _show(
    BuildContext context,
    String message,
    ToastificationType type,
  ) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      title: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: _duration,
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
    );
  }
}
