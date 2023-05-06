import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tap_cash/core/theme/app_color/app_color_light.dart';

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 10,
    backgroundColor: chooseToastColor(state),
    textColor: AppColors.primaryColor,
    fontSize: 16.0.sp,
  );
}

// enum  كذا اختيار من حاجة
enum ToastStates { success, error, waring }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.waring:
      color = Colors.amber;
      break;
  }
  return color;
}
