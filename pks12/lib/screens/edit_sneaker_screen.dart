import 'package:flutter/material.dart';
import 'package:pks_shop_upd/models/sneaker.dart';

class EditSneakerScreen extends StatefulWidget {
  final Sneaker sneaker;
  final Function(Sneaker) onSave;

  const EditSneakerScreen({
    super.key,
    required this.sneaker,
    required this.onSave,
  });

  @override
  _EditSneakerScreenState createState() => _EditSneakerScreenState();
}

class _EditSneakerScreenState extends State<EditSneakerScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _brandController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sneaker.name);
    _priceController = TextEditingController(text: widget.sneaker.price.toString());
    _descriptionController = TextEditingController(text: widget.sneaker.description);
    _imageUrlController = TextEditingController(text: widget.sneaker.imageUrl);
    _brandController = TextEditingController(text: widget.sneaker.brand);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать товар'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final updatedSneaker = Sneaker(
                id: widget.sneaker.id,
                name: _nameController.text,
                brand: _brandController.text,
                price: double.parse(_priceController.text),
                description: _descriptionController.text,
                imageUrl: _imageUrlController.text,
              );
              widget.onSave(updatedSneaker);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Описание'),
              maxLines: 3,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'URL изображения'),
            ),
            TextField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Бренд'),
            ),
          ],
        ),
      ),
    );
  }
}