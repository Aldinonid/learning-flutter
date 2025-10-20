import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function logout;  // Fungsi logout yang diteruskan dari AuthWrapper

  HomeScreen({required this.logout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),  // Judul halaman
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home Page!',  // Pesan sambutan
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  logout();  // Panggil fungsi logout dari AuthWrapper
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
