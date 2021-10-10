class SubClub {
  String name, imageUrl, clubName, subClubAdmin, description;
  int vote;

  SubClub(this.name, this.imageUrl, this.clubName, this.subClubAdmin, this.vote,
      this.description);

  SubClub.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['imageUrl'],
        clubName = json['clubName'],
        subClubAdmin = json['subClubAdmin'],
        vote = json['vote'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        "name": "'" + name + "'",
        "imageUrl": "'" + imageUrl + "'",
        "clubName": "'" + clubName + "'",
        "subClubAdmin": "'" + subClubAdmin + "'",
        "vote": vote,
        "description": "'" + description + "'",
      };
}