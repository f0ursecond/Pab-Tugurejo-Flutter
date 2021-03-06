import 'package:flutter/material.dart';
import 'package:pab/components/loginscreen.dart';
import 'dart:async';
import 'package:pab/components/inputmeter.dart';
import 'package:pab/components/payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen(),
    );
  }
}
