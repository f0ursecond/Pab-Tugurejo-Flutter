import 'dart:ui';

import 'package:pab/main.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/colors.dart';
import 'loginscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pab/user.dart';
import 'package:pab/services.dart';

class listPay extends StatefulWidget {
  listPay({Key? key}) : super(key: key);

  @override
  State<listPay> createState() => _listPayState();
}

class _listPayState extends State<listPay> {
  List<User> users = [];
  List<User> filteredUsers = [];
  String standAkhir = '';

  @override
  void initState() {
    super.initState();

    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
      });
    });
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
                          users[index].idpelanggan,
                          users[index].namapelanggan,
                          users[index].rt,
                          users[index].rw,
                          users[index].nomorRumah,
                          users[index].jalan,
                          users[index].kelurahan,
                          users[index].kota,
                          users[index].nomorTelpon,
                          users[index].standAwal);
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

openDialog(
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
) {
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
            height: MediaQuery.of(context).size.width * 0.6,
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
                  'Stand Awal: ' + standAwal,
                  style: subHeader,
                ),
                Text(
                  'Stand Akhir: Rp50.000',
                  style: subHeader,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 230.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Bayar',
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
