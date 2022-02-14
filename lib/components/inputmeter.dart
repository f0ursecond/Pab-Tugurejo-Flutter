import 'dart:convert';
import 'dart:ui';

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

class inputMeters extends StatefulWidget {
  inputMeters({Key? key}) : super(key: key);

  @override
  _inputMetersState createState() => _inputMetersState();
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

class _inputMetersState extends State<inputMeters> {
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
        title: Text('Input Meter Tugurejo'),
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
                          openDialog(
                            context: context,
                            id: users[index].id,
                            userid: users[index].userid,
                            nama: users[index].nama,
                            alamat: users[index].alamat,
                            kelurahan: users[index].kelurahan,
                            notelp: users[index].notelp,
                            stand_awal: users[index].stand_awal,
                            stand_akhir: users[index].stand_akhir,

                            // final standAkhir = await openDialog(
                          ));

                      // if (standAkhir == null || standAkhir.isEmpty) return;

                      // setState(() => this.standAkhir = standAkhir);
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

openDialog({
  context,
  id,
  userid,
  nama,
  alamat,
  kelurahan,
  notelp,
  stand_awal,
  stand_akhir,
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
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: ' + nama,
                  style: subHeader,
                ),
                Text(
                  'Id Pelanggan: ' + userid,
                  style: subHeader,
                ),
                Text(
                  'Kelurahan: ' + kelurahan,
                  style: subHeader,
                ),
                Text(
                  'Alamat: ' + alamat,
                  style: subHeader,
                ),
                Text(
                  'Nomor Telpon: ' + notelp,
                  style: subHeader,
                ),
                Text(
                  'Stand Awal: ' + stand_awal,
                  style: subHeader,
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0, left: 120.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200.0,
                  height: 50.0,
                  child: TextFormField(
                    controller: standakhirController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Rp',
                      border: OutlineInputBorder(),
                      labelText: 'Stand Akhir',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 230.0),
                  child: TextButton(
                    onPressed: () async {
                      updateData();
                    },
                    child: Text(
                      'Submit',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
