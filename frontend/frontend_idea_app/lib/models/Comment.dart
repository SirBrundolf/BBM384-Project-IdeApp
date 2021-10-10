class Comment {
  String author, content, timestamp;
  int vote;

  Comment(this.content, this.author, this.timestamp, this.vote);

  Comment.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        author = json['author'],
        timestamp = json['timestamp'],
        vote = json['vote'];

  Map<String, dynamic> toJson() => {
        "content": "'" + content + "'",
        "author": "'" + author + "'",
        "timestamp": "'" + timestamp + "'",
        "vote": vote
      };
}
