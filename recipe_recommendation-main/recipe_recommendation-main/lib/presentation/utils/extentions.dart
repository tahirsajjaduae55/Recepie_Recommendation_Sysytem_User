import '../../app/index.dart';

extension Toggle on bool {
  bool toggle() => !this;
}

extension SpaceXY on num {
  SizedBox get spaceX => SizedBox(width: toDouble().w);
  SizedBox get spaceY => SizedBox(height: toDouble().h);
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

// extension Sizer on num {
//   double get sw => getProportionateScreenWidth(toDouble());
//   double get sh => getProportionateScreenHeight(toDouble());
//   double get px => getProportionateScreenHeight(toDouble());
//   double get sizeR => getProportionateScreenHeight(toDouble());
// }
