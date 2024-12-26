import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pks_shop_upd/screens/orders_screen.dart'; // Импорт экрана "Мои заказы"

class UserScreen extends StatefulWidget {
  final bool isLogin;
  final String name;
  final String email;
  final String phone;

  const UserScreen({
    super.key,
    required this.isLogin,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String _name;
  late String _email;
  late String _phone;
  bool _isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    _phone = widget.phone;
    _checkAuthState();
  }

  void _checkAuthState() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Если пользователь уже авторизован, загружаем данные профиля
      await _loadUserData(user.uid);
    }
  }

  Future<void> _loadUserData(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      setState(() {
        _name = userDoc['username'] ?? '';
        _email = userDoc['email'] ?? '';
        _phone = userDoc['phone'] ?? '';
      });
    }
  }

  Future<void> _submit() async {
    try {
      if (_isLogin) {
        // Авторизация
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print("User logged in: ${userCredential.user?.uid}");
        // Загружаем данные пользователя
        await _loadUserData(userCredential.user!.uid);
      } else {
        // Регистрация
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Сохранение данных пользователя в Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'created_at': FieldValue.serverTimestamp(),
        });

        print("User registered: ${userCredential.user?.uid}");
        // Загружаем данные пользователя
        await _loadUserData(userCredential.user!.uid);
      }
    } catch (e) {
      // Обработка ошибок
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ошибка'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
              onPressed: () async {
                // Обновляем данные в Firestore
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .update({
                    'username': newName,
                    'email': newEmail,
                    'phone': newPhone,
                  });
                }

                // Обновляем состояние
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
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Если пользователь не авторизован, показываем форму входа или регистрации
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(_isLogin ? 'Вход' : 'Регистрация')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
              if (!_isLogin) ...[
                SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Имя'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Номер телефона'),
                  keyboardType: TextInputType.phone,
                ),
              ],
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin; // Переключение между режимами
                  });
                },
                child: Text(_isLogin
                    ? 'Нет аккаунта? Зарегистрируйтесь'
                    : 'Уже есть аккаунт? Войдите'),
              ),
            ],
          ),
        ),
      );
    } else {
      // Если пользователь авторизован, показываем данные профиля
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
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  setState(() {
                    _isLogin = true;
                  });
                },
                child: Text('Выйти'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrdersScreen(),
                    ),
                  );
                },
                child: Text('Мои заказы'),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}