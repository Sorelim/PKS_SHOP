import 'package:flutter/material.dart';
import '../models/sneaker.dart';

class SneakerCard extends StatelessWidget {
  final Sneaker sneaker;
  final VoidCallback onTap;

  SneakerCard({required this.sneaker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              _buildImage(),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sneaker.name,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      sneaker.brand,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                    ),
                    Text(
                      '\$${sneaker.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (sneaker.imagePath.startsWith('http')) {
      return Image.network(
        sneaker.imagePath,
        width: 100,
        height: 100,
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
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }
}