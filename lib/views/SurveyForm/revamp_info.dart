import 'package:PLUS/styles/colors.dart';
import 'package:PLUS/views/SurveyForm/survey_form_screen.dart';
import 'package:flutter/material.dart';

class Revamp_Info extends StatefulWidget {
  const Revamp_Info({super.key});

  @override
  State<Revamp_Info> createState() => _Revamp_InfoState();
}

class _Revamp_InfoState extends State<Revamp_Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.waving_hand,
            color: Colors.amberAccent[200],
            size: 60,
          ),
          Text(
            "Hey there!!",
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              // color: Colors.amberAccent[200],
              color: Colors.amberAccent[200],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Thanks for showing interest in PLUS. We are revamping the app to give you a great experience while saving for your next jewellery purchase. Please fill up the survey by tapping on the button below.",
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            child: Text(
              "Survey ➡",
              // textAlign: TextAlign.center,
              // textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                // fontFamily: Fon,
                color: Colors.black87,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyFormScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent[200],
                padding: EdgeInsets.all(8.0),
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // TextButton(
          //   onPressed: () => throw Exception(),
          //   child: const Text("Throw Test Exception"),
          // ),
        ],
      ),
    );
  }
}
