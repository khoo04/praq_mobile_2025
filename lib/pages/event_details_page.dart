import 'package:flutter/material.dart';
import 'package:flutter_crash_course_1/models/event.dart';
import 'package:flutter_crash_course_1/pages/event_register_page.dart';
import 'package:flutter_crash_course_1/widgets/app_scaffold.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8.0,
          children: [
            Text(
              'Event Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(widget.event.image, height: 160),
            ),
            Text(
              widget.event.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Builder(builder: (context) {
              return isReadMore
                  ? Text(
                      widget.event.description,
                    )
                  : Text(
                      widget.event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    );
            }),
            Align(
              alignment: Alignment.topLeft,
              child: Builder(builder: (context) {
                return isReadMore
                    ? SizedBox.shrink()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isReadMore = true;
                          });
                        },
                        child: Text(
                          'Read More...',
                          style: TextStyle(color: Colors.black.withAlpha(125)),
                        ),
                      );
              }),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventRegisterPage(event: widget.event),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
