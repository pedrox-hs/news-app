import 'package:flutter/widgets.dart';

import 'color.dart';
import 'dimen.dart';

class AppFontFamily {
  static final highlight = 'Archivo';
}

class AppFontWeight {
  static final bold = FontWeight.w700;

  static final medium = FontWeight.w600;

  static final regular = FontWeight.w400;
}

class AppTextStyle {
  static final headingSmall = TextStyle(
    fontSize: AppFontSize.lg,
    height: AppLineHeight.distant,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.bold,
    color: AppColor.neutral01,
  );

  static final subtitleSmall = TextStyle(
    fontSize: AppFontSize.md,
    height: AppLineHeight.medium,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.medium,
    color: AppColor.neutral02,
  );

  static final paragraph = TextStyle(
    fontSize: AppFontSize.xs,
    height: AppLineHeight.distant,
    fontFamily: AppFontFamily.highlight,
    fontWeight: AppFontWeight.regular,
    color: AppColor.neutral02,
  );
}
