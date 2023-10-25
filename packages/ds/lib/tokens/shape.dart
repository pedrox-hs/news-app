import '../types/shape.dart';
import 'color.dart';
import 'dimen.dart';

class AppShape {
  static ShapeData get defaults => ShapeData(
        padding: AppSpacingInset.lg,
        borderRadius: AppBorderRadius.none,
        borderWidth: AppBorderWidth.thin,
        borderColor: AppColor.neutral04,
        backgroundColor: AppColor.neutral05,
      );
}
