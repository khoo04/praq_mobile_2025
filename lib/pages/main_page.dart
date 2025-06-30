import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crash_course_1/pages/event_details_page.dart';
import 'package:flutter_crash_course_1/widgets/app_scaffold.dart';

import '../models/event.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Event>> eventFuture;
  final searchController = TextEditingController();
  String searchKeyword = '';

  Future<List<Event>> _loadEvents() async {
    final source = await rootBundle.loadString("assets/data.json");
    final decodedJson = jsonDecode(source) as List;
    final events = decodedJson.map<Event>((e) => Event.fromJson(e)).toList();
    return events;
  }

  @override
  void initState() {
    eventFuture = _loadEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search",
                isDense: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchKeyword = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: eventFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Error in loading data : ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.data == null) {
                    return Center(
                      child: Text("No events found"),
                    );
                  }
                  final events = snapshot.data!
                      .where((event) =>
                          event.title.toLowerCase().contains(searchKeyword))
                      .toList();
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return EventListTile(event: events[index]);
                      },
                      itemCount: events.length);
                }),
          ),
        ],
      ),
    );
  }
}

class EventListTile extends StatelessWidget {
  final Event event;

  const EventListTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                event: event,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            spacing: 12.0,
            children: [
              Image.asset(
                event.image,
                width: 80,
              ),
              Expanded(
                child: Column(
                  spacing: 4.0,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      event.description,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
