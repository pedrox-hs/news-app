import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../types/asset.dart';

class PictureAssetWidget extends StatelessWidget {
  const PictureAssetWidget(
    this.asset, {
    this.size,
    super.key,
  });

  final PictureAsset asset;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    switch (asset.type) {
      case PictureAssetType.localSvg:
        return SvgPicture.asset(
          asset.uri,
          width: size?.width,
          height: size?.height,
          semanticsLabel: asset.semanticsLabel,
        );
    }
  }
}
