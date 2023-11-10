import '../../profile/model/makharej_user.dart';

class Family {
  List<MakharejUser> users;
  String id;
  String createdBy;

  Family({required this.users, required this.id, required this.createdBy});

  factory Family.fromJson(Map<String, dynamic> json) {
    List<dynamic> userJsonList = json['users'] ?? [];

    List<MakharejUser> users = userJsonList
        .map((userJson) => MakharejUser.fromJson(userJson))
        .toList();

    return Family(
      users: users,
      id: json['id'] ?? '',
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> userJsonList =
        users.map((user) => user.toJson()).toList();

    return {
      'users': userJsonList,
      'id': id,
      'createdBy': createdBy,
    };
  }
}
