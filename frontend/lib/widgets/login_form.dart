import 'dart:convert';
import 'package:nssapp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nssapp/utils/authenticator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  final AuthService _authService = AuthService();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  // dispose method to avoid memory leaks
  @override
  void dispose() {
    rollController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    var reqBody = {
      "roll": rollController.text,
      "password": passwordController.text,
      "isaa": isChecked,
    };

    var response = await http.post(Uri.parse("http://172.17.0.1:3000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      await _authService.saveToken(jsonResponse['userData']);
      rollController.text = "";
      passwordController.text = "";
      Navigator.pushNamed(context, Routes.homeRoute);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message'] ?? "Something went wrong."),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 242, 242, 242),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: rollController,
            decoration: InputDecoration(
              labelText: 'Roll Number',
              labelStyle: const TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const Text(
                "Activity Associate",
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 1, 1, 59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 50,
              ),
            ),
            onPressed: () {
              loginUser();
            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
