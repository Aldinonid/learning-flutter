import 'package:flutter/material.dart';
import 'package:flutter_module_1/page3.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Kedua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.amber,
              alignment: Alignment.center,
              child: const Text(
              'Ini Halaman Kedua 🎉',
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),
            ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman pertama
                Navigator.pop(context);
              },
              child: const Text('Kembali ke Halaman Utama'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page3()),
                );
              },
              child: const Text('Klik Aku'),
            ),
          ],
        ),
      ),
    );
  }
}
