import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isAuthenticated = false;  // Status login, default belum login

  // Fungsi untuk melakukan login
  void login() {
    setState(() {
      isAuthenticated = true;  // Mengubah status jadi terautentikasi
    });
  }

  // Fungsi untuk melakukan logout
  void logout() {
    setState(() {
      isAuthenticated = false;  // Mengubah status jadi belum terautentikasi
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek status login dan menampilkan layar yang sesuai
    if (isAuthenticated) {
      return HomeScreen(logout: logout);  // Jika sudah login, arahkan ke HomeScreen
    } else {
      return LoginScreen(login: login);  // Jika belum login, tampilkan LoginScreen
    }
  }
}

