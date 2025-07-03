import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Allevents extends StatefulWidget {
  const Allevents({super.key});

  @override
  State<Allevents> createState() => _AlleventsState();
}

class _AlleventsState extends State<Allevents> {
  List<Map<String, dynamic>> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      final res = await http.post(Uri.parse('http://172.17.0.1:3000/allEvents'));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final events = data['events'] as List;

        setState(() {
          activities = events.map((e) => Map<String, dynamic>.from(e)).toList();
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
      body: activities.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: activities.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> event = activities[index];
                final rawDate = event['date'];
                final parsedDate = DateTime.tryParse(rawDate);
                final formattedDate = parsedDate != null
                    ? DateFormat('d MMMM y').format(parsedDate)
                    : rawDate;

                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${event['name']}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text("Date: $formattedDate"),
                        Text("Time: ${event['time']}"),
                        Text("Hours: ${event['hours']}"),
                        Text("AA: ${event['AA']}"),
                        Text("Remarks: ${event['remarks']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
