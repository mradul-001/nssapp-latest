import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final hoursController = TextEditingController();
  final aaController = TextEditingController();
  final remarksController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
      dateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
      final now = DateTime.now();
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      timeController.text =
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
    }
  }

  void saveEvent() async {

    var reqBody = {
      "name": nameController.text,
      "date": dateController.text,
      "time": timeController.text,
      "hours": hoursController.text,
      "AA": aaController.text,
      "remarks": remarksController.text,
    };
    var response = await http.post(Uri.parse("http://172.17.0.1:3000/addEvent"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message'] ?? "Success"),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message'] ?? "Failure"),
          duration: const Duration(seconds: 3),
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name")),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Date"),
                readOnly: true,
                onTap: _pickDate,
              ),
              TextFormField(
                controller: timeController,
                decoration: const InputDecoration(labelText: "Time"),
                readOnly: true,
                onTap: _pickTime,
              ),
              TextFormField(
                  controller: hoursController,
                  decoration: const InputDecoration(labelText: "Hours"),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: aaController,
                  decoration: const InputDecoration(labelText: "AA")),
              TextFormField(
                  controller: remarksController,
                  decoration: const InputDecoration(labelText: "Remarks")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveEvent();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
