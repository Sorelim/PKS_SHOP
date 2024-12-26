import 'package:flutter/material.dart';
import 'package:pks8/models/sneaker.dart';

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
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    widget.sneaker.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.sneaker.name,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Добавляем вертикальный отступ между названием и ценой
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('${widget.sneaker.price} \$'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: widget.isFavorite ? Colors.red : null,
                            ),
                            onPressed: widget.onToggleFavorite,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () => widget.onAddToCart(_quantity),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}