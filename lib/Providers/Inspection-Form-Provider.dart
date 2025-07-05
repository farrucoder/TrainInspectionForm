import 'package:flutter/cupertino.dart';
import 'package:trainformforinspection/Models/Cleanlines-Model.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';

class Inspectionformprovider extends ChangeNotifier {
  final List<Trainmodel> _trainModel = [

    Trainmodel(
      stationName: 'Kanpure',
      date: '20/09/2025',
      cleanlinesParameter: {
        'Urine Check': Cleanlinesmodel(score: 9, remark: ''),
      },
    ),
    Trainmodel(
      stationName: 'Kanpure',
      date: '20/09/2025',
      cleanlinesParameter: {
        'Urine Check': Cleanlinesmodel(score: 9, remark: ''),
      },
    ),
    Trainmodel(
      stationName: 'Kanpure',
      date: '20/09/2025',
      cleanlinesParameter: {
        'Urine Check': Cleanlinesmodel(score: 9, remark: ''),
      },
    ),

  ];

  List<Trainmodel> get trainModel => _trainModel;

  Future<void> addTrainCleanlinesData(Trainmodel cleanLinesTrainData) async {
    _trainModel.add(cleanLinesTrainData);

    notifyListeners();
  }


}
