import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController destinationController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network('https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
            height: 200, fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Welcome to Travel Guide App! Discover exciting destinations and plan your next adventure with ease.",
              style: TextStyle(fontSize: 16), textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: "Explore ", style: TextStyle(color: Colors.black, fontSize: 20)),
                TextSpan(
                  text: "the World ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                TextSpan(text: "with Us!"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: destinationController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(), labelText: "Enter Destination",
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Searching for ${destinationController.text.isEmpty ? "your destination" : destinationController.text}...')));
            },
            child: const Text("Search"),
          ),
          TextButton(
            onPressed: () {
              print("Explore button pressed");
            },
            child: const Text("Explore More"),
          ),
        ],
      ),
    );
  }
}
