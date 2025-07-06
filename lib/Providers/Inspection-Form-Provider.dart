import 'package:flutter/cupertino.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';
import 'package:trainformforinspection/Services/Hive-DataBase-Services.dart';

class Inspectionformprovider extends ChangeNotifier {


   List<Trainmodel> _trainModel = [ ];

  List<Trainmodel> get trainModel => _trainModel;

   Future<void> addDataToProvider(BuildContext ctx,Trainmodel data) async {

     await HiveDataBaseServices.addDataToHive(data);

     await getDataFromProvider();

   }

  Future<void> getDataFromProvider() async {

    _trainModel.clear();

    _trainModel = await HiveDataBaseServices.getDataFromHive();

    notifyListeners();

  }


}
