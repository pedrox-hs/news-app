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

  final String? title;
  final String? subtitle;
  final String? content;
  final Button button;

  @override
  Widget build(BuildContext context) {
    return Shape(
      shape: AppShape.defaults,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Heading(title!),
          if (subtitle != null) Subtitle(subtitle!),
          if (content != null) Paragraph(content!),
          button,
        ],
      ),
    );
  }
}

class Typography extends Padding {
  Typography(
    String text, {
    required TextStyle style,
    EdgeInsets? margin,
    super.key,
  }) : super(
          padding: margin ?? EdgeInsets.zero,
          child: Text(
            text,
            style: style,
          ),
        );
}

class Heading extends Typography {
  Heading(
    super.text, {
    super.key,
  }) : super(
          style: AppTextStyle.headingSmall,
          margin: EdgeInsets.only(bottom: AppSpacingStack.xxxs),
        );
}

class Subtitle extends Typography {
  Subtitle(
    super.text, {
    super.key,
  }) : super(
          style: AppTextStyle.subtitleSmall,
          margin: EdgeInsets.only(bottom: AppSpacingStack.xxs),
        );
}

class Paragraph extends Typography {
  Paragraph(
    super.text, {
    super.key,
  }) : super(
          style: AppTextStyle.paragraph,
          margin: EdgeInsets.only(bottom: AppSpacingStack.sm),
        );
}
