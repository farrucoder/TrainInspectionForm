import 'package:flutter/material.dart';
import 'package:trainformforinspection/Models/Train-Model.dart';
import 'package:trainformforinspection/ReusableWidgets/Parameters-Page.dart';
import 'package:trainformforinspection/ReusableWidgets/helperButton.dart';
import 'package:trainformforinspection/ReusableWidgets/helperInputField.dart';
import 'package:trainformforinspection/Utils/datePicker.dart';
import '../Models/Cleanlines-Model.dart';
import '../ReusableWidgets/custom-Toast.dart';
import '../Utils/validationCheck.dart';

class Inspectionformpage extends StatefulWidget {
  Inspectionformpage({super.key});

  @override
  State<Inspectionformpage> createState() => _InspectionformpageState();
}

class _InspectionformpageState extends State<Inspectionformpage> {
  final TextEditingController stationNameController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inspection Form")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('lib/Assets/InspectionLogo.png', height: 200),
            ),
            SizedBox(height: 70),
            Text(
              'Enter a station name:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            helperInputField('Station Name', stationNameController),

            SizedBox(height: 15),
            Text(
              'Pick a date:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black87),
              ),
              child: TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Select Date",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? selectedDate = await pickDate(context);
                      if (selectedDate != null) {
                        setState(() {
                          dateController.text =
                              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),
            InkWell(
              onTap: () {
                if (validationCheck(
                  stationNameController.text,
                  dateController.text,
                )) {
                  customToast('Pleas first fill both details!!!');
                  return;
                }

                final Trainmodel trainmodel = Trainmodel(
                  stationName: stationNameController.text,
                  date: dateController.text,
                  cleanlinesParameter: {
                    '': Cleanlinesmodel(score: 0, remark: ''),
                  },
                );

                stationNameController.clear();
                dateController.clear();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Parameterspage(
                      pageCount: 0,
                      trainCleanlinesData: trainmodel,
                    ),
                  ),
                );
              },
              child: helperButton('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
