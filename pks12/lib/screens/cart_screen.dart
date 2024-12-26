import 'package:flutter/material.dart';
import 'package:pks_shop_upd/models/sneaker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pks_shop_upd/screens/orders_screen.dart'; // Импорт экрана "Мои заказы"

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
          title: Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить ${sneaker.name} из корзины?'),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  double getTotalPrice() {
    double total = 0;
    for (var sneaker in widget.cartItems) {
      total += sneaker.price * (itemQuantities[sneaker.id] ?? 1);
    }
    return total;
  }

  Future<void> _placeOrder() async {
    // Вычисляем общую сумму заказа
    double totalPrice = getTotalPrice();

    // Получаем текущего пользователя
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    // Сохраняем заказ в Firestore
    await FirebaseFirestore.instance.collection('orders').add({
      'userId': user.uid,
      'items': widget.cartItems.map((sneaker) {
        return {
          'id': sneaker.id,
          'name': sneaker.name,
          'price': sneaker.price,
          'quantity': itemQuantities[sneaker.id] ?? 1,
        };
      }).toList(),
      'totalPrice': totalPrice,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Показываем уведомление об успешном оформлении заказа
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Заказ успешно оформлен!')),
    );

    // Очищаем корзину
    setState(() {
      widget.cartItems.clear();
      itemQuantities.clear();
    });

    // Перенаправляем пользователя на экран "Мои заказы"
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OrdersScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Корзина')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Image.network(sneaker.imageUrl),
                    title: Text(sneaker.name),
                    subtitle: Text('${sneaker.price} \$'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _decrementQuantity(sneaker),
                        ),
                        Text('${itemQuantities[sneaker.id] ?? 1}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _incrementQuantity(sneaker),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Общая сумма: ${getTotalPrice()} \$',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: widget.cartItems.isEmpty ? null : _placeOrder,
                  child: Text('Оформить заказ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}