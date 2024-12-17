import 'package:flutter/material.dart';
import '../models/sneaker.dart';

class SneakerDetailScreen extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerDetailScreen({Key? key, required this.sneaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sneaker.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 16),
            Text(
              sneaker.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${sneaker.brand} | \$${sneaker.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              sneaker.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (sneaker.imagePath.startsWith('http')) {
      return Image.network(
        sneaker.imagePath,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error, size: 100);
        },
      );
    } else {
      return Image.asset(
        sneaker.imagePath,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}