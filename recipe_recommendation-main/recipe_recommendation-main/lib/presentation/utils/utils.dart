import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../src/index.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  // static flushMessage(String message, BuildContext context, Color color) {
  //   showFlushbar(
  //     context: context,
  //     flushbar: Flushbar(
  //       message: message,
  //       backgroundColor: color,
  //       duration: const Duration(seconds: 2),
  //     )..show(context),
  //   );
  // }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static snackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorManager.black,
        content: Center(child: Text(message)),
      ),
    );
  }

  static Text popinLightText(
    String text, {
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
  }) {
    return Text(
      text,
      style: TextStyleManager.popinsReg(
        color: color,
        fontSize: fontSize,
        wordSpacing: letterSpacing,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
    );
  }

  static Text popinRegText(
    String text, {
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    double? wordSpacing,
    FontStyle? fontStyle,
  }) {
    return Text(
      text,
      style: TextStyleManager.popinsReg(
        height: 1.2,
        color: color,
        fontSize: fontSize,
        wordSpacing: letterSpacing,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
    );
  }

  static Text popinMedText(
    String text, {
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    double? wordSpacing,
    TextOverflow? textOverflow,
    int? maxLine,

    // double? height,
    double? letterSpacing,
  }) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLine,
      style: TextStyleManager.popinsMed(
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,

        // height: height,
      ),
      textAlign: textAlign,
    );
  }

  static Text popinSemBoldText(
    String text, {
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
    double? wordSpacing,
    TextOverflow? textOverflow,
    int? maxLines,

    // double? height,
    double? letterSpacing,
  }) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyleManager.popinsSemBold(
        color: color,
        fontSize: fontSize,
        letterSpacing: letterSpacing,

        // height: height,
      ),
      textAlign: textAlign,
    );
  }

  static Text popinBoldText(
    String text, {
    TextAlign? textAlign,
    Color? color,
    double? fontSize,
  }) {
    return Text(
      text,
      style: TextStyleManager.popinsBold(
        color: color,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static String kEmailNullError = "Please Enter your email";
  static String kInvalidEmailError = "Please Enter Valid Email";
  static String kPassNullError = "Please Enter your password";
  static String kShortPassError = "Password is too short";
  static String kMatchPassError = "Passwords don't match";
  static String kNamelNullError = "Please Enter your name";
  static String kPhoneNumberNullError = "Please Enter your phone number";
}
