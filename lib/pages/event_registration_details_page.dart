import 'package:flutter/material.dart';
import 'package:flutter_crash_course_1/models/event.dart';
import 'package:flutter_crash_course_1/models/user.dart';
import 'package:flutter_crash_course_1/widgets/app_scaffold.dart';

class EventRegistrationDetailsPage extends StatefulWidget {
  final Event event;
  final User user;

  const EventRegistrationDetailsPage({
    super.key,
    required this.event,
    required this.user,
  });

  @override
  State<EventRegistrationDetailsPage> createState() =>
      _EventRegistrationDetailsPageState();
}

class _EventRegistrationDetailsPageState
    extends State<EventRegistrationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: Center(
          child: Column(
            spacing: 12.0,
            children: [
              Text(
                'Registration Detail',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Thank You for Your Registration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.user.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.event.title,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.user.icNum,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.user.email,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.user.school,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
