class Activity {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final String timestamp;
  final String createdAt;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    required this.timestamp,
    required this.createdAt,
  });

  // JSON to Object
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  // Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'createdAt': createdAt,
    };
  }

  // Copy with
  Activity copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? timestamp,
    String? createdAt,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}