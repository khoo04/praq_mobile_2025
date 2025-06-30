import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_crash_course_1/models/event.dart';
import 'package:flutter_crash_course_1/models/user.dart';
import 'package:flutter_crash_course_1/pages/event_registration_details_page.dart';
import 'package:flutter_crash_course_1/widgets/app_scaffold.dart';
import 'package:image_picker/image_picker.dart';

class EventRegisterPage extends StatefulWidget {
  final Event event;

  const EventRegisterPage({super.key, required this.event});

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  //Form Key
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final icNumController = TextEditingController();
  final emailController = TextEditingController();
  final schoolInfoController = TextEditingController();
  final addressController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8.0,
                children: [
                  Text(
                    'Registration Form',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  selectedImage != null
                      ? Image.file(selectedImage!, height: 180)
                      : Container(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Text(
                              'Upload an image',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () => pickImageFromGallery(),
                    child: Text('Upload'),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "Name",
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: icNumController,
                    decoration: InputDecoration(
                        hintText: "IC",
                        labelText: "IC",
                        border: OutlineInputBorder(),
                        isDense: true),
                    onChanged: (value) {
                      //Replace all not digit, to extract digit number
                      String number = value.replaceAll(RegExp(r'\D'), '');

                      //6-2-4
                      String icString = '';
                      if (number.length > 12) {
                        icString =
                            "${number.substring(0, 6)}-${number.substring(6, 8)}-${number.substring(8, 12)}";
                      } else if (number.length > 8) {
                        icString =
                            "${number.substring(0, 6)}-${number.substring(6, 8)}-${number.substring(8)}";
                      } else if (number.length > 6) {
                        icString =
                            "${number.substring(0, 6)}-${number.substring(6)}";
                      } else {
                        icString = number;
                      }
                      icNumController.text = icString;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "IC is required";
                      } else if (!RegExp(r'[0-9]{6}-[0-9]{2}-[0-9]{4}')
                          .hasMatch(value)) {
                        return "IC Pattern is not matched";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return "Email pattern is not matched";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: schoolInfoController,
                    decoration: InputDecoration(
                        hintText: "School Information",
                        labelText: "School Information",
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "School Information is required";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: "Address",
                      labelText: "Address",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address is required";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _validateForm,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.sizeOf(context).width, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                      ),
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;
    setState(() {
      selectedImage = File(image.path);
    });
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedImage != null) {
        final user = User(
          name: nameController.text,
          icNum: icNumController.text,
          email: emailController.text,
          school: schoolInfoController.text,
          address: addressController.text,
          profilePic: selectedImage!.path,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventRegistrationDetailsPage(
              event: widget.event,
              user: user,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please choose an image.'),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
