class MakharejUser {
  String email;
  String userID;
  String? familyID;

  MakharejUser({
    required this.email,
    required this.userID,
    this.familyID,
  });

  factory MakharejUser.fromJson(Map<String, dynamic> json) {
    return MakharejUser(
      email: json['email'] as String,
      userID: json['userID'] as String,
      familyID: json['familyID'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'userID': userID,
        'familyID': familyID,
      };
}
