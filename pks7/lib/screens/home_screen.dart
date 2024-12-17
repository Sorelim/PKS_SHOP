
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CatalogServicesScreen extends StatelessWidget {
  const CatalogServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 27, top: 48),
              child: Text(
                'Каталог услуг',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat-Light',
                  letterSpacing: 0.08,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            SizedBox(height: 38),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ServiceCard(
                    title: 'ПЦР-тест на определение РНК коронавируса стандартный',
                    duration: '2 дня',
                    price: 1800,
                  ),
                  SizedBox(height: 16),
                  ServiceCard(
                    title: 'Клинический анализ крови с лейкоцитарной формулировкой',
                    duration: '1 день',
                    price: 690,
                  ),
                  SizedBox(height: 16),
                  ServiceCard(
                    title: 'Биохимический анализ крови, базовый',
                    duration: '1 день',
                    price: 2440,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String duration;
  final int price;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              letterSpacing: -0.05,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Color(0xFF939396),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$price ₽',
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  final cartProvider = Provider.of<CartProvider>(context, listen: false);
                  cartProvider.toggleItem(CartItemData(title: title, price: price, patients: 1));

                },
                child: const Text(
                  'Добавить',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(

                  backgroundColor: const Color.fromRGBO(26, 111, 238, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  minimumSize: const Size(70, 40),
                  fixedSize: const Size.fromHeight(40),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
