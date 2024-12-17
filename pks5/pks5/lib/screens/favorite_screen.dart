import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';
import 'package:sneaker_shop/widgets/sneaker_card.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Sneaker> favoriteSneakers;

  const FavoriteScreen({Key? key, required this.favoriteSneakers}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Sneaker> get favoriteSneakers => widget.favoriteSneakers;

  void _toggleFavorite(Sneaker sneaker) {
    setState(() {
      favoriteSneakers.remove(sneaker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Избранное')),
      ),
      body: favoriteSneakers.isEmpty
          ? Center(
        child: Text('Нет избранных товаров'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: favoriteSneakers.length,
        itemBuilder: (context, index) {
          return SneakerCard(
            sneaker: favoriteSneakers[index],
            onTap: () {},
            isFavorite: true,
            onToggleFavorite: () => _toggleFavorite(favoriteSneakers[index]),
          );
        },
      ),
    );
  }
}