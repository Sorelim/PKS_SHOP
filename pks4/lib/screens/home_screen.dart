import 'package:flutter/material.dart';
import '../models/sneaker.dart';
import '../widgets/sneaker_card.dart';
import 'sneaker_detail_screen.dart';
import 'add_sneaker_screen.dart'; // Импортируем новый экран добавления товара

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Sneaker> sneakers = [
    Sneaker(
      id: '1',
      name: 'Зимние кроссовки New Balance',
      brand: 'New Balance',
      imagePath: 'assets/images/nb2002.jpg',
      price: 100.0,
      description: 'Зимние кроссовки New Balance.',
    ),
    Sneaker(
      id: '2',
      name: 'Зимние кроссовки PUMA',
      brand: 'Puma',
      imagePath: 'assets/images/puma.jpg',
      price: 200.0,
      description: 'Зимние кроссовки PUMA.',
    ),
    Sneaker(
      id: '3',
      name: 'Зимние кроссовки Adidas',
      brand: 'Adidas',
      imagePath: 'assets/images/ozelia.jpg',
      price: 150.0,
      description: 'Зимние кроссовки Adidas.',
    ),
    Sneaker(
      id: '4',
      name: 'Зимние кроссовки Nike.',
      brand: 'Nike',
      imagePath: 'assets/images/nike.jpg',
      price: 180.0,
      description: 'Зимние кроссовки Nike.',
    ),
  ];

  Future<bool> _confirmDelete(int index) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить этот товар?'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text('Магазин зимней спортивной обуви')),
      ),
      body: ListView.builder(
        itemCount: sneakers.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(sneakers[index].id),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await _confirmDelete(index);
            },
            onDismissed: (direction) {
              setState(() {
                sneakers.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: SneakerCard(
              sneaker: sneakers[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SneakerDetailScreen(sneaker: sneakers[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSneakerScreen(
                onAddSneaker: (Sneaker sneaker) {
                  setState(() {
                    sneakers.add(sneaker);
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add_circle_outline_rounded),
      ),
    );
  }
}