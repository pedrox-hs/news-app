import 'package:flutter/widgets.dart';

import '../types/shadow.dart';

class AppLineHeight {
  static const double tight = 1;
  static const double medium = 1.1;
  static const double distant = 1.5;
  static const double superDistant = 2;
}

class AppFontSize {
  static const double xxxs = 12;
  static const double xxs = 14;
  static const double xs = 16;
  static const double sm = 20;
  static const double md = 24;
  static const double lg = 32;
  static const double xl = 40;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double display = 80;
  static const double giant = 64;
}

class AppBorderRadius {
  static final none = BorderRadius.zero;
  static final sm = BorderRadius.circular(8);
  static final md = BorderRadius.circular(16);
  static final lg = BorderRadius.circular(24);
  static final pill = BorderRadius.circular(500);
  static final circular = BorderRadius.circular(0.5); // 50% ???
}

class AppBorderWidth {
  static const double none = 0;
  static const double hairline = 1;
  static const double thin = 2;
  static const double thick = 4;
  static const double heavy = 8;
}

class AppOpacityLevel {
  static const double semiOpaque = 0.8;
  static const double intense = 0.64;
  static const double medium = 0.32;
  static const double light = 0.16;
  static const double semiTransparent = 0.08;
}

class AppShadowLevel {
  static Shadow get level1 => ShadowLevelData(b: 8, x: 0, y: 4);

  static Shadow get level2 => ShadowLevelData(b: 24, x: 0, y: 8);

  static Shadow get level3 => ShadowLevelData(b: 32, x: 0, y: 16);

  static Shadow get level4 => ShadowLevelData(b: 48, x: 0, y: 16);
}

class AppSpacingStack {
  static const double quarck = 4;
  static const double nano = 8;
  static const double xxxs = 16;
  static const double xxs = 24;
  static const double xs = 32;
  static const double sm = 40;
  static const double md = 48;
  static const double lg = 56;
  static const double xl = 64;
  static const double xxl = 80;
  static const double xxxl = 120;
  static const double huge = 160;
  static const double giant = 200;
}

class AppSpacingInset {
  static EdgeInsets get quarck => EdgeInsets.all(4);
  static EdgeInsets get nano => EdgeInsets.all(8);
  static EdgeInsets get xs => EdgeInsets.all(16);
  static EdgeInsets get sm => EdgeInsets.all(24);
  static EdgeInsets get md => EdgeInsets.all(32);
  static EdgeInsets get lg => EdgeInsets.all(40);
}

class AppSpacingSquish {
  static EdgeInsets get quarck =>
      EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static EdgeInsets get nano =>
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static EdgeInsets get xs =>
      EdgeInsets.symmetric(vertical: 16, horizontal: 24);
  static EdgeInsets get sm =>
      EdgeInsets.symmetric(vertical: 16, horizontal: 32);
}

class AppSpacingInline {
  static EdgeInsets get quarck => EdgeInsets.only(right: 4);
  static EdgeInsets get nano => EdgeInsets.only(right: 8);
  static EdgeInsets get xxxs => EdgeInsets.only(right: 16);
  static EdgeInsets get xxs => EdgeInsets.only(right: 24);
  static EdgeInsets get xs => EdgeInsets.only(right: 32);
  static EdgeInsets get sm => EdgeInsets.only(right: 40);
  static EdgeInsets get md => EdgeInsets.only(right: 48);
  static EdgeInsets get lg => EdgeInsets.only(right: 64);
  static EdgeInsets get xl => EdgeInsets.only(right: 80);
}

class AppSizingIcon {
  static const double xs = 24;
  static const double lg = 96;
}
