import 'package:flutter/material.dart';
import 'package:flutter_crash_course_1/pages/event_details_page.dart';
import 'package:flutter_crash_course_1/pages/webview_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/ws_logo.png",
          width: 64,
          height: 64,
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: EventListTile(),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EventDetailsPage()));
                  },
                );
              },
              itemCount: 8,
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => WebviewPage()));
        },
        child: SizedBox(
          height: 45,
          child: Center(
            child: Text("Official Website"),
          ),
        ),
      ),
    );
  }
}

class EventListTile extends StatelessWidget {
  const EventListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12.0),
      ),
      height: 100,
      child: Row(
        spacing: 8.0,
        children: [
          Image.network(
            "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg",
            width: 120,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a placerat neque. Etiam a congue libero. Integer auctor odio quis mi auctor, dictum suscipit Etiam a congue libero. Integer auctor odio quis mi auctor, dictum suscipit",
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
