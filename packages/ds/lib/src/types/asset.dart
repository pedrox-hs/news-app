abstract class Asset {
  const Asset();
}

abstract class PictureAsset extends Asset {
  const PictureAsset(
    this.path, {
    this.semanticsLabel,
  });

  final String path;
  final String? semanticsLabel;

  PictureAssetType get type;
}

class LocalSvgAsset extends PictureAsset {
  const LocalSvgAsset(
    super.path, {
    super.semanticsLabel,
  });

  @override
  final PictureAssetType type = PictureAssetType.localSvg;
}

enum PictureAssetType {
  localSvg,
}
