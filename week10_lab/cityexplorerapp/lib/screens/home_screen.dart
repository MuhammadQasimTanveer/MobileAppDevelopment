import 'package:flutter/material.dart';
import '../models/place.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar with Stack overlay (parallax-like header)
        SliverAppBar(
          pinned: true,
          expandedHeight: 260,
          backgroundColor: Theme.of(context).colorScheme.primary,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('City Explorer'),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  samplePlaces[2].image,
                  fit: BoxFit.cover,
                ),
                // gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.45),
                        Colors.transparent,
                        Colors.black.withOpacity(0.15),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // floating card positioned bottom-left
                const SizedBox(),
              ],
            ),
          ),
        ),

        // intro card using SliverToBoxAdapter
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // left side image + stack badge
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            samplePlaces[0].image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Top Pick', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // right side text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Discover the city', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('Explore curated places, see photos, and save favourites.', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        // a sliver grid (small gallery) using SliverToBoxAdapter + GridView within constrained box
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text('Highlights', style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final place = samplePlaces[index % samplePlaces.length];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(place.image, fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.25)),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(place.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 4,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
          ),
        ),

        // a sliver list of cards (SliverList)
        SliverList(
          delegate: SliverChildBuilderDelegate((context, idx) {
            final p = samplePlaces[idx % samplePlaces.length];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(p.image, width: 64, height: 64, fit: BoxFit.cover),
                  ),
                  title: Text(p.name),
                  subtitle: Text(p.subtitle),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            );
          }, childCount: samplePlaces.length),
        ),

        SliverToBoxAdapter(
          child: const SizedBox(height: 24),
        )
      ],
    );
  }
}
