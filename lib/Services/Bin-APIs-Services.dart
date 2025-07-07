import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trainformforinspection/Models/Train-Model.dart';


class BinAPIsService {

  static Future<Trainmodel?> sendDataToBin(Trainmodel data) async {
    final url = Uri.parse('https://httpbin.org/post');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toMap()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        final decoded = jsonDecode(response.body);
        final data = decoded['json'];

        return Trainmodel.fromMap(data);
      } else {

        return null;
      }
    } catch (e) {

      return null;
    }
  }



}


