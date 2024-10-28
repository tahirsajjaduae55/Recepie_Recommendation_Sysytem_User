import 'package:flutter/services.dart';

import '../../app/index.dart';

AppBar buildAppBarWidget({
  Widget? leading,
  String? title,
  // Color? leadingIconColor,
  double? height,
  Color? appbarColor,
  List<Widget>? action,
  VoidCallback? onBack,
  Widget? bottom,
  SystemUiOverlayStyle? systemUiOverlayStyle,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle: systemUiOverlayStyle,
    elevation: 0,
    toolbarHeight: height,
    backgroundColor: appbarColor,
    centerTitle: true,
    title: Utils.popinMedText(
      title!,
      fontSize: 20.sp,
      color: ColorManager.white,
    ),
    actions: action ?? const [],
  );
}
