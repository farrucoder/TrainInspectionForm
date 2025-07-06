import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Train-Model.dart';
import '../Providers/Inspection-Form-Provider.dart';
import 'Home-Page.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({
    super.key,
    required this.cleanlinesData,
    required this.remarkController,
    required this.selectedScore,
  });

  final List<TextEditingController?> remarkController;
  final Trainmodel cleanlinesData;
  List<int?> selectedScore;

  final List<String> parametersList = [
    'Urine Check?',
    'Dustbin Check?',
    'Drinking Check?',
    'Mirror Check?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Summary")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Coach",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...parametersList.map(
                                (param) => Container(
                              width: 160,
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                param,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Coach Rows
                      Column(
                        children: List.generate(12, (coachIndex) {
                          final coachKey = 'C${coachIndex + 1}';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    coachKey,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                ...parametersList.map((param) {
                                  final score = cleanlinesData
                                      .coachWiseCleanlinesParameter[coachKey]
                                  ?[param]
                                      ?.score ??
                                      '-';
                                  final remark = cleanlinesData
                                      .coachWiseCleanlinesParameter[coachKey]
                                  ?[param]
                                      ?.remark ??
                                      '-';

                                  return Container(
                                    width: 160,
                                    margin: EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Score: $score',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          'Remark: $remark',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Submit Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green[500],
                ),
                onPressed: () async {
                  await Provider.of<Inspectionformprovider>(
                    context,
                    listen: false,
                  ).addDataToProvider(context, cleanlinesData);

                  if (context.mounted) {
                    clearAllControllerData();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                          (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void clearAllControllerData() {
    for (var controller in remarkController) {
      controller!.clear();
    }

    selectedScore = List.generate(4, (index) => null);
  }
}
