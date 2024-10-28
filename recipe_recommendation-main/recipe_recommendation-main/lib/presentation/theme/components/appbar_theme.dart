import 'package:flutter/material.dart';

import '../../src/index.dart';

AppBarTheme getAppBarTheme() {
  return AppBarTheme(
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: ColorManager.white,
    // ),
    centerTitle: true,
    color: ColorManager.white,
    shadowColor: ColorManager.primary,
    elevation: 0,
    // titleTextStyle: TextStyleManager.regularTextStyle(
    //   color: ColorManager.white,
    //   fontSize: FontSize.s16,
    // ),
  );
}
