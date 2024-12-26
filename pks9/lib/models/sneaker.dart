class Sneaker {
  final int id;
  final String name;
  final double price;
  final String brand;
  final String description;
  final String imageUrl;

  Sneaker({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.brand,
    required this.imageUrl,
  });

  factory Sneaker.fromJson(Map<String, dynamic> json) {
    return Sneaker(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      brand: json['brand'],
      imageUrl: json['image_url'],
    );
  }
}