import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String _name = '123';
  String _email = 'mail@mail.ru';
  String _phone = '+7 (987) 654 32 10';

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = _name;
        String newEmail = _email;
        String newPhone = _phone;

        return AlertDialog(
          title: Text('Редактировать профиль'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => newName = value,
                  decoration: InputDecoration(labelText: 'Имя'),
                  controller: TextEditingController(text: _name),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) => newEmail = value,
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: TextEditingController(text: _email),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) => newPhone = value,
                  decoration: InputDecoration(labelText: 'Номер телефона'),
                  controller: TextEditingController(text: _phone),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = newName;
                  _email = newEmail;
                  _phone = newPhone;
                });
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Профиль')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text('Имя'),
              subtitle: Text(_name),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(_email),
            ),
            ListTile(
              title: Text('Номер телефона'),
              subtitle: Text(_phone),
            ),
            ElevatedButton(
              onPressed: _editProfile,
              child: Text('Редактировать профиль'),
            ),
          ],
        ),
      ),
    );
  }
}