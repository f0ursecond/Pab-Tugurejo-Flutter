import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:pab/colors.dart';
import 'package:pab/components/listpay.dart';
import 'package:pab/components/payment.dart';
import 'package:pab/fontstyle.dart';
import 'package:pab/main.dart';
import 'inputmeter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
  }

  //Codingan nya cuy
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'assets/images/air.png',
                      height: 200.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 5.0,
                    width: 400.0,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Text(
                      'PENGELOLAAN AIR BERSIH ',
                      style: mainHeader,
                    ),
                  ),
                  Container(
                    child: Text(
                      'TUGUREJO',
                      style: mainHeader,
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                  ),

                  //USERID
                  Container(
                    width: 350.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                    ),
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: 'Userid',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  //PASSWORD
                  Container(
                    width: 350.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0)),
                    height: 50.0,
                    width: 120.0,
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => inputMeters()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0)),
                    height: 50.0,
                    width: 120.0,
                    child: ElevatedButton(
                      child: const Text('Payment'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => listPay()));
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 290.0,
                  // ),
                  // new SvgPicture.asset(
                  //   'assets/images/anjay.svg',
                  //   width: 490.0,
                  //   allowDrawingOutsideViewBox: true,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
