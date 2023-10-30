import 'package:flutter/material.dart';

import '../style_dictionary.dart';
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
          PictureAssetWidget(icon, size: JDesignTokens.assetSizeLg),
          SizedBox(height: JDesignTokens.spacingSizeXxs.vertical),
          Text(title, style: JDesignTokens.textStyleHeadingSmall),
          SizedBox(height: JDesignTokens.spacingSizeXxs.vertical),
          Text(description, style: JDesignTokens.textStyleParagraph),
          SizedBox(height: JDesignTokens.spacingSizeSm.vertical),
          button,
        ],
      ),
    );
  }
}
