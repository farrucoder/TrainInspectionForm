import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainformforinspection/Models/Cleanlines-Model.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';
import 'package:trainformforinspection/Pages/Home-Page.dart';
import 'package:trainformforinspection/ReusableWidgets/custom-Toast.dart';
import 'package:trainformforinspection/ReusableWidgets/helperButton.dart';
import 'package:trainformforinspection/ReusableWidgets/helperInputField.dart';
import 'package:trainformforinspection/Utils/validationCheck.dart';

import '../Providers/Inspection-Form-Provider.dart';

class Parameterspage extends StatefulWidget {
  Parameterspage({
    super.key,
    required this.pageCount,
    required this.trainCleanlinesData,
  });

  final Trainmodel trainCleanlinesData;
  final int pageCount;

  @override
  State<Parameterspage> createState() => _ParameterspageState();
}

class _ParameterspageState extends State<Parameterspage> {


  final TextEditingController remarkController = TextEditingController();

  int? selectedScore;

  final List<String> parametersList = ['Urine Check', 'Dustbin Check', 'Drinking Check', 'Mirror Check',];

  @override
  Widget build(BuildContext context) {

    final inspectionProvider = Provider.of<Inspectionformprovider>(
      context,
      listen: false,
    );

    final currentPageDate = parametersList[widget.pageCount];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('lib/Assets/InspectionLogo.png', height: 200),
            ),

            SizedBox(height: 50),

            Center(
              child: Text(
                '$currentPageDate?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20),
            Text(
              'Enter a score:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 5,
              children: List<Widget>.generate(10, (index) {
                final score = index + 1;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(
                      value: score,
                      groupValue: selectedScore,
                      onChanged: (value) {
                        setState(() {
                          selectedScore = value!;
                        });
                      },
                    ),
                    Text('$score'),
                  ],
                );
              }),
            ),


            SizedBox(height: 20),
            Text(
              'Enter a remark:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5), //currentPageDate['remark']
            helperInputField('Remark', remarkController),

            SizedBox(height: 20),
            if (widget.pageCount != parametersList.length - 1)
              Row(
                children: [
                  if (parametersList.length > 0)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (widget.pageCount == 0) {
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Back'),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Parameterspage(
                                  pageCount: widget.pageCount - 1,
                                  trainCleanlinesData: widget.trainCleanlinesData,
                                ),
                              ),
                            );
                          }
                        },
                        child: helperButton('Previous'),
                      ),
                    ),

                  if (widget.pageCount < parametersList.length - 1)
                    Expanded(
                      child: InkWell(
                        onTap: () {

                          if(validationCheck(selectedScore.toString(),remarkController.text)){
                            customToast('Pleas first fill both details!!!');
                            return;
                          }

                          final cleanlinesParameter =
                              currentPageDate[widget.pageCount];

                          widget.trainCleanlinesData.cleanlinesParameter[cleanlinesParameter] =
                              Cleanlinesmodel(
                                score:  selectedScore!,
                                remark: remarkController.text,
                              );

                           remarkController.clear();
                          selectedScore = null;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Parameterspage(
                                pageCount: widget.pageCount + 1,
                                trainCleanlinesData: widget.trainCleanlinesData,
                              ),
                            ),
                          );
                        },
                        child: helperButton('Next'),
                      ),
                    ),
                ],
              ),
            if (widget.pageCount == parametersList.length - 1)
              InkWell(
                onTap: () async{

                  await inspectionProvider.addTrainCleanlinesData(widget.trainCleanlinesData);
                  if(context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                          (Route<dynamic> route) => false,
                    );
                  }
                },

                child: helperButton('Submit'),
              ),
          ],
        ),
      ),
    );
  }
}
