import 'package:commons_foundation/foundation.dart';
import 'package:ds/ds.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entity/article.dart';

typedef OnReadMorePressed = void Function(Article article);

class ArticleWidget extends StatelessWidget {
  ArticleWidget(
    this.article, {
    OnReadMorePressed? onReadMorePressed,
    super.key,
  }) : _onReadMorePressed = CallbackValue.orNull(onReadMorePressed, article);

  final Article article;
  final VoidCallback? _onReadMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: JDesignTokens.spacingInsetSizeNano,
      child: CardContent(
        title: article.title,
        subtitle: article.subtitle,
        content: article.content,
        button: Button.primary(
          text: 'Ler mais',
          onPressed: _onReadMorePressed,
        ),
      ),
    );
  }
}
