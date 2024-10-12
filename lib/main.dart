import 'package:flutter/material.dart';
import 'package:lab_6/service/api_service.dart'; // Đảm bảo đường dẫn này đúng
import 'model/user.dart'; // Đảm bảo đường dẫn này đúng
import './RegisterPage.dart'; // Đảm bảo đường dẫn này đúng
import './Home.dart';
import './Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage()
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final String email = settings.arguments as String; // Lấy email từ arguments
          return MaterialPageRoute(
            builder: (context) {
              return ChatPage(userEmail: User(email: email, password: '0'));
            },
          );
        }
        return null;
      },
    );
  }
}
