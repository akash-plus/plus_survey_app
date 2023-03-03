import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveySubmitted extends StatefulWidget {
  const SurveySubmitted({super.key});

  @override
  State<SurveySubmitted> createState() => _SurveySubmittedState();
}

class _SurveySubmittedState extends State<SurveySubmitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/allimages/splash_image_4.png",
              height: 250,
            ),
            Text(
              "THANK YOU",
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20.0,
            ),
            Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Thanks a bunch for filling that out. It means a lot to us, just like you do! We really appreciate you giving us a moment of your time today. Thanks for being you.",
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            InkWell(
              onTap: () => launchUrl(Uri.parse('https://getplus.in/FAQs.html')),
              child: Text(
                'Learn more',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w800,
                  fontSize: 35,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]),
    );
  }
}
