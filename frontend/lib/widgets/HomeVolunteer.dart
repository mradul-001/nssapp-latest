import 'package:flutter/material.dart';
import 'package:nssapp/widgets/app_drawer.dart';
import 'package:nssapp/widgets/title_with_box.dart';
import 'package:nssapp/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class Homevolunteer extends StatelessWidget {
  const Homevolunteer({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First three
            TitleWithBox(
              title: "Mark your attendance",
              imagePath: "./assets/images/attendance_.png",
              onImageOrArrowPressed: () async {
                final url = Uri.parse(
                    "https://nss.gymkhana.iitb.ac.in/attendance-24//");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  print("Could not launch $url");
                }
              },
            ),
            const SizedBox(height: 24),
            TitleWithBox(
              title: "Get your Certificate",
              imagePath: "./assets/images/certificate_.png",
              onImageOrArrowPressed: () async {
                final url =
                    Uri.parse("https://nss.gymkhana.iitb.ac.in/certificates/");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  print("Couldn't launch $url");
                }
              },
            ),
            const SizedBox(height: 24),
            TitleWithBox(
              title: "Upcoming Events",
              imagePath: "./assets/images/events.png",
              onImageOrArrowPressed: () {
                Navigator.pushNamed(context, Routes.calendarRoute);
              },
            ),
            const SizedBox(height: 24),
            TitleWithBox(
              title: "Feedback",
              imagePath: "./assets/images/feedback.png",
              onImageOrArrowPressed: () {
                Navigator.pushNamed(context, Routes.feedbackRoute);
              },
            ),
            // Bottom 2 rows
          ],
        ),
      ),
    );
  }
}
