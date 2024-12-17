import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';

class SneakerCard extends StatefulWidget {
  final Sneaker sneaker;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final Function(int) onAddToCart;

  const SneakerCard({
    Key? key,
    required this.sneaker,
    required this.onTap,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _SneakerCardState createState() => _SneakerCardState();
}

class _SneakerCardState extends State<SneakerCard> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                widget.sneaker.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.sneaker.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget.sneaker.price} \$'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.isFavorite ? Colors.red : null,
                  ),
                  onPressed: widget.onToggleFavorite,
                ),

                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => widget.onAddToCart(_quantity),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}