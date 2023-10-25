import 'package:flutter/widgets.dart';

import '../types/button.dart';
import 'color.dart';
import 'dimen.dart';
import 'typography.dart';

class AppButtonStyle {
  static ButtonStyleData get primary => ButtonStyleData(
        backgroundColor: AppColor.brandPrimary03,
        overlayColor: AppColor.brandPrimary02,
        textStyle: TextStyle(
          fontFamily: AppFontFamily.highlight,
          fontWeight: AppFontWeight.medium,
          fontSize: AppFontSize.sm,
          height: AppLineHeight.tight,
          color: AppColor.neutral05,
        ),
        padding: AppSpacingSquish.xs,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.none,
        ),
      );
}
