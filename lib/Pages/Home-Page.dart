import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainformforinspection/Pages/Inspection-Form-Page.dart';
import 'package:trainformforinspection/Providers/Inspection-Form-Provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
      appBar: AppBar(title: Center(child: Text('Inspection\'s List'))),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: inspectionFormDataList.isEmpty
            ? Center(
                child: Text(
                  'You have not inspected yet!!!',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: inspectionFormDataList.length,
                itemBuilder: (context, i) {
                  final inspectionData = inspectionFormDataList[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black87),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Inspection Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Divider(thickness: 1, endIndent: 15, indent: 15),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Train Name:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(inspectionData.stationName),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Date of inspection:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(inspectionData.date),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
