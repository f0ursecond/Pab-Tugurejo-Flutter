class User {
  String name;
  String alamat;
  String id;

  User({required this.id, required this.name, required this.alamat});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // id: json["id"],
      // name: json["name"] as String,
      // rtrw: json["email"],

      name: json["name"],
      alamat: json["alamat"],
      id: json["id"],
    );
  }
}
