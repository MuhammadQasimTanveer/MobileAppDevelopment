import 'package:flutter/material.dart';
import '../models/place.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // create a mutable copy for Dismissible demo
  late List<Place> places;

  @override
  void initState() {
    super.initState();
    places = List<Place>.from(samplePlaces);
  }

  void _removePlace(int index) {
    final removed = places[index];
    setState(() => places.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed.name} removed'),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() => places.insert(index, removed));
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // a small header card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Swipe an item to remove it. Use Undo in the SnackBar.'),
              ),
            ),
          ),

          // list with separators and Dismissible items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final place = places[index];
                return Dismissible(
                  key: ValueKey(place.id),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.archive, color: Colors.white),
                  ),
                  onDismissed: (direction) => _removePlace(index),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(place.image, width: 56, height: 56, fit: BoxFit.cover),
                      ),
                      title: Text(place.name),
                      subtitle: Text(place.subtitle),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        // show detail bottom sheet (Stack + Card inside)
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (ctx) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(place.image, height: 140, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(place.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text(place.subtitle),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: places.length,
            ),
          ),
        ],
      ),
    );
  }
}
