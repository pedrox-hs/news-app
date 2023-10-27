import 'package:equatable/equatable.dart';

abstract class Asset extends Equatable {
  const Asset();
}

abstract class PictureAsset extends Asset {
  const PictureAsset(
    this.path, {
    this.semanticsLabel,
    required this.type,
  });

  final String path;
  final String? semanticsLabel;

  final PictureAssetType type;

  @override
  List<Object?> get props => [path, semanticsLabel, type];
}

class LocalSvgAsset extends PictureAsset {
  const LocalSvgAsset(
    super.path, {
    super.semanticsLabel,
  }) : super(type: PictureAssetType.localSvg);
}

enum PictureAssetType {
  localSvg,
}
