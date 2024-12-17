import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';

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
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: onToggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Удалить товар?'),
                    content: Text('Вы уверены, что хотите удалить этот товар?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          onDelete();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Удалить'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(sneaker.imagePath),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                sneaker.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '${sneaker.price} \$',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                sneaker.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => onAddToCart(1),
                child: Text('Добавить в корзину'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}