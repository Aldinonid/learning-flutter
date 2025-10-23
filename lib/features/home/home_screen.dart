import 'package:flutter/material.dart';
import 'package:flutter_module_1/features/logs/network_log.dart';

class HomeScreen extends StatelessWidget {
  final Function logout; 
  final String name;
  final String profPic;

  const HomeScreen({super.key, required this.logout, required this.name, required this.profPic});

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
                'Welcome, $name!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              Image.network(
                profPic,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  logout();  // Panggil fungsi logout dari AuthWrapper
                },
                child: Text("Logout"),
              ),
              FloatingActionButton(
                child: const Icon(Icons.bug_report),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NetworkLogPage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
