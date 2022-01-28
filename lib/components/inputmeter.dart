// ignore_for_file: deprecated_member_use

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

class _inputMetersState extends State<inputMeters> {
  List<User> users = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Services.getUsers().then((usersFromServer) {
      users = usersFromServer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Meter Tugurejo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[index].name,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          users[index].email,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      // body: ListView.builder(itemBuilder: (context, index) {
      //
      //   // return _listItem(index);
      // }),
    );
  }
}

_searchBar() {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 100.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: warnaBiru,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ));
}

// _listItem(index) {

//   return Card(
//     child: Padding(
//       padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             users[index].name,
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Text(
//             users[index].email,
//           ),
//         ],
//       ),
//     ),
//   );
// }
