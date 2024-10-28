import 'package:flutter/material.dart';

import '../../src/index.dart';

CardTheme getCardTheme() {
  return CardTheme(
    color: ColorManager.white,
    shadowColor: ColorManager.grey.withOpacity(0.3),
    elevation: 8,
  );
}
