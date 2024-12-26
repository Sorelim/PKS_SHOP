import 'package:flutter/material.dart';
import 'package:pks_shop_upd/models/sneaker.dart';
import 'package:pks_shop_upd/screens/edit_sneaker_screen.dart';

class SneakerDetailScreen extends StatelessWidget {
  final Sneaker sneaker;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;
  final Function(int) onAddToCart;
  final Function(Sneaker) onEdit;

  const SneakerDetailScreen({
    super.key,
    required this.sneaker,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onAddToCart,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sneaker.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSneakerScreen(
                    sneaker: sneaker,
                    onSave: (updatedSneaker) {
                      onEdit(updatedSneaker);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
          ),
        ],
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
                  const SizedBox(height: 8),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}