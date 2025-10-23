import 'package:flutter/material.dart';
import 'package:flutter_module_1/features/logs/network_log.dart';
import '../repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String name, String profPic) login; 

  const LoginScreen({super.key, required this.login});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false; 

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      // Menampilkan SnackBar jika username atau password kosong
      _showSnackBar('Username dan password tidak boleh kosong', 'error');
      return;
    }

    setState(() {
      _isLoading = true;  // Set loading true ketika proses login dimulai
    });

    try {
      // Memanggil fungsi login dari AuthRepository
      final result = await _authRepository.login(username, password);
      
      // Setelah login berhasil
      setState(() {
        _isLoading = false;  // Set loading false ketika proses selesai
      });
      _showSnackBar('Login berhasil!', 'success');
      widget.login(result.nama, result.profPic);
    } catch (error) {
      setState(() {
        _isLoading = false;  // Set loading false jika terjadi error
      });
      // Menampilkan SnackBar jika terjadi error saat login
      _showSnackBar('Login gagal: $error', 'error');
    }
  }

  void _showSnackBar(String message, String status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),  // Durasi muncul SnackBar
        backgroundColor: status == 'success' ? Colors.blue : Colors.red,  // Warna background (bisa disesuaikan)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),  // Judul halaman
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,  // Menyembunyikan password yang dimasukkan
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()  // Menampilkan loading saat proses login
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
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
    );
  }
}
