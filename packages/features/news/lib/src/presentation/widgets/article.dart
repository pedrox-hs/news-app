import 'package:ds/ds.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entity/article.dart';

typedef OnReadMorePressed = void Function(Article article);

class ArticleWidget extends StatelessWidget {
  ArticleWidget(
    this.article, {
    OnReadMorePressed? onReadMorePressed,
    super.key,
  }) : _onReadMorePressed =
            _OnReadMorePressed.orNull(onReadMorePressed, article);

  final Article article;
  final _OnReadMorePressed? _onReadMorePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacingInset.nano,
      child: CardContent(
        title: article.title,
        subtitle: article.subtitle,
        content: article.content,
        button: Button.primary(
          text: 'Ler mais',
          onPressed: _onReadMorePressed?.call,
        ),
      ),
    );
  }
}

class _OnReadMorePressed  {
  _OnReadMorePressed(this.callback);

  final VoidCallback callback;

  static _OnReadMorePressed? orNull<T>(
    void Function(T value)? callback,
    T value,
  ) {
    if (callback != null) {
      return _OnReadMorePressed(() => callback(value));
    }
    return null;
  }

  void call() => callback();
}
