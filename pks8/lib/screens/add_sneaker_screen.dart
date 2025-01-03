import 'package:flutter/material.dart';
import '../models/sneaker.dart';

class AddSneakerScreen extends StatefulWidget {
  final Function(Sneaker) onAddSneaker;

  const AddSneakerScreen({super.key, required this.onAddSneaker});

  @override
  _AddSneakerScreenState createState() => _AddSneakerScreenState();
}

class _AddSneakerScreenState extends State<AddSneakerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _brand = '';
  String _imagePath = '';
  double _price = 0.0;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить обувь'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Название товара'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название товара';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Бренд'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название бренда';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _brand = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'URL фото'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Добавьте фото';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _imagePath = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _imagePath = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_imagePath.isNotEmpty)
                  Image.network(
                    _imagePath,
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Ошибка загрузки изображения');
                    },
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Цена'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите цену';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Описание товара'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите описание товара';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Sneaker newSneaker = Sneaker(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: _name,
                        brand: _brand,
                        imageUrl: _imagePath,
                        price: _price,
                        description: _description,
                      );
                      widget.onAddSneaker(newSneaker);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Добавить обувь'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
