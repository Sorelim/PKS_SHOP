import 'package:flutter/material.dart';
import 'package:pks8/models/sneaker.dart';
import 'package:pks8/screens/sneaker_detail_screen.dart';
import 'package:pks8/screens/add_sneaker_screen.dart';
import 'package:pks8/screens/favorite_screen.dart';
import 'package:pks8/screens/user_screen.dart';
import 'package:pks8/screens/cart_screen.dart';
import 'package:pks8/widgets/sneaker_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Sneaker> sneakers = [
    Sneaker(
      id: 1,
      name: 'Зимние кроссовки New Balance',
      brand: 'New Balance',
      imageUrl: 'assets/images/nb2002.jpg',
      price: 100.0,
      description: 'Зимние кроссовки New Balance',
    ),
    Sneaker(
      id: 2,
      name: 'Зимние кроссовки PUMA',
      brand: 'Puma',
      imageUrl: 'assets/images/puma.jpg',
      price: 200.0,
      description: 'Зимние кроссовки PUMA',
    ),
    Sneaker(
      id: 3,
      name: 'Зимние кроссовки Adidas',
      brand: 'Adidas',
      imageUrl: 'assets/images/ozelia.jpg',
      price: 150.0,
      description: 'Зимние кроссовки Adidas',
    ),
    Sneaker(
      id: 4,
      name: 'Зимние кроссовки Nike Premium',
      brand: 'Nike',
      imageUrl: 'assets/images/nike.jpg',
      price: 180.0,
      description: 'Зимние кроссовки Nike Premium',
    ),
    Sneaker(
      id: 5,
      name: 'Зимние кроссовки Puma Premium',
      brand: 'Puma',
      imageUrl: 'assets/images/8nr384qzm1b24nhlvah4c6ul9bvmk4uk.jpg',
      price: 90.0,
      description: 'Зимние кроссовки Puma Premium',
    ),
    Sneaker(
      id: 6,
      name: 'Зимние кроссовки Adidas Premium',
      brand: 'Adidas',
      imageUrl: 'assets/images/tse7krujnklhk0v8ln4dlnjx8kab27so.jpg',
      price: 110.0,
      description: 'Зимние кроссовки Adidas Premium',
    ),
    Sneaker(
      id: 7,
      name: 'Зимние кроссовки New Balance Premier',
      brand: 'New Balance',
      imageUrl: 'assets/images/tse7krujnklhk0v8ln4dlnjx8kab27so.jpg',
      price: 200.0,
      description: 'Зимние кроссовки New Balance Premier',
    ),
    Sneaker(
      id: 8,
      name: 'Зимние кроссовки Nike Premier',
      brand: 'Nike',
      imageUrl: 'assets/images/ljt5zjoesb0aq4iybw1ti1pc822cx64z.jpg',
      price: 175.0,
      description: 'Зимние кроссовки Nike Premier',
    ),
    Sneaker(
      id: 9,
      name: 'Зимние кроссовки Adidas Premier',
      brand: 'Adidas',
      imageUrl: 'assets/images/adidas-winter-hiker-speed-cp-pl_1.jpg',
      price: 80.0,
      description: 'Зимние кроссовки Adidas Premier',
    ),
    Sneaker(
      id: 10,
      name: 'Зимние кроссовки Reebok Premier',
      brand: 'Reebok',
      imageUrl: 'assets/images/jdqme49fuh9g4nyxjadz056a3f4oc07u.jpg',
      price: 70.0,
      description: 'Зимние кроссовки Reebok Premier',
    ),
  ];

  List<Sneaker> favoriteSneakers = [];
  List<Sneaker> cartItems = [];

  void _toggleFavorite(Sneaker sneaker) {
    setState(() {
      if (favoriteSneakers.contains(sneaker)) {
        favoriteSneakers.remove(sneaker);
      } else {
        favoriteSneakers.add(sneaker);
      }
    });
  }

  void _deleteSneaker(Sneaker sneaker) {
    setState(() {
      sneakers.remove(sneaker);
      favoriteSneakers.remove(sneaker);
      cartItems.remove(sneaker);
    });
  }

  void _addToCart(Sneaker sneaker, int quantity) {
    setState(() {
      for (int i = 0; i < quantity; i++) {
        cartItems.add(sneaker);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      _buildHomeScreen(),
      FavoriteScreen(
        favoriteSneakers: favoriteSneakers,
        onToggleFavorite: _toggleFavorite,
        onAddToCart: _addToCart,
        onDelete: _deleteSneaker,
      ),
      CartScreen(cartItems: cartItems),
      UserScreen(),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 32, 100, 156),
        unselectedItemColor: const Color.fromARGB(255, 32, 100, 156),
        selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 32, 100, 156)),
        unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 32, 100, 156)),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
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
        child: const Icon(Icons.add_circle_outline_rounded),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Магазин зимней спортивной обуви')),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          const crossAxisCount = 2;
          final itemWidth = screenWidth / crossAxisCount;
          final itemHeight = itemWidth * 1.5;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Вся обувь',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: itemWidth / itemHeight,
                  ),
                  itemCount: sneakers.length,
                  itemBuilder: (context, index) {
                    return SneakerCard(
                      sneaker: sneakers[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SneakerDetailScreen(
                              sneaker: sneakers[index],
                              isFavorite: favoriteSneakers.contains(sneakers[index]),
                              onToggleFavorite: () => _toggleFavorite(sneakers[index]),
                              onDelete: () => _deleteSneaker(sneakers[index]),
                              onAddToCart: (quantity) => _addToCart(sneakers[index], quantity),
                            ),
                          ),
                        );
                      },
                      isFavorite: favoriteSneakers.contains(sneakers[index]),
                      onToggleFavorite: () => _toggleFavorite(sneakers[index]),
                      onAddToCart: (quantity) => _addToCart(sneakers[index], quantity),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}