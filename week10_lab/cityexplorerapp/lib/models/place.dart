class Place {
  final String id;
  final String name;
  final String subtitle;
  final String image;

  Place({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.image,
  });
}

// sample places list (network images)
final List<Place> samplePlaces = [
  Place(
    id: 'p1',
    name: 'Old Town',
    subtitle: 'Historic district with cobblestone streets',
    image: 'https://images.unsplash.com/photo-1505761671935-60b3a7427bad',
  ),
  Place(
    id: 'p2',
    name: 'Riverfront Park',
    subtitle: 'Green promenade & evening lights',
    image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  ),
  Place(
    id: 'p3',
    name: 'Skyline View',
    subtitle: 'Panoramic rooftop viewpoint',
    image: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30',
  ),
  Place(
    id: 'p4',
    name: 'Art District',
    subtitle: 'Galleries and street murals',
    image: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
  ),
  Place(
    id: 'p5',
    name: 'Botanic Garden',
    subtitle: 'Glasshouse & themed gardens',
    image: 'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1',
  ),
  Place(
    id: 'p6',
    name: 'Harbor Lights',
    subtitle: 'Boats and seaside cafes',
    image: 'https://images.unsplash.com/photo-1499510318561-0bafd66f42b3',
  ),
];
