import 'package:flutter/material.dart';
import 'package:nssapp/widgets/app_drawer.dart';
import 'package:nssapp/widgets/title_with_box.dart';
import 'package:nssapp/utils/routes.dart';

class Homeaa extends StatefulWidget {
  const Homeaa({super.key});

  @override
  State<Homeaa> createState() => _HomeaaState();
}

class _HomeaaState extends State<Homeaa> {

  void startWindow() {
    print("pressed");
    return;
  }

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // First three
            TitleWithBox(
              title: "Add events",
              imagePath: "./assets/images/attendance_.png",
              onImageOrArrowPressed: () {
                Navigator.pushNamed(context, Routes.addEvent);
              },
            ),
            const SizedBox(
              height: 5,
            ),
            TitleWithBox(
              title: "View all events",
              imagePath: "./assets/images/attendance_.png",
              onImageOrArrowPressed: () {
                Navigator.pushNamed(context, Routes.allEvents);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  startWindow();
                },
                child: Text("Start Attendance Window"))
          ]),
        ));
  }
}
