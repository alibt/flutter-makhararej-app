import 'makharej_user.dart';

class Family {
  List<MakharejUser> users;
  // List<MakharejCategory>? categories;
  // List<MakharejTransaction>? transactions;
  String id;

  Family(
      {required this.users,
      // required this.categories,
      // required this.transactions,
      required this.id});

  factory Family.fromJson(Map<String, dynamic> json) {
    List<dynamic> userJsonList = json['users'] ?? [];
    // List<dynamic> categoryJsonList = json['categories'] ?? [];
    // List<dynamic> transactionJsonList = json['transactions'] ?? [];

    List<MakharejUser> users = userJsonList
        .map((userJson) => MakharejUser.fromJson(userJson))
        .toList();
    // List<MakharejCategory> categories = categoryJsonList
    //     .map((categoryJson) => MakharejCategory.fromJson(categoryJson))
    //     .toList();
    // List<MakharejTransaction> transactions = transactionJsonList
    //     .map((transactionJson) => MakharejTransaction.fromJson(transactionJson))
    //     .toList();

    return Family(
      users: users,
      // categories: categories,
      // transactions: transactions,
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> userJsonList =
        users.map((user) => user.toJson()).toList();
    // List<Map<String, dynamic>> categoryJsonList =
    //     categories?.map((category) => category.toJson()).toList() ?? [];
    // List<Map<String, dynamic>> transactionJsonList =
    //     transactions?.map((transaction) => transaction.toJson()).toList() ?? [];

    return {
      'users': userJsonList,
      // 'categories': categoryJsonList,
      // 'transactions': transactionJsonList,
      'id': id,
    };
  }
}
