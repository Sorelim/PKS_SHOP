import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/sneaker.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  Future<List<Sneaker>> getSneakers() async {
    final response = await http.get(Uri.parse('$baseUrl/sneakers/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return (data).map((json) => Sneaker.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Ошибка загрузки товара');
    }
  }

  Future<void> addToFavorites(int sneakerId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/favorites/$sneakerId'),
    );
    if (response.statusCode != 200) {
      throw Exception('Ошибка добавления в избранное');
    }
  }

  Future<void> removeFromFavorites(int sneakerId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/favorites/$sneakerId'),
    );
    if (response.statusCode != 200) {
      throw Exception('Ошибка удаления из избранного');
    }
  }

  Future<List<Sneaker>> getFavorites() async {
    final response = await http.get(Uri.parse('$baseUrl/favorites/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return (data).map((json) => Sneaker.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Ошибка загрузки избранного');
    }
  }
} 