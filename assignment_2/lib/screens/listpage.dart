import 'package:flutter/material.dart';

class Listpage extends StatelessWidget {
  const Listpage({super.key});

  //List of Maps — each Map has keys and values
  final List<Map<String, String>> destinations = const [
    {"name": "Paris", "desc": "City of Light, home of the Eiffel Tower."},
    {"name": "Tokyo", "desc": "Blend of tradition and technology."},
    {"name": "New York", "desc": "The city that never sleeps."},
    {"name": "Sydney", "desc": "Famous for its Opera House."},
    {"name": "Dubai", "desc": "Luxury, innovation, and desert adventures."},
    {"name": "London", "desc": "Rich in history and culture."},
    {"name": "Rome", "desc": "Ancient ruins and modern charm."},
    {"name": "Bangkok", "desc": "Vibrant markets and golden temples."},
    {"name": "Bali", "desc": "Island paradise with beaches and temples."},
    {"name": "Istanbul", "desc": "Where East meets West."},
  ];

  @override
  Widget build(BuildContext context) {
    //to show list dynamically, use ListviewBuilder otherwise use just Listview
    return ListView.builder(
      itemCount: destinations.length,    //tells flutter how many items to create

      itemBuilder: (context, index)     //constructor that builds list items lazily
      {
        final place = destinations[index];  //current item
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.location_on, color: Colors.teal),
            title: Text(place["name"]!),
            subtitle: Text(place["desc"]!),
          ),
        );
      },
    );
  }
}