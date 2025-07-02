import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  
  List<String> activities = [];
  final List<String> aas = ['AA1', 'AA2', 'AA3'];

  String? selectedActivity;
  String? selectedAA;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      final res =
          await http.get(Uri.parse('http://localhost:3000/getEventData'));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final events = data['events'] as List;
        setState(() {
          activities = events.map<String>((e) => e['name'].toString()).toList();
        });
      } else {
        print("Error fetching data: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: const Color.fromARGB(255, 1, 1, 59),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Activity'),
                  items: activities
                      .map((activity) => DropdownMenuItem(
                            value: activity,
                            child: Text(activity),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedActivity = val),
                  validator: (val) =>
                      val == null ? 'Please select an activity' : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Activity: $selectedActivity, AA: $selectedAA");
                    }
                  },
                  child: const Text('Mark Attendance'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
