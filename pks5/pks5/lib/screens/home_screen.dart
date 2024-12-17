import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';
import 'package:sneaker_shop/screens/sneaker_detail_screen.dart';
import 'package:sneaker_shop/screens/add_sneaker_screen.dart';
import 'package:sneaker_shop/screens/favorite_screen.dart';
import 'package:sneaker_shop/screens/user_screen.dart';
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
      imagePath: 'assets/images/nb2002.jpg',
      price: 100.0,
      description: 'Зимние кроссовки New Balance',
    ),
    Sneaker(
      id: '2',
      name: 'Зимние кроссовки PUMA',
      brand: 'Puma',
      imagePath: 'assets/images/puma.jpg',
      price: 200.0,
      description: 'Зимние кроссовки PUMA',
    ),
    Sneaker(
      id: '3',
      name: 'Зимние кроссовки Adidas',
      brand: 'Adidas',
      imagePath: 'assets/images/ozelia.jpg',
      price: 150.0,
      description: 'Зимние кроссовки Adidas',
    ),
    Sneaker(
      id: '4',
      name: 'Зимние кроссовки Nike',
      brand: 'Nike',
      imagePath: 'assets/images/nike.jpg',
      price: 180.0,
      description: 'Зимние кроссовки Nike',
    ),
    Sneaker(
      id: '5',
      name: 'Зимние кроссовки PUMA CA Pro Mid',
      brand: 'Puma',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/668/500_500_1/8nr384qzm1b24nhlvah4c6ul9bvmk4uk.jpg',
      price: 90.0,
      description: 'Зимние кроссовки PUMA CA Pro Mid',
    ),
    Sneaker(
      id: '6',
      name: 'Зимние кроссовки adidas Samba',
      brand: 'Adidas',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/4cd/500_500_1/tse7krujnklhk0v8ln4dlnjx8kab27so.jpg',
      price: 110.0,
      description: 'Зимние кроссовки adidas Samba',
    ),
    Sneaker(
      id: '7',
      name: 'Зимние кроссовки New Balance 327',
      brand: 'New Balance',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/b3e/500_500_1/ljt5zjoesb0aq4iybw1ti1pc822cx64z.jpg',
      price: 200.0,
      description: 'Зимние кроссовки New Balance 327',
    ),
    Sneaker(
      id: '8',
      name: 'Зимние кроссовки Nike Air Max 270',
      brand: 'Nike',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/74f/500_500_1/2oozrxd80bjznamh6wvggxz0yk3tarpp.JPG',
      price: 175.0,
      description: 'Зимние кроссовки Nike Air Max 270',
    ),
    Sneaker(
      id: '9',
      name: 'Зимние кроссовки adidas Ozweego',
      brand: 'Adidas',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/cd7/500_500_1/bted9qgh8pqsm3rc38b452wm16n0e812.jpg',
      price: 80.0,
      description: 'Зимние кроссовки adidas Ozweego',
    ),
    Sneaker(
      id: '10',
      name: 'Мужские кроссовки Reebok Premier Road Plus VI',
      brand: 'New Balance',
      imagePath: 'https://static.street-beat.ru/upload/resize_cache/iblock/8fe/500_500_1/jdqme49fuh9g4nyxjadz056a3f4oc07u.jpg',
      price: 70.0,
      description: 'Мужские кроссовки Reebok Premier Road Plus VI',
    ),
  ];

  List<Sneaker> favoriteSneakers = [];

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
      FavoriteScreen(favoriteSneakers: favoriteSneakers),
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
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 32, 100, 156),
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
        title: const Center(child: const Text('Магазин зимней спортивной обуви')),
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
                            ),
                          ),
                        );
                      },
                      isFavorite: favoriteSneakers.contains(sneakers[index]),
                      onToggleFavorite: () => _toggleFavorite(sneakers[index]),
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