import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/home/home_screen.dart';

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
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isAuthenticated = false;  
  String? name;
  String? profPic;

  // Fungsi untuk melakukan login
  void login(String name, String profPic) {
    setState(() {
      isAuthenticated = true;
      this.name = name;
      this.profPic = profPic;
    });
  }

  // Fungsi untuk melakukan logout
  void logout() {
    setState(() {
      isAuthenticated = false;
      name = null;
      profPic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek status login dan menampilkan layar yang sesuai
    if (isAuthenticated) {
      return HomeScreen(
        logout: logout, 
        name: name ?? "", 
        profPic: profPic ?? ""
      );
    } else {
      return LoginScreen(login: login);
    }
  }
}

