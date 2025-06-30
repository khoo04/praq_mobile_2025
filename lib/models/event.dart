class Event {
  final String title;
  final String image;
  final String description;

  Event({required this.title, required this.image, required this.description});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['Title'],
      image: "assets/images/${json['ID']}.png",
      description: json['Description'],
    );
  }
}
