class Article {
  final String editora;
  final String titleArticle;
  final String autor;
  final String description;
  final String urlToNotice;
  final String urlToImage;
  final String datePublished;
  final String content;

  Article({
    required this.editora,
    required this.titleArticle,
    required this.autor,
    required this.description,
    required this.urlToNotice,
    required this.urlToImage,
    required this.datePublished,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      editora: json['source']?['name'] ?? '',
      titleArticle: json['title'] ?? '',
      autor: json['author'] ?? '',
      description: _parseDescription(json['description']),
      urlToNotice: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      datePublished: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  static String _parseDescription(String? html) {
    if (html == null) return '';
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
}
