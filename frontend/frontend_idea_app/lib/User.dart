class User {
  String name, surname, username, mailAddress, imageUrl;
  int isAdmin, signStatus;
  bool verified;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        username = json['username'],
        mailAddress = json['mailAddress'],
        imageUrl = json['imageUrl'],
        isAdmin = json['isAdmin'],
        signStatus = json['signStatus'],
        verified = json['verified'];

  Map<String, dynamic> toJson() => {
        'name': name,
        "surname": surname,
        "username": username,
        "mailAddress": mailAddress,
        "imageUrl": imageUrl,
        "isAdmin": isAdmin,
        "signStatus": signStatus,
        "verified": verified,
      };
}
