import 'package:flutter/widgets.dart';

import 'color.dart';
import 'dimen.dart';

class AppFontFamily {
  static const highlight = 'Archivo';
}

class AppFontWeight {
  static const bold = FontWeight.w700;

  static const medium = FontWeight.w600;

  static const regular = FontWeight.w400;
}

class AppTextStyle {
  static const headingSmall = TextStyle(
    fontSize: AppFontSize.lg,
    height: AppLineHeight.distant,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.bold,
    color: AppColor.neutral01,
  );

  static const subtitleSmall = TextStyle(
    fontSize: AppFontSize.md,
    height: AppLineHeight.medium,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.medium,
    color: AppColor.neutral02,
  );

  static const paragraph = TextStyle(
    fontSize: AppFontSize.xs,
    height: AppLineHeight.distant,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.regular,
    color: AppColor.neutral02,
  );
}
