class Index {
  String name, type, clubName, description;
  int vote;

  Index(this.name, this.type, this.clubName, this.vote, this.description);

  Index.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        clubName = json['clubName'],
        vote = json['vote'],
        description = json['description'];
}
