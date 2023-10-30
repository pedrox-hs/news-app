import 'package:equatable/equatable.dart';

abstract class Asset extends Equatable {
  const Asset();
}

abstract class PictureAsset extends Asset {
  const PictureAsset(
    this.uri, {
    this.semanticsLabel,
    required this.type,
  });

  final String uri;
  final String? semanticsLabel;

  final PictureAssetType type;

  @override
  List<Object?> get props => [uri, semanticsLabel, type];
}

class LocalSvgAsset extends PictureAsset {
  const LocalSvgAsset(
    super.uri, {
    super.semanticsLabel,
  }) : super(type: PictureAssetType.localSvg);
}

enum PictureAssetType {
  localSvg,
}
