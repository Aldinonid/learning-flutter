import 'package:flutter/material.dart';
import 'package:flutter_module_1/features/logs/network_log.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your full name' : null,
                onSaved: (value) => fullName = value,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a password';
                  if (value.length < 6) return 'Password must be at least 6 characters';
                  return null;
                },
                onSaved: (value) => password = value,
              ),
              const SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please confirm your password';
                  if (value != password) return 'Passwords do not match';
                  return null;
                },
                onSaved: (value) => confirmPassword = value,
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form != null && form.validate()) {
                    form.save();
                    // Lakukan aksi register, misal panggil API
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registering $fullName with email $email')),
                    );
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.bug_report),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NetworkLogPage()),
          );
        },
      ),
    );
  }
}
