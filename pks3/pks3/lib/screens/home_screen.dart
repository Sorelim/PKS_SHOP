import 'package:flutter/material.dart';
import '../models/sneaker.dart';
import '../widgets/sneaker_card.dart';
import 'sneaker_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Sneaker> sneakers = [
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
      name: 'Зимние кроссовки Nike',
      brand: 'Nike',
      imagePath: 'assets/images/nike.jpg',
      price: 180.0,
      description: 'Зимние кроссовки Nike.',
    ),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text('Магазин зимней спортивной обуви')),
      ),
      body: ListView.builder(
        itemCount: sneakers.length,
        itemBuilder: (context, index) {
          return SneakerCard(
            sneaker: sneakers[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SneakerDetailScreen(sneaker: sneakers[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}