import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final Function login;  // Fungsi login yang akan dipanggil ketika login berhasil

  const LoginScreen({super.key, required this.login});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false; 

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Menampilkan SnackBar jika email atau password kosong
      _showSnackBar('Email dan password tidak boleh kosong');
      return;
    }

    setState(() {
      _isLoading = true;  // Set loading true ketika proses login dimulai
    });

    try {
      // Memanggil fungsi login dari AuthRepository
      final result = await _authRepository.login(email, password);
      
      // Setelah login berhasil
      setState(() {
        _isLoading = false;  // Set loading false ketika proses selesai
      });
      
      // Menampilkan SnackBar jika login berhasil
      _showSnackBar('Login berhasil!');

      // Navigasi ke halaman lain setelah login berhasil
      // Misalnya: Navigator.pushReplacementNamed(context, '/home');
      
    } catch (error) {
      setState(() {
        _isLoading = false;  // Set loading false jika terjadi error
      });
      // Menampilkan SnackBar jika terjadi error saat login
      _showSnackBar('Login gagal: $error');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),  // Durasi muncul SnackBar
        backgroundColor: Colors.red,  // Warna background (bisa disesuaikan)
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
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
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
          ],
        ),
      ),
    );
  }
}
