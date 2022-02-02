import 'dart:ui';

import 'package:pab/main.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/colors.dart';
import 'loginscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pab/user.dart';
import 'package:pab/services.dart';

class detailPage extends StatelessWidget {
  final User users;

  const detailPage({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama: ' + users.nama_pelanggan,
                style: mainHeader,
              ),
              Text(
                'Kelurahan: ' + users.kelurahan,
                style: mainHeader,
              ),
              Text(
                'Id Pelanggan: ' + users.id_pelangggan,
                style: mainHeader,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
