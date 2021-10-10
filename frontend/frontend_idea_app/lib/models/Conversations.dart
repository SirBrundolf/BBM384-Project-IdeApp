class Conversations {
  String sender, receiver;

  Conversations();

  Conversations.fromJson(Map<String, dynamic> json)
      : sender = json['sender'],
        receiver = json['receiver'];

  Map<String, dynamic> toJson() => {
        'sender': sender,
        "receiver": receiver,
      };
}
