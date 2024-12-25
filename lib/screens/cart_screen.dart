import 'package:flutter/material.dart';
import 'package:pks8/models/sneaker.dart';

class CartScreen extends StatefulWidget {
  final List<Sneaker> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<int, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    _initializeQuantities();
  }

  void _initializeQuantities() {
    for (var sneaker in widget.cartItems) {
      itemQuantities[sneaker.id] = itemQuantities[sneaker.id] ?? 1;
    }
  }

  void _incrementQuantity(Sneaker sneaker) {
    setState(() {
      itemQuantities[sneaker.id] = (itemQuantities[sneaker.id] ?? 0) + 1;
    });
  }

  void _decrementQuantity(Sneaker sneaker) {
    setState(() {
      if ((itemQuantities[sneaker.id] ?? 0) > 1) {
        itemQuantities[sneaker.id] = (itemQuantities[sneaker.id] ?? 0) - 1;
      } else {
        _removeItem(sneaker);
      }
    });
  }

  void _removeItem(Sneaker sneaker) {
    setState(() {
      widget.cartItems.remove(sneaker);
      itemQuantities.remove(sneaker.id);
    });
  }

  Future<bool> _confirmDismiss(Sneaker sneaker) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить ${sneaker.name} из корзины?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Удалить'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Корзина')),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final sneaker = widget.cartItems[index];
          return Dismissible(
            key: Key(sneaker.id.toString()),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) => _confirmDismiss(sneaker),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: Image.network(sneaker.imageUrl),
              title: Text(sneaker.name),
              subtitle: Text('${sneaker.price} \$'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _decrementQuantity(sneaker),
                  ),
                  Text('${itemQuantities[sneaker.id] ?? 1}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _incrementQuantity(sneaker),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}