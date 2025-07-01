import 'dart:convert';
import 'package:nssapp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  int currentStep = 1;

  // validation variables
  bool nameValid = true;
  bool rollValid = true;
  bool phoneValid = true;
  bool emailValid = true;
  bool passValid = true;

  // define controllers for various text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // dispose method to avoid memory leaks
  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    phoneController.dispose();
    deptController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    var regBody = {
      "roll": rollController.text,
      "name": nameController.text,
      "mobile": phoneController.text,
      "dept": deptController.text,
      "email": emailController.text,
      "password": passwordController.text
    };
    var response = await http.post(
        Uri.parse("http://172.17.0.1:3000/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    // decode the json response
    var jsonResponse = jsonDecode(response.body);

    // handle the response from the server
    if (jsonResponse['status']) {
      Navigator.pushNamed(context, Routes.loginRoute);
    } else {
      // print the custom message
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
    return Column(
      children: [
        // showing back button when we are at second or third view
        if (currentStep > 1) ...[
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Aligns the icon to the start
              children: [
                IconButton(
                  onPressed: () {
                    if (currentStep == 2 || currentStep == 3) {
                      setState(() {
                        currentStep--;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ] else ...[
          const SizedBox(
            height: 55,
          ),
        ],
        // all the views
        Column(children: [
          // FIRST VIEW
          if (currentStep == 1) ...[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                errorText: !nameValid ? "Please enter your name." : null,
                labelText: 'Name',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: rollController,
              decoration: InputDecoration(
                errorText: !rollValid ? "Please enter your roll number." : null,
                labelText: 'Roll Number',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Color.fromARGB(255, 1, 1, 59),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ]
          // SECOND VIEW
          else if (currentStep == 2) ...[
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                errorText:
                    !phoneValid ? "Please enter your phone number." : null,
                labelText: 'Phone',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: deptController,
              decoration: InputDecoration(
                labelText: 'Department',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Color.fromARGB(255, 1, 1, 59),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ]
          // THIRD VIEW
          else if (currentStep == 3) ...[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                errorText:
                    !emailValid ? "Please enter your email address." : null,
                labelText: 'Email',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                errorText: !passValid ? "Please enter your password." : null,
                labelText: 'Password',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Color.fromARGB(255, 1, 1, 59),
                ),
              ],
            ),
          ]
        ]),
        const SizedBox(height: 20),
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
              setState(() {
                if (currentStep == 1) {
                  nameValid = nameController.text.isNotEmpty;
                  rollValid = rollController.text.isNotEmpty;

                  if (nameValid && rollValid) {
                    currentStep++;
                  }
                } else if (currentStep == 2) {
                  phoneValid = phoneController.text.isNotEmpty;

                  if (phoneValid) {
                    currentStep++;
                  }
                } else if (currentStep == 3) {
                  emailValid = emailController.text.isNotEmpty;
                  passValid = passwordController.text.isNotEmpty;

                  if (emailValid && passValid) {
                    registerUser();
                  }
                }
              });
            },
            child: Text(
              currentStep < 3 ? "Next" : "Submit",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
      ],
    );
  }
}
