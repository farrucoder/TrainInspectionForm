import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainformforinspection/Pages/Inspection-Form-Page.dart';
import 'package:trainformforinspection/Providers/Inspection-Form-Provider.dart';

import '../Utils/Parameter-Constant-List.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();

    if(mounted) {
      Future.microtask(() {
        Provider
            .of<Inspectionformprovider>(context, listen: false)
            .getDataFromProvider();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final inspectionProvider = Provider.of<Inspectionformprovider>(
      context,
      listen: true,
    );
    final inspectionFormDataList = inspectionProvider.trainModel;


    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Inspectionformpage()),
          );
        },
        label: Text('New Form'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Center(child: Text("Inspection's List",style: TextStyle(color: Colors.white),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: inspectionFormDataList.isEmpty
            ? Center(
          child: Text(
            'You have not inspected yet!!!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.builder(
          itemCount: inspectionFormDataList.length,
          itemBuilder: (context, index) {
            final inspection = inspectionFormDataList[index];

            return Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Inspection Details',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 1),
                  Row(
                    children: [
                      Text(
                        'Train Name: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(inspection.stationName),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Date of Inspection: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(inspection.date),
                    ],
                  ),
                  SizedBox(height: 15),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Parameters',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            for (final param in ParameterConstantList.parametersList)
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                child: Text(param),
                              ),
                          ],
                        ),
                      ),


                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(12, (coachIndex) {
                              final coachKey = 'C${coachIndex + 1}';
                              return Container(
                                margin: EdgeInsets.only(right: 12),
                                width: 100,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coachKey,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    for (final param in ParameterConstantList.parametersList)
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Score: ${inspection.coachWiseCleanlinesParameter[coachKey]?[param]?.score ?? '-'}'),
                                            Text(
                                              'Remark: ${inspection.coachWiseCleanlinesParameter[coachKey]?[param]?.remark ?? '-'}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
