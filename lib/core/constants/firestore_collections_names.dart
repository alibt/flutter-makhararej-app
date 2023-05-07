class CollectionNames {
  static const String categories = "categories";
  static const String transactions = "transactions";
  static const String users = "users";
  static const String families = "families";

  static String getCategoriesPath(String familyID) {
    return "$families/$familyID/$categories";
  }
}
