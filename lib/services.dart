import 'dart:convert';
import 'user.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<User>> getUsers() async {
    try {
      final response = await http
          // .get(Uri.parse('https://61f4b84262f1e300173c3ee2.mockapi.io/pab'));
          // .get(Uri.parse('http://192.168.0.114/APIinputmeter.php'));
          .get(Uri.parse('https://61f4b84262f1e300173c3ee2.mockapi.io/pab'));
      if (response.statusCode == 200) {
        List<User> list = parseUsers(response.body);
        print(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future putData(int id, String stand_akhir) async {
    try {
      final response = await http.put(
          Uri.parse('https://61f4b84262f1e300173c3ee2.mockapi.io' +
              '/pab/' +
              id.toString()),
          body: {'stand_akhir': stand_akhir});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}



  // class Services {
//   final _baseUrl = 'https://61f4b84262f1e300173c3ee2.mockapi.io/pab';

//   Future getData() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         print(response.body);
//         Iterable it = jsonDecode(response.body);
//         List<User> user = it.map((e) => User.fromJson(e)).toList();
//         return jsonEncode(response.body);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }