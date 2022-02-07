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
                        .where((u) => (u.namapelanggan
                                .toLowerCase()
                                .contains(string.toLowerCase()) ||
                            u.idpelanggan
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
                    title: Text(users[index].namapelanggan),
                    subtitle: Text(users[index].jalan),
                    onTap: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => detailPage(
                      //               users: users[index],
                      //             ),
                      //             ),
                      //             );
                      // openDialog(context, users[index].nama_pelanggan,
                      //     users[index].kelurahan);
                      final standAkhir = await openDialog(
                        context: context,
                        idpelanggan: users[index].idpelanggan,
                        namapelanggan: users[index].namapelanggan,
                        rt: users[index].rt,
                        rw: users[index].rw,
                        nomorRumah: users[index].nomorRumah,
                        jalan: users[index].jalan,
                        kelurahan: users[index].kelurahan,
                        kota: users[index].kota,
                        nomorTelpon: users[index].nomorTelpon,
                        standAwal: users[index].standAwal,
                        stand_akhir: users[index].stand_akhir,
                        // idpelanggan: users[index].namapelanggan,
                        // stand_akhir: users[index].stand_akhir,
                      );

                      if (standAkhir == null || standAkhir.isEmpty) return;

                      setState(() => this.standAkhir = standAkhir);
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
  idpelanggan,
  namapelanggan,
  rt,
  rw,
  nomorRumah,
  jalan,
  kelurahan,
  kota,
  nomorTelpon,
  standAwal,
  stand_akhir,
}) {
  // TextEditingController standakhirController =
  //     TextEditingController(text: stand_akhir);
  // Services services = Services();
  final standakhirController = TextEditingController(text: stand_akhir);
  Services services = Services();

  updateData() async {
    Navigator.of(context).pop();

    var url = "https://61f4b84262f1e300173c3ee2.mockapi.io/pab/";
    http.put(Uri.parse(url), body: {
      "idpelanggan": idpelanggan,
      "stand_akhir": standakhirController.text,
    });

    // var stand_akhir = standakhirController.text;
    // var id;
    // if (stand_akhir.isNotEmpty) {
    //   // var url = "https://61f4b84262f1e300173c3ee2.mockapi.io/pab";

    //   var bodyData = json.encode({stand_akhir: stand_akhir});
    //   var response = await http.put(
    //       Uri.parse('https://61f4b84262f1e300173c3ee2.mockapi.io' +
    //           '/pab/' +
    //           id.toString()),
    //       headers: {
    //         "Content-Type": "application/json",
    //         "Accept": "application/json"
    //       },
    //       body: bodyData);
    //   if (response.statusCode == 200) {
    //     var messageSucces = json.decode(response.body)['message'];
    //     print('Update Sukses');
    //   } else {
    //     print('Update Gagal');
    //   }
    // }
  }

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
                  'Nama: ' + namapelanggan,
                  style: subHeader,
                ),
                Text(
                  'Kelurahan: ' + kelurahan,
                  style: subHeader,
                ),
                Text(
                  'Jalan: ' + jalan,
                  style: subHeader,
                ),
                Text(
                  'RT: ' + rt,
                  style: subHeader,
                ),
                Text(
                  'RW: ' + rw,
                  style: subHeader,
                ),
                Text(
                  'Nomor Telpon: ' + nomorTelpon,
                  style: subHeader,
                ),
                Text(
                  'Jalan: ' + jalan,
                  style: subHeader,
                ),
                Text(
                  'Kota: ' + kota,
                  style: subHeader,
                ),
                Text(
                  'Stand Awal: ' + standAwal,
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
