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
      email: json['email'],
      userID: json['userID'],
      familyID: json['familyID'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'userID': userID,
        'familyID': familyID,
      };

  MakharejUser copyWith({
    String? email,
    String? userID,
    String? familyID,
  }) {
    return MakharejUser(
      email: email ?? this.email,
      userID: userID ?? this.userID,
      familyID: familyID ?? this.familyID,
    );
  }
}
