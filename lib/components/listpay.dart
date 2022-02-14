import 'dart:convert';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

import 'package:pab/components/listpay.dart';

import 'package:pab/main.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/colors.dart';
import 'loginscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pab/user.dart';
import 'package:pab/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;

class listPay extends StatefulWidget {
  listPay({Key? key}) : super(key: key);

  @override
  _listPayState createState() => _listPayState();
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  late Timer _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _listPayState extends State<listPay> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = [];

  List<User> filteredUsers = [];

  String standAkhir = '';
  late TextEditingController standakhirController;

  // Services services = Services();

  @override
  void initState() {
    super.initState();
    standakhirController = TextEditingController();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
      });
    });
  }

  @override
  void dispose() {
    standakhirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: 470.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: warnaBiru,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Enter name or email',
                  border: InputBorder.none),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredUsers = users
                        .where((u) => (u.nama
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.userid
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20.0),
              itemCount: users.length,
              itemBuilder: (_, int index) {
                return Card(
                  child: ListTile(
                    trailing: Text('Rp' + users[index].stand_akhir),
                    title: Text(users[index].nama),
                    subtitle: Text(users[index].alamat),
                    onTap: () async {
                      Navigator.push(
                          context,
                          payment(
                            context: context,
                            id: users[index].id,
                            userid: users[index].userid,
                            nama: users[index].nama,
                            alamat: users[index].alamat,
                            kelurahan: users[index].kelurahan,
                            notelp: users[index].notelp,
                            stand_awal: users[index].stand_awal,
                            stand_akhir: users[index].stand_akhir,
                          ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

payment({
  context,
  id,
  userid,
  nama,
  alamat,
  kelurahan,
  notelp,
  stand_awal,
  stand_akhir,
  Center Function(dynamic context)? builder,
}) {
  TextEditingController standakhirController =
      TextEditingController(text: stand_akhir);

  Future updateData() async {
    Navigator.pop(context);
    String stand_akhir = standakhirController.text;
    if (stand_akhir == "") {
      print("Data tidak boleh kosong");
      return;
    }
    final response =
        await http.post(Uri.parse('http://192.168.1.13/update.php'), body: {
      "id": id,
      "userid": userid,
      "nama": nama,
      "alamat": alamat,
      "kelurahan": kelurahan,
      "notelp": notelp,
      "stand_awal": stand_awal,
      "stand_akhir": stand_akhir,
    }, headers: {
      'Accept': 'application/json'
    });
    if (response.statusCode == 201) {
      print('Data Berhasil Disimpan');
    } else {
      print('Data gagal disimpan');
    }
  }

  ;
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: ClipPath(
            clipper: anjay(),
            child: Container(
              width: double.infinity,
              height: 800,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        'PEMBAYARAN',
                        style: GoogleFonts.workSans(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 50.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User Id :' + userid, style: payHeader),
                              Text('Nama Pelanggan :' + nama, style: payHeader),
                              Text('Alamat Pelanggan :' + alamat,
                                  style: payHeader),
                              Text('Kelurahan :' + kelurahan, style: payHeader),
                              Text('No Telepon :' + notelp, style: payHeader),
                              Text('Stand Awal :' + stand_awal,
                                  style: payHeader),
                              Text('Stand Akhir :' + stand_akhir,
                                  style: payHeader),
                              Text('Total = 80000', style: payHeader),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 20.0, top: 150.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Bayar',
                                  style: payHeader,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class anjay extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
