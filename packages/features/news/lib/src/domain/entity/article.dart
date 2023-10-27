import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.url,
  });

  final String? title;
  final String? subtitle;
  final String? content;
  final String url;

  @override
  List<Object?> get props => [title, subtitle, content, url];
}
