import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';
import 'package:sneaker_shop/widgets/sneaker_card.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Sneaker> favoriteSneakers;
  final Function(Sneaker) onToggleFavorite;
  final Function(Sneaker, int) onAddToCart;

  const FavoriteScreen({
    Key? key,
    required this.favoriteSneakers,
    required this.onToggleFavorite,
    required this.onAddToCart,
  }) : super(key: key);

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
            onToggleFavorite: () => onToggleFavorite(favoriteSneakers[index]),
            onAddToCart: (quantity) => onAddToCart(favoriteSneakers[index], quantity),
          );
        },
      ),
    );
  }
}