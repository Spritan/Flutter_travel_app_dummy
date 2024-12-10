class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String author;
  final String imageUrl;
  final String date;
  final List<String> tags;
  final int readTime;

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.author,
    required this.imageUrl,
    required this.date,
    required this.tags,
    required this.readTime,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      excerpt: json['excerpt'],
      content: json['content'],
      author: json['author'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      tags: List<String>.from(json['tags']),
      readTime: json['readTime'],
    );
  }
}
