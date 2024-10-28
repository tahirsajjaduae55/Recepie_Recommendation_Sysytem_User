import '../../app/index.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final bool? obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final bool? isFilled;
  final Color? filledColor;
  final Widget? prefixIcon;
  final bool? readOnly;
  final int? maxLenght;
  final FocusNode? focusNode;

  final String? Function(String? value)? validator;
  final void Function(String? newValue)? onSave;
  final void Function(String newValue)? onChange;

  final Widget? suffixIcon;
  const TextfieldWidget({
    super.key,
    this.controller,
    this.keyboardType,
    required this.hintText,
    this.contentPadding,
    this.textStyle,
    this.validator,
    this.onSave,
    this.onChange,
    this.suffixIcon,
    this.obscureText,
    this.isFilled,
    this.filledColor,
    this.prefixIcon,
    this.readOnly,
    this.maxLenght,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      maxLength: maxLenght,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      textAlignVertical: TextAlignVertical.center,
      style: textStyle ??
          TextStyleManager.popinsLight(
            fontSize: 16.sp,

            // color: ColorManager.black.withOpacity(0.9),
          ),
      decoration: InputDecoration(
          counter: const Offstage(),
          prefixIcon: prefixIcon,
          filled: isFilled,
          fillColor: filledColor,
          isDense: true,
          isCollapsed: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.error),
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          hintText: hintText,
          errorStyle: TextStyleManager.popinsLight(
              fontSize: 10.sp, color: ColorManager.error),

          // hintStyle:
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: suffixIcon,
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 20.h,
            //  maxWidth: 45.w,
          )),
      onChanged: onChange,
      onSaved: onSave,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
