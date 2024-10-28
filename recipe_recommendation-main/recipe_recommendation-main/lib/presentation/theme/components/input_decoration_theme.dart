import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/index.dart';

InputDecorationTheme getInputDecoration() {
  return InputDecorationTheme(
    // filled: true,
    // fillColor: ColorManager.white,
    // constraints: BoxConstraints(
    //   maxHeight: getProportionateScreenHeight(),
    // ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 22.w,
      vertical: 20.h,
    ),

    hintStyle: TextStyleManager.popinsReg(
        fontSize: 14.h, color: ColorManager.textGreeen),
    labelStyle: TextStyleManager.popinsMed(
      color: ColorManager.grey,
    ),
    errorStyle: TextStyleManager.popinsReg(
      color: ColorManager.error,
    ),
    border: OutlineInputBorderCircularStyle.getEnabledBorder(),
    enabledBorder: OutlineInputBorderCircularStyle.getEnabledBorder(),
    focusedBorder: OutlineInputBorderCircularStyle.getEnabledBorder(),
    // errorBorder: UnderLineInptBorderStyle.getErrorBorder(),
    // focusedErrorBorder: UnderLineInptBorderStyle.getFocusedErrorBorder(),
  );
}
