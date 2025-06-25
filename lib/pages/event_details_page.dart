import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Number : $num"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            num++;
          });
          print(num);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
