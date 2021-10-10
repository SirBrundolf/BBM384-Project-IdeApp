class Post {
  String author, content, title, timestamp;
  int vote;

  Post.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        content = json['content'],
        title = json['title'],
        vote = json['vote'],
        timestamp = json["timestamp"];

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "title": title,
        "vote": vote,
        "timestamp": timestamp,
      };
}
