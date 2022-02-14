import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:pab/components/inputmeter.dart';
import 'package:pab/main.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/colors.dart';
import 'loginscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pab/user.dart';
import 'package:pab/services.dart';
import 'listpay.dart';

class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  List<User> users = [];

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
    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: ClipPath(
              clipper: anjay(),
              child: Container(
                width: double.infinity,
                height: 500,
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
                                Text('User Id :', style: payHeader),
                                Text('Nama Pelanggan :', style: payHeader),
                                Text('Alamat Pelanggan :', style: payHeader),
                                Text('Kelurahan :', style: payHeader),
                                Text('No Telepon :', style: payHeader),
                                Text('Stand Awal :', style: payHeader),
                                Text('Stand Akhir :', style: payHeader),
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
