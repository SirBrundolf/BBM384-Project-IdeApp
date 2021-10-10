class Message {
  String text, timestamp, whoSent;
  Map<String, bool> visibility;

  Message(this.text, this.timestamp, this.visibility, this.whoSent);

  Message.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        whoSent = json['whoSent'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        "timestamp": "'" + timestamp + "'",
        "text": "'" + text + "'",
        "whoSent": "'" + whoSent + "'"
      };
}
