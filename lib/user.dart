class User {
  String nama_pelanggan;
  // String alamat;
  String kelurahan;
  String id_pelangggan;

  //User({required this.id, required this.name, required this.alamat});
  User(
      {required this.id_pelangggan,
      required this.nama_pelanggan,
      required this.kelurahan});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        // id: json["id"],
        // name: json["name"] as String,
        // rtrw: json["email"],

        // nama: json["name"],
        // alamat: json["alamat"],
        // id: json["id"],

        nama_pelanggan: json["nama_pelanggan"],
        kelurahan: json["kelurahan"],
        id_pelangggan: json["id_pelanggan"]);
  }
}
