// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pks_shop_upd/models/sneaker.dart';
import 'package:pks_shop_upd/screens/sneaker_detail_screen.dart';
import 'package:pks_shop_upd/screens/add_sneaker_screen.dart';
import 'package:pks_shop_upd/screens/favorite_screen.dart';
import 'package:pks_shop_upd/screens/user_screen.dart';
import 'package:pks_shop_upd/screens/cart_screen.dart';
import 'package:pks_shop_upd/widgets/sneaker_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen.dart'; // Импортируйте AuthScreen
import 'account_screen.dart'; // Импортируйте AccountScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String? _selectedBrand;
  String? _selectedSortOption;
  String? _selectedPriceOrder; 
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
  List<Sneaker> get filteredSneakers {
    return sneakers.where((sneaker) {
      final matchesSearch = sneaker.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesBrand = _selectedBrand == null || sneaker.brand == _selectedBrand;
      return matchesSearch && matchesBrand;
    }).toList();
  }

  List<Sneaker> favoriteSneakers = [];
  List<Sneaker> cartItems = [];

  // Добавьте переменные для хранения данных пользователя
  String _name = 'Ваше имя'; // Замените на актуальное значение
  String _email = 'ваш_email@gmail.com'; // Замените на актуальное значение
  String _phone = 'Ваш номер телефона'; // Замените на актуальное значение

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

  void _editSneaker(Sneaker updatedSneaker) {
    setState(() {
      int index = sneakers.indexWhere((s) => s.id == updatedSneaker.id);
      if (index != -1) {
        sneakers[index] = updatedSneaker;
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _sortSneakers() {
    setState(() {
      if (_selectedSortOption == 'По названию') {
        sneakers.sort((a, b) => a.name.compareTo(b.name));
      } else if (_selectedSortOption == 'По цене') {
        if (_selectedPriceOrder == 'По возрастанию') {
          sneakers.sort((a, b) => a.price.compareTo(b.price));
        } else if (_selectedPriceOrder == 'По убыванию') {
          sneakers.sort((a, b) => b.price.compareTo(a.price));
        }
      }
    });
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _selectedBrand = null;
      _selectedSortOption = null;
      _selectedPriceOrder = null; 
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
        onEdit: _editSneaker,
      ),
      CartScreen(cartItems: cartItems),
      UserScreen(
        isLogin: true,
        name: _name,
        email: _email,
        phone: _phone,
      ),
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
        title: const Center(child: Text('Магазин кроссовок')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск по названию',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: Text('Фильтр по бренду'),
                value: _selectedBrand,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBrand = newValue;
                  });
                },
                items: ['Nike', 'Adidas', 'Puma', 'New Balance']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Сортировка'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('По названию'),
                              onTap: () {
                                setState(() {
                                  _selectedSortOption = 'По названию';
                                  _selectedPriceOrder = null; // Сбросить порядок сортировки
                                  _sortSneakers();
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('По цене'),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Выберите порядок сортировки'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('По возрастанию'),
                                            onTap: () {
                                              setState(() {
                                                _selectedSortOption = 'По цене';
                                                _selectedPriceOrder = 'По возрастанию';
                                                _sortSneakers();
                                              });
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            title: Text('По убыванию'),
                                            onTap: () {
                                              setState(() {
                                                _selectedSortOption = 'По цене';
                                                _selectedPriceOrder = 'По убыванию';
                                                _sortSneakers();
                                              });
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _resetFilters,
            child: Text('Сбросить фильтры'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredSneakers.length,
              itemBuilder: (context, index) {
                return SneakerCard(
                  sneaker: filteredSneakers[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SneakerDetailScreen(
                          sneaker: filteredSneakers[index],
                          isFavorite: favoriteSneakers.contains(filteredSneakers[index]),
                          onToggleFavorite: () => _toggleFavorite(filteredSneakers[index]),
                          onDelete: () => _deleteSneaker(filteredSneakers[index]),
                          onAddToCart: (quantity) => _addToCart(filteredSneakers[index], quantity),
                          onEdit: _editSneaker,
                        ),
                      ),
                    );
                  },
                  isFavorite: favoriteSneakers.contains(filteredSneakers[index]),
                  onToggleFavorite: () => _toggleFavorite(filteredSneakers[index]),
                  onAddToCart: (quantity) => _addToCart(filteredSneakers[index], quantity),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}