import 'dart:ui';

import 'package:pab/main.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/colors.dart';
import 'loginscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pab/user.dart';
import 'package:pab/services.dart';

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

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
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
                    trailing: Text('Rp50.000'),
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
                        context,
                        users[index].namapelanggan,
                        users[index].jalan,
                        users[index].idpelanggan,
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

TextEditingController controller = new TextEditingController();

openDialog(
  context,
  nama_pelanggan,
  jalan,
  id_pelanggan,
) {
  void submit() {
    Navigator.of(context).pop(controller.text.toString());
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
                Text('Nama: ' + nama_pelanggan),
                Text('Kelurahan: '),
                Text('Jalan: ' + jalan),
                Text('RT: '),
                Text('RW: '),
                Text('Nomor Telpon: '),
                Text('Alamat: '),
                Text('Stand Awal: '),
                Container(
                  margin: EdgeInsets.only(top: 50.0, left: 120.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200.0,
                  height: 50.0,
                  child: TextFormField(
                    controller: controller,
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
                    onPressed: submit,
                    child: Text(
                      'Submit',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
