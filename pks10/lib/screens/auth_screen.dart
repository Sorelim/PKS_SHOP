import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account_screen.dart'; // Импортируйте экран аккаунта

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true; // Переключатель между входом и регистрацией

  Future<void> _submit() async {
    try {
      if (_isLogin) {
        // Авторизация
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print("User logged in: ${userCredential.user?.uid}");
        // Переход на экран аккаунта
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AccountScreen(user: userCredential.user!),
          ),
        );
      } else {
        // Регистрация
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        print("User registered: ${userCredential.user?.uid}");
        // Переход на экран аккаунта
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AccountScreen(user: userCredential.user!),
          ),
        );
      }
    } catch (e) {
      // Обработка ошибок
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Вход' : 'Регистрация'),
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
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text(_isLogin ? 'Войти' : 'Зарегистрироваться'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin; // Переключение между входом и регистрацией
                });
              },
              child: Text(_isLogin ? 'Создать аккаунт' : 'Уже есть аккаунт?'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}