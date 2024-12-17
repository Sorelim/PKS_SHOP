import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';
import 'package:sneaker_shop/screens/sneaker_detail_screen.dart';
import 'package:sneaker_shop/screens/add_sneaker_screen.dart';
import 'package:sneaker_shop/screens/favorite_screen.dart';
import 'package:sneaker_shop/screens/user_screen.dart';
import 'package:sneaker_shop/screens/cart_screen.dart';
import 'package:sneaker_shop/widgets/sneaker_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Sneaker> sneakers = [
    Sneaker(
      id: '1',
      name: 'Зимние кроссовки New Balance',
      brand: 'New Balance',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/f89/500_500_1/hl8rprousyda4tg7n7taosfug763sap3.jpg',
      price: 100.0,
      description: 'Зимние кроссовки Nike',
    ),
    Sneaker(
      id: '2',
      name: 'Зимние кроссовки PUMA',
      brand: 'Puma',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/6ae/500_500_1/wgmqbird5qntsgt2sjimb08st8kpgovx.jpg',
      price: 200.0,
      description: 'Зимние кроссовки',
    ),
    Sneaker(
      id: '3',
      name: 'Зимние кроссовки Adidas',
      brand: 'Adidas',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/a4c/500_500_1/ornnvf52ols7t2jwrmze4q1frzo00z5c.jpg',
      price: 150.0,
      description: 'Зимние кроссовки Adidas',
    ),
    Sneaker(
      id: '4',
      name: 'Зимние кроссовки Nike Premium',
      brand: 'Nike',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/cad/500_500_1/o9ma5eiavx5iw6x8gsxbl1ahxwbwravt.jpg',
      price: 180.0,
      description: 'Зимние кроссовки Nike Premium',
    ),
    Sneaker(
      id: '5',
      name: 'Зимние кроссовки Puma Premium',
      brand: 'Puma',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/6ae/500_500_1/wgmqbird5qntsgt2sjimb08st8kpgovx.jpg',
      price: 90.0,
      description: 'Зимние кроссовки Puma Premium',
    ),
    Sneaker(
      id: '6',
      name: 'Зимние кроссовки Adidas Premium',
      brand: 'Adidas',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/a4c/500_500_1/ornnvf52ols7t2jwrmze4q1frzo00z5c.jpg',
      price: 110.0,
      description: 'Зимние кроссовки Adidas Premium',
    ),
    Sneaker(
      id: '7',
      name: 'Зимние кроссовки New Balance Premier',
      brand: 'New Balance',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/f89/500_500_1/hl8rprousyda4tg7n7taosfug763sap3.jpg',
      price: 200.0,
      description: 'Зимние кроссовки New Balance Premier',
    ),
    Sneaker(
      id: '8',
      name: 'Зимние кроссовки Nike Premier',
      brand: 'Nike',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/cad/500_500_1/o9ma5eiavx5iw6x8gsxbl1ahxwbwravt.jpg',
      price: 175.0,
      description: 'Зимние кроссовки Nike Premier',
    ),
    Sneaker(
      id: '9',
      name: 'Зимние кроссовки Adidas Premier',
      brand: 'Adidas',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/a4c/500_500_1/ornnvf52ols7t2jwrmze4q1frzo00z5c.jpg',
      price: 80.0,
      description: 'Зимние кроссовки Adidas Premier',
    ),
    Sneaker(
      id: '10',
      name: 'Зимние кроссовки Reebok Premier',
      brand: 'Reebok',
      imagePath: 'ttps://static.street-beat.ru/upload/iblock/cf5/v7gak0tx7run2a36ukmswneb487hfzdd.jpg',
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
    final List<Widget> _widgetOptions = [
      _buildHomeScreen(),
      FavoriteScreen(
        favoriteSneakers: favoriteSneakers,
        onToggleFavorite: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      CartScreen(cartItems: cartItems),
      UserScreen(),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
        title: const Center(child: Text('Магазин зимней спортивной')),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final crossAxisCount = 2;
          final itemWidth = screenWidth / crossAxisCount;
          final itemHeight = itemWidth * 1.5;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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