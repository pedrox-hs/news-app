import 'package:flutter/widgets.dart';

class InfiniteListenerController extends ScrollController {
  final VoidCallback onLoadMore;

  InfiniteListenerController(this.onLoadMore) {
    addListener(_endListener);
  }

  void _endListener() {
    if (position.pixels == position.maxScrollExtent) {
      onLoadMore.call();
    }
  }

  @override
  void dispose() {
    removeListener(_endListener);
    super.dispose();
  }
}
