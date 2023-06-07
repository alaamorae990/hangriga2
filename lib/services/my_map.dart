import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orders App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date and Time:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            RaisedButton(
              onPressed: () {
                DateTime now = DateTime.now();
                DateTime minDate = DateTime.now();
                // Exclude current date
                DateTime maxDate = now.add(Duration(days: 3));
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  minTime: minDate,
                  maxTime: maxDate,
                  onChanged: (time) {},
                  onConfirm: (time) {
                    // Check if the selected time is before 10 PM (22:00)
                    if (time.hour <= 21) { // 21 corresponds to 9 PM
                      setState(() {
                        selectedTime = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          time.hour,
                          time.minute,
                        );
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Invalid Time'),
                            content: Text('Please select a time before 10 PM.'),
                            actions: [
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
              },
              child: Text('Select'),
            ),
            SizedBox(height: 16.0),
            selectedTime != null
                ? Text(
              'Selected Date and Time: ${selectedTime != null ? selectedTime.toString() : 'Not selected'}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
                : SizedBox(),
            SizedBox(height: 16.0),
            RaisedButton(
              onPressed: selectedTime != null
                  ? () {
                saveOrder();
              }
                  : null,
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  void saveOrder() {
    // Save the order to Firebase Firestore
    FirebaseFirestore.instance.collection('orders').add({
      'arrival_date': selectedTime,
    }).then((value) {
      print('Order saved successfully!');
      // Perform any additional actions or show success message
    }).catchError((error) {
      print('Failed to save order: $error');
      // Handle the error
    });
  }
}
