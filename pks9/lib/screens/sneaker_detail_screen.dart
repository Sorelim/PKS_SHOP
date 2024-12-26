import 'package:flutter/material.dart';
import 'package:pks8/models/sneaker.dart';

class SneakerDetailScreen extends StatelessWidget {
  final Sneaker sneaker;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;
  final Function(int) onAddToCart;

  const SneakerDetailScreen({
    Key? key,
    required this.sneaker,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sneaker.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              sneaker.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sneaker.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Цена: ${sneaker.price} \$',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    sneaker.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}