import 'dart:convert';

List<User> welcomeFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String welcomeToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.userid,
    required this.nama,
    required this.alamat,
    required this.kelurahan,
    required this.notelp,
    required this.stand_awal,
    required this.stand_akhir,
  });

  final String id;
  final String userid;
  final String nama;
  final String alamat;
  final String kelurahan;
  final String notelp;
  final String stand_awal;
  final String stand_akhir;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userid: json["userid"],
        nama: json['nama'],
        alamat: json["alamat"],
        kelurahan: json["kelurahan"],
        notelp: json["notelp"],
        stand_awal: json["stand_awal"],
        stand_akhir: json["stand_akhir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "nama": nama,
        "alamat": alamat,
        "kelurahan": kelurahan,
        "notelp": notelp,
        "stand_awal": stand_awal,
        "stand_akhir": stand_akhir,
      };
}

// class User {
//   String idpelanggan;
//   String namapelanggan;
//   String RT;
//   String RW;
//   String nomor_rumah;
//   String jalan;
//   String kelurahan;


//   //User({required this.id, required this.name, required this.alamat});
//   User(
//       {required this.idpelanggan,
//       required this.namapelanggan,
//       // required this.standAkhir,
//       required this.kelurahan});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       // id: json["id"],
//       // name: json["name"] as String,
//       // rtrw: json["email"],

//       // nama: json["name"],
//       // alamat: json["alamat"],
//       // id: json["id"],

//       idpelanggan: json["idpelanggan"],
//       namapelanggan: json["namapelanggan"],
//       // standAkhir: json["standAhir"],
//       kelurahan: json["kelurahan"],
//     );
//   }
// }

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);