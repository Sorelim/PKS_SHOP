import 'package:flutter/material.dart';
import 'package:pks8/models/sneaker.dart';
import 'package:pks8/widgets/sneaker_card.dart';
import 'package:pks8/screens/sneaker_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Sneaker> favoriteSneakers;
  final Function(Sneaker) onToggleFavorite;
  final Function(Sneaker) onDelete;
  final Function(Sneaker, int) onAddToCart;

  const FavoriteScreen({
    Key? key,
    required this.favoriteSneakers,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Избранное')),
      ),
      body: favoriteSneakers.isEmpty
          ? const Center(
        child: Text('Нет избранных товаров'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.50,
        ),
        itemCount: favoriteSneakers.length,
        itemBuilder: (context, index) {
          final sneaker = favoriteSneakers[index];
          return SneakerCard(
            sneaker: sneaker,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SneakerDetailScreen(
                    sneaker: sneaker,
                    isFavorite: true,
                    onToggleFavorite: () => onToggleFavorite(sneaker),
                    onDelete: () => onDelete(sneaker),
                    onAddToCart: (quantity) => onAddToCart(sneaker, quantity),
                  ),
                ),
              );
            },
            isFavorite: true,
            onToggleFavorite: () => onToggleFavorite(sneaker),
            onAddToCart: (quantity) => onAddToCart(sneaker, quantity),
          );
        },
      ),
    );
  }
}