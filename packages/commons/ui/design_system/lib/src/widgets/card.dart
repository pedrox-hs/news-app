import 'package:flutter/material.dart';

import '../style_dictionary.dart';
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
      style: JDesignTokens.shapeBox1,
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
    int? maxLines,
    super.key,
  }) : super(
          padding: margin ?? EdgeInsets.zero,
          child: Text(
            text,
            maxLines: maxLines,
            style: style,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 0.8,
            softWrap: true,
          ),
        );
}

class Heading extends Typography {
  Heading(
    super.text, {
    super.key,
  }) : super(
          style: JDesignTokens.textStyleHeadingSmall,
          margin: JDesignTokens.spacingSizeXxxs,
          maxLines: 2,
        );
}

class Subtitle extends Typography {
  Subtitle(
    super.text, {
    super.key,
  }) : super(
          style: JDesignTokens.textStyleSubtitleSmall,
          margin: JDesignTokens.spacingSizeXxs,
          maxLines: 3,
        );
}

class Paragraph extends Typography {
  Paragraph(
    super.text, {
    super.key,
  }) : super(
          style: JDesignTokens.textStyleParagraph,
          maxLines: 10,
          margin: JDesignTokens.spacingSizeSm,
        );
}
