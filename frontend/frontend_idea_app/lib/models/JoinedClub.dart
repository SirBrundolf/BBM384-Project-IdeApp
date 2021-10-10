class JoinedClub {
  String clubName, parentClub, imageUrl, description;
  int vote;

  JoinedClub(this.clubName, this.parentClub, this.imageUrl, this.vote,
      this.description);

  JoinedClub.fromJson(Map<String, dynamic> json)
      : parentClub = json['parentClub'],
        imageUrl = json['imageUrl'],
        clubName = json['clubName'],
        vote = json['vote'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        "clubName": "'" + clubName + "'",
        "parentClub": "'" + parentClub + "'",
        "imageUrl": "'" + imageUrl + "'",
        "vote": vote,
        "description": "'" + description + "'",
      };
}