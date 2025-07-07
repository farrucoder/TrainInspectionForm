import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';
import 'package:trainformforinspection/Pages/Home-Page.dart';
import 'package:trainformforinspection/Providers/Inspection-Form-Provider.dart';
import 'package:trainformforinspection/ReusableWidgets/helperButton.dart';
import 'package:trainformforinspection/ReusableWidgets/helperInputField.dart';
import 'package:trainformforinspection/Services/Bin-APIs-Services.dart';
import 'package:trainformforinspection/Utils/pdf-Generator.dart';
import '../Utils/Parameter-Constant-List.dart';
import 'custom-Toast.dart';

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
  bool isLoading = false;

  final List<TextEditingController?> remarkController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  //final TextEditingController remarkController = TextEditingController();

  List<int?> selectedScore = List.generate(4, (index) => null);

  final List<String> coachList = List.generate(12, (index) => 'C${index + 1}');

  List<bool> scoreNotSelected = List.generate(4, (index) => false);

  bool validateCurrentPageInputs() {
    for (int i = 0; i < ParameterConstantList.parametersList.length; i++) {
      if (selectedScore[i] == null) {
        scoreNotSelected[i] = true;
        return false;
      } else {
        scoreNotSelected[i] = false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.pageCount == 0 ? true : false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green[500],
          title: Text(
            'Coach Serial : C${widget.pageCount + 1}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: ParameterConstantList.parametersList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                ParameterConstantList.parametersList[i],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            Text(
                              'Select a score:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: scoreNotSelected[i]
                                    ? Colors.red
                                    : Colors.black,
                              ),
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
                                      groupValue: selectedScore[i],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedScore[i] = value!;
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
                              'Enter a remark(Optional):',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            helperInputField('Remark', remarkController[i]!),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              if (widget.pageCount != coachList.length - 1)
                Row(
                  children: [
                    if (widget.pageCount > 0)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Parameterspage(
                                  pageCount: widget.pageCount - 1,
                                  trainCleanlinesData:
                                      widget.trainCleanlinesData,
                                ),
                              ),
                            );
                          },
                          child: helperButton('Previous'),
                        ),
                      ),

                    if (widget.pageCount < coachList.length - 1)
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            bool isValid = validateCurrentPageInputs();

                            if (!isValid) {
                              setState(() {});
                              customToast('Please fill all scores.');
                              return;
                            }

                            setClealinesDataCoachWise();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Parameterspage(
                                  pageCount: widget.pageCount + 1,
                                  trainCleanlinesData:
                                      widget.trainCleanlinesData,
                                ),
                              ),
                            );
                          },
                          child: helperButton('Next'),
                        ),
                      ),
                  ],
                ),

              if (widget.pageCount == coachList.length - 1)
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {

                          bool isValid = validateCurrentPageInputs();

                          if (!isValid) {
                            setState(() {});
                            customToast('Please fill all scores.');
                            return;
                          }

                          setClealinesDataCoachWise();

                          final pdfData = await PdfGenerator.generatePdf(widget.trainCleanlinesData);

                          await Printing.layoutPdf(onLayout: (format) => pdfData);

                        },
                        child: helperButton('Preview'),
                      ),
                    ),

                    SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          bool isValid = validateCurrentPageInputs();

                          if (!isValid) {
                            setState(() {});
                            customToast('Please fill all scores.');
                            return;
                          }

                          //Set data to coach wise
                          setClealinesDataCoachWise();

                          setState(() {
                            isLoading = true;
                          });

                          //WebHook - send data to api
                          final data = await BinAPIsService.sendDataToBin(
                            widget.trainCleanlinesData,
                          );

                          if (context.mounted) {
                            await Provider.of<Inspectionformprovider>(
                              context,
                              listen: false,
                            ).addDataToProvider(context, data!);
                          }

                          setState(() {
                            isLoading = false;
                          });

                          if (context.mounted) {
                            clearAllControllerData();

                            customToast('Form has been submitted');

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        child: isLoading
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green[500],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            : helperButton('Submit'),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void setClealinesDataCoachWise() {
    String currentCoach = 'C${widget.pageCount + 1}';

    for (int i = 0; i < ParameterConstantList.parametersList.length; i++) {
      final param = ParameterConstantList.parametersList[i];

      final paramData = widget
          .trainCleanlinesData
          .coachWiseCleanlinesParameter[currentCoach]?[param];

      paramData!.score = selectedScore[i]!;
      paramData.remark = remarkController[i]?.text ?? '-';
    }
  }

  void clearAllControllerData() {
    for (var controller in remarkController) {
      controller!.clear();
    }

    selectedScore = List.generate(4, (index) => null);
  }
}
