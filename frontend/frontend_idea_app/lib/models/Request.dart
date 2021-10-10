class RequestClub {
  String name, reason, admin;

  RequestClub({this.name, this.reason, this.admin});

  RequestClub.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        reason = json['reason'],
        admin = json["admin"];

  Map<String, dynamic> toJson() => {
        "name": "'" + name + "'",
        "reason": "'" + reason + "'",
        "admin": "'" + admin
      };
}

class RequestSubClub {
  String name, reason, parentClub, admin;

  RequestSubClub.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        reason = json['reason'],
        parentClub = json["parentClub"],
        admin = json["admin"];

  Map<String, dynamic> toJson() => {
        "name": "'" + name + "'",
        "reason": "'" + reason + "'",
        "parentClub": "'" + parentClub + "'",
        "admin": "'" + admin
      };
}

class CandidateRequest {
  String username, clubName, subClubName, reason;

  CandidateRequest.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        clubName = json['clubName'],
        subClubName = json["subClubName"],
        reason = json["reason"];

  Map<String, dynamic> toJson() => {
        "username": "'" + username + "'",
        "clubName": "'" + clubName + "'",
        "subClubName": "'" + subClubName + "'",
        "reason": "'" + reason
      };
}

class BanRequest {
  String username, clubName, timestamp, subClubName, type;

  BanRequest.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        clubName = json['clubName'],
        subClubName = json["subClubName"],
        timestamp = json["timestamp"],
        type = json["type"];

  Map<String, dynamic> toJson() => {
        "username": "'" + username + "'",
        "clubName": "'" + clubName + "'",
        "subClubName": "'" + subClubName + "'",
        "timestamp": "'" + timestamp + "'",
        "type": "'" + type
      };
}
