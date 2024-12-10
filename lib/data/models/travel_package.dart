class TravelPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final String imageUrl;
  final List<String> highlights;
  final String location;
  final double rating;

  TravelPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.imageUrl,
    required this.highlights,
    required this.location,
    required this.rating,
  });

  factory TravelPackage.fromJson(Map<String, dynamic> json) {
    return TravelPackage(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      imageUrl: json['imageUrl'],
      highlights: List<String>.from(json['highlights']),
      location: json['location'],
      rating: json['rating'].toDouble(),
    );
  }
}
