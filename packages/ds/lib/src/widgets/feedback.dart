import 'package:flutter/material.dart';

import '../tokens/dimen.dart';
import '../tokens/typography.dart';
import '../types/asset.dart';
import 'picture_asset.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.button,
  });

  final PictureAsset icon;
  final String title;
  final String description;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PictureAssetWidget(icon, size: const Size.square(AppSizingIcon.lg)),
          const SizedBox(height: AppSpacingStack.xxs),
          Text(title, style: AppTextStyle.headingSmall),
          const SizedBox(height: AppSpacingStack.xxs),
          Text(description, style: AppTextStyle.paragraph),
          const SizedBox(height: AppSpacingStack.sm),
          button,
        ],
      ),
    );
  }
}
