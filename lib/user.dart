import 'dart:convert';

List<User> welcomeFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String welcomeToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.idpelanggan,
    required this.namapelanggan,
    required this.rt,
    required this.rw,
    required this.nomorRumah,
    required this.jalan,
    required this.kelurahan,
    required this.kota,
    required this.nomorTelpon,
    required this.standAwal,
  });

  String idpelanggan;
  String namapelanggan;
  String rt;
  String rw;
  String nomorRumah;
  String jalan;
  String kelurahan;
  String kota;
  String nomorTelpon;
  String standAwal;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idpelanggan: json["idpelanggan"],
        namapelanggan: json["namapelanggan"],
        rt: json["RT"],
        rw: json["RW"],
        nomorRumah: json["nomor_rumah"],
        jalan: json["jalan"],
        kelurahan: json["kelurahan"],
        kota: json["kota"],
        nomorTelpon: json["nomor_telpon"],
        standAwal: json["stand_awal"],
      );

  Map<String, dynamic> toJson() => {
        "idpelanggan": idpelanggan,
        "namapelanggan": namapelanggan,
        "RT": rt,
        "RW": rw,
        "nomor_rumah": nomorRumah,
        "jalan": jalan,
        "kelurahan": kelurahan,
        "kota": kota,
        "nomor_telpon": nomorTelpon,
        "stand_awal": standAwal,
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