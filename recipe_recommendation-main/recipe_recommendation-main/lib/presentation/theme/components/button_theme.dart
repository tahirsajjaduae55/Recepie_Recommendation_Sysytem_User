import '../../../app/index.dart';

class GetButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(
          1.sw,
          60.h,
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        disabledBackgroundColor: ColorManager.primary,
        shape: const StadiumBorder(),
      ),
    );
  }

  static TextButtonThemeData textButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        foregroundColor: ColorManager.black,
        textStyle: TextStyleManager.popinsMed(
          fontSize: 24.h,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlineButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        // backgroundColor: Colors.amber,
        foregroundColor: ColorManager.primary,
        minimumSize: Size(
          1.sw,
          52.h,
        ),
        shape: const StadiumBorder(),
      ),
    );
  }

  static ButtonThemeData appButtonTheme() {
    return ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.textGreeen,
      splashColor: ColorManager.primaryLight,
    );
  }
}
