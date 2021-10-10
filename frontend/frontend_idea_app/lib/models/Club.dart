class Club {
  String name, imageUrl, description;
  int vote;

  Club(this.name, this.imageUrl, this.description);

  Club.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['imageUrl'],
        vote = json['vote'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        "name": "'" + name + "'",
        "imageUrl": "'" + imageUrl + "'",
        "vote": vote,
        "description": "'" + description + "'",
      };
}