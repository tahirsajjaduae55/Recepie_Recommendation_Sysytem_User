import '../../app/index.dart';

class TextStyleManager {
  static TextStyle popinsLight({
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.hind(
      // AppFontFamiy.bentonSans,
      color: color ?? ColorManager.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: FontWeightManager.light,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: textDecoration,
      height: height,
      // decorationStyle: TextDecorationStyle.solid,
    );
  }

  static TextStyle popinsReg({
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.hind(
      // AppFontFamiy.bentonSans,
      color: color ?? ColorManager.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: FontWeightManager.regular,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontStyle: fontStyle,
      decoration: textDecoration,
      height: height,
      // decorationStyle: TextDecorationStyle.solid,
    );
  }

  static TextStyle popinsMed({
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    // double? height,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.hind(
      // AppFontFamiy.bentonSans,
      color: color ?? ColorManager.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: FontWeightManager.medium,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      wordSpacing: wordSpacing,
      // height: height,
      // decorationStyle: TextDecorationStyle.solid,
    );
  }

  static TextStyle popinsSemBold({
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.hind(
      // AppFontFamiy.bentonSans,
      color: color ?? ColorManager.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: FontWeightManager.semiBold,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      height: height,

      // decorationStyle: TextDecorationStyle.solid,
    );
  }

  static TextStyle popinsBold({
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? height,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.hind(
      // AppFontFamiy.bentonSans,
      color: color ?? ColorManager.black,
      fontSize: fontSize ?? 14.sp,
      fontWeight: FontWeightManager.bold,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      height: height,
      // decorationStyle: TextDecorationStyle.solid,
    );
  }

  // static TextStyle regularTextStyleNunito({
  //   Color? color,
  //   double? fontSize,
  //   double? letterSpacing,
  //   double? height,
  //   TextDecoration? textDecoration,
  // }) {
  //   return GoogleFonts.nunito(
  //     // AppFontFamiy.bentonSans,
  //     color: color ?? ColorManager.black,
  //     fontSize: fontSize ?? 14.sp,
  //     fontWeight: FontWeightManager.regular,
  //     letterSpacing: letterSpacing,
  //     decoration: textDecoration,
  //     height: height,
  //     // decorationStyle: TextDecorationStyle.solid,
  //   );
  // }

//   static TextStyle mediumTextStyleNunito({
//     Color? color,
//     double? fontSize,
//     double? letterSpacing,
//     double? height,
//     TextDecoration? textDecoration,
//   }) {
//     return GoogleFonts.nunito(
//       // AppFontFamiy.bentonSans,
//       color: color ?? ColorManager.black,
//       fontSize: fontSize ?? 14.sp,
//       fontWeight: FontWeightManager.medium,
//       letterSpacing: letterSpacing,
//       decoration: textDecoration,
//       height: height,
//       // decorationStyle: TextDecorationStyle.solid,
//     );
//   }

//   static TextStyle semiBoldTextStyleNunito({
//     Color? color,
//     double? fontSize,
//     double? letterSpacing,
//     double? height,
//     TextDecoration? textDecoration,
//   }) {
//     return GoogleFonts.nunito(
//       // AppFontFamiy.bentonSans,
//       color: color ?? ColorManager.black,
//       fontSize: fontSize ?? 14.sp,
//       fontWeight: FontWeightManager.semiBold,
//       letterSpacing: letterSpacing,
//       decoration: textDecoration,
//       height: height,
//       // decorationStyle: TextDecorationStyle.solid,
//     );
//   }

//   static TextStyle boldTextStyleNunito({
//     Color? color,
//     double? fontSize,
//     double? letterSpacing,
//     double? height,
//     TextDecoration? textDecoration,
//   }) {
//     return GoogleFonts.nunito(
//       // AppFontFamiy.bentonSans,
//       color: color ?? ColorManager.black,
//       fontSize: fontSize ?? 14.sp,
//       fontWeight: FontWeightManager.bold,
//       letterSpacing: letterSpacing,
//       decoration: textDecoration,
//       height: height,
//       // decorationStyle: TextDecorationStyle.solid,
//     );
//   }

//   static TextStyle semiBoldTextStyleTitilumn({
//     Color? color,
//     double? fontSize,
//     double? letterSpacing,
//     double? wordSpacing,
//     double? height,
//     TextDecoration? textDecoration,
//   }) {
//     return GoogleFonts.nunito(
//       // AppFontFamiy.bentonSans,
//       color: color ?? ColorManager.black,
//       fontSize: fontSize ?? 14.sp,
//       fontWeight: FontWeightManager.semiBold,
//       wordSpacing: wordSpacing,
//       letterSpacing: letterSpacing,
//       decoration: textDecoration,
//       height: height,
//       // decorationStyle: TextDecorationStyle.solid,
//     );
//   }
}

class OutlineInputBorderCircularStyle {
  static OutlineInputBorder _getOutlineInputBorder(
      {Color? color,
      double? width,
      BorderRadius borderRadius = const BorderRadius.all(
        Radius.circular(50),
      ),
      BorderSide? borderSide}) {
    return OutlineInputBorder(
      borderSide: borderSide ??
          BorderSide(
            color: color ?? Colors.grey,
            width: width ?? 1.5,
          ),
      borderRadius: borderRadius,
    );
  }

  static OutlineInputBorder getEnabledBorder() {
    return _getOutlineInputBorder(
      borderRadius: BorderRadius.circular(
        14.r,
      ),
      borderSide: BorderSide(
        color: ColorManager.borderColor,
      ),
    );
  }

  static OutlineInputBorder getFocusBorder() {
    return _getOutlineInputBorder(
      color: ColorManager.primary,
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }

  static OutlineInputBorder getErrorBorder() {
    return _getOutlineInputBorder(
      color: ColorManager.error,
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }

  static OutlineInputBorder getFocusedErrorBorder() {
    return _getOutlineInputBorder(
      color: ColorManager.primary,
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }
}

class OutlineInputBorderRectangleStyle {
  static OutlineInputBorder _getOutlineInputBorder(
      {Color? color,
      double? width,
      BorderRadius borderRadius = const BorderRadius.all(
        Radius.circular(12),
      ),
      BorderSide? borderSide}) {
    return OutlineInputBorder(
      borderSide: borderSide ??
          BorderSide(
            color: color ?? Colors.grey,
            width: width ?? 1.5,
          ),
      borderRadius: borderRadius,
    );
  }

  static OutlineInputBorder getEnabledBorder({Color? color}) {
    return _getOutlineInputBorder(
      borderRadius: BorderRadius.circular(
        10.r,
      ),
      borderSide: BorderSide(
        color: color ?? ColorManager.borderColor,
      ),
    );
  }

  static OutlineInputBorder getFocusBorder({Color? color}) {
    return _getOutlineInputBorder(
      color: color ?? ColorManager.primary,
      borderRadius: BorderRadius.circular(
        10.r,
      ),
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }

  static OutlineInputBorder getErrorBorder() {
    return _getOutlineInputBorder(
      color: ColorManager.error,
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }

  static OutlineInputBorder getFocusedErrorBorder() {
    return _getOutlineInputBorder(
      color: ColorManager.primary,
      // width: AppSize.s1_5,
      // borderRadius: BorderRadius.circular(AppSize.s8),
    );
  }
}

class UnderLineInptBorderStyle {
  static UnderlineInputBorder _getUnderLineInputBorder({
    Color color = Colors.grey,
    double width = 1.5,
  }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  static UnderlineInputBorder getEnabledBorder() {
    return _getUnderLineInputBorder(
      color: ColorManager.grey,
    );
  }

  static UnderlineInputBorder getFocusBorder() {
    return _getUnderLineInputBorder(
      color: ColorManager.black,
    );
  }

  static UnderlineInputBorder getErrorBorder() {
    return _getUnderLineInputBorder(
      color: ColorManager.error,
    );
  }

  static UnderlineInputBorder getFocusedErrorBorder() {
    return _getUnderLineInputBorder(
      color: ColorManager.error,
    );
  }
}
