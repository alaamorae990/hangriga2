import 'package:flutter/material.dart';
import 'package:hangry/consts/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintsPage extends StatelessWidget {
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'info.hungrigaab.se',
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klagomål och förslag'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.feedback,
              size: 64,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'Hur kan vi hjälpa dig?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Har du inte tagit emot din beställning?',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Har du fått fel beställning?',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Har beställningen blivit försenad?',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Jag har problem med betalningstjänster.',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Jag har ett annat problem?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'För att få hjälp, kontakta oss via e-postadress:',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'info@hungrigaab.se',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

