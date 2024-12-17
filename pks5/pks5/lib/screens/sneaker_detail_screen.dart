import 'package:flutter/material.dart';
import 'package:sneaker_shop/models/sneaker.dart';

class SneakerDetailScreen extends StatefulWidget {
  final Sneaker sneaker;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;

  const SneakerDetailScreen({
    Key? key,
    required this.sneaker,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onDelete,
  }) : super(key: key);

  @override
  _SneakerDetailScreenState createState() => _SneakerDetailScreenState();
}

class _SneakerDetailScreenState extends State<SneakerDetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onToggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sneaker.name),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.sneaker.imagePath, 
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Center(child: Text('Ошибка загрузки изображения'));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sneaker.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.sneaker.price} \$',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.sneaker.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить товар?'),
          content: Text('Вы уверены, что хотите удалить этот товар?'),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                widget.onDelete(); 
                Navigator.of(context).pop(); 
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }
}
