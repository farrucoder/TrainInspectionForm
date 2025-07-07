import 'package:trainformforinspection/Models/Cleanlines-Model.dart';

class Trainmodel {
  Trainmodel({
    required this.stationName,
    required this.date,
    required this.coachWiseCleanlinesParameter,
  });

  String stationName;
  String date;

  Map<String, Map<String, Cleanlinesmodel>> coachWiseCleanlinesParameter;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> coachWiseMap = {};

    coachWiseCleanlinesParameter.forEach((coachName, parameterMap) {
      Map<String, dynamic> singleCoachParams = {};

      parameterMap.forEach((paramName, paramData) {
        singleCoachParams[paramName] = {
          'score': paramData.score,
          'remark': paramData.remark,
        };
      });

      coachWiseMap[coachName] = singleCoachParams;
    });

    return {
      'stationName': stationName,
      'date': date,
      'coachWise': coachWiseMap,
    };
  }


  factory Trainmodel.fromMap(Map<String, dynamic> map) {
    Map<String, Map<String, Cleanlinesmodel>> coachWise = {};

    (map['coachWise'] as Map<String, dynamic>).forEach((coachName, paramMap) {
      Map<String, Cleanlinesmodel> paramDataMap = {};

      (paramMap as Map<String, dynamic>).forEach((paramName, value) {
        paramDataMap[paramName] = Cleanlinesmodel(
          score: value['score'] ?? 0,
          remark: value['remark'] ?? '-',
        );
      });

      coachWise[coachName] = paramDataMap;
    });

    return Trainmodel(
      stationName: map['stationName'] ?? '',
      date: map['date'] ?? '',
      coachWiseCleanlinesParameter: coachWise,
    );
  }


}
