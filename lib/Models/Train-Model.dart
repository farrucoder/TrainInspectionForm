import 'package:trainformforinspection/Models/Cleanlines-Model.dart';

class Trainmodel{

  Trainmodel({required this.stationName, required this.date,required this.cleanlinesParameter});

  String stationName;
  String date;

  Map<String,Cleanlinesmodel> cleanlinesParameter;

}
