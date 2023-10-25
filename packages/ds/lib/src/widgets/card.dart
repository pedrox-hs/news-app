import 'package:flutter/material.dart';

import '../tokens/dimen.dart';
import '../tokens/shape.dart';
import '../tokens/typography.dart';
import 'button.dart';
import 'shape.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.button,
  });

  final String title;
  final String subtitle;
  final String content;
  final Button button;

  @override
  Widget build(BuildContext context) {
    return Shape(
      shape: AppShape.defaults,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.headingSmall,
          ),
          SizedBox(height: AppSpacingStack.xxxs),
          Text(
            subtitle,
            style: AppTextStyle.subtitleSmall,
          ),
          SizedBox(height: AppSpacingStack.xxs),
          Text(
            content,
            style: AppTextStyle.paragraph,
          ),
          SizedBox(height: AppSpacingStack.sm),
          button,
        ],
      ),
    );
  }
}
