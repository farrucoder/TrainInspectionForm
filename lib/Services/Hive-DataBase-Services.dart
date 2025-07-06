import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';

class HiveDataBaseServices {
  static const String boxName = 'inspectionData';

  static Box get _box => Hive.box(boxName);

  static Future<void> addDataToHive(Trainmodel data) async {
    await _box.add(data.toMap());
  }


  static Future<List<Trainmodel>> getDataFromHive() async {
    final allTrainModels = _box.values.map((item) {
      final map = jsonDecode(jsonEncode(item)) as Map<String, dynamic>;
      return Trainmodel.fromMap(map);
    }).toList();

    return allTrainModels;
  }



}
