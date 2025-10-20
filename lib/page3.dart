import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan Widget Dasar')
        ),
        body: const WidgetLatihan(),
    );
  }
}

class WidgetLatihan extends StatelessWidget {
  const WidgetLatihan({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // supaya scroll kalau konten kebanyakan
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Widget
            const TextSection(title: '1. Text Widget', content: 'Menampilkan teks.'),
            const Text('Halo Flutter!'),
            const Divider(),

            // Container Widget
            const TextSection(title: '2. Container Widget', content: 'Menampilkan kotak yang fleksibel.'),
            Container(color: Colors.amber, width: 200, height: 100, child: const Center(child: Text('Ini Container'))),
            const Divider(),

            // Row & Column Widget
            const TextSection(title: '3. Row & Column Widget', content: 'Menyusun widget secara horisontal atau vertikal.'),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.red),
                Icon(Icons.star, color: Colors.green),
                Icon(Icons.star, color: Colors.blue),
              ],
            ),
            const Divider(),

            // ElevatedButton Widget
            const TextSection(title: '4. ElevatedButton', content: 'Tombol untuk aksi.'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Klik Aku'),
            ),
            const Divider(),

            // Image Widget
            const TextSection(title: '5. Image Widget', content: 'Menampilkan gambar dari internet atau lokal.'),
            Image.network(
              'https://media.tenor.com/K1zVlgTXVpYAAAAM/mi-pan-mi-pan-su-su-su.gif',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const Divider(),

            // ListView Builder
            const TextSection(title: '6. ListView.builder', content: 'Daftar item dengan scroll.'),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Item $index', style: const TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
            const Divider(),

            // GestureDetector Widget
            const TextSection(title: '7. GestureDetector', content: 'Untuk menangani gesture seperti tap.'),
            GestureDetector(
              onTap: () {
                print('Tapped!');
              },
              onDoubleTap: () {
                print('Double tapped!');
              },
              onLongPress: () {
                print('long pressed!');
              },
              child: Container(color: Colors.green, width: 100, height: 100),
            ),
            const Divider(),

            // Stack Widget
            const TextSection(title: '8. Stack Widget', content: 'Menumpuk widget satu sama lain.'),
            Stack(
              children: [
                Container(color: Colors.blue, width: 200, height: 200),
                Positioned(
                  top: 50,
                  left: 50,
                  child: Container(color: Colors.red, width: 100, height: 100),
                ),
              ],
            ),
            const Divider(),

            // AnimatedContainer Widget
            const TextSection(title: '9. AnimatedContainer', content: 'Widget dengan animasi perubahan ukuran atau warna.'),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 200,
              height: 100,
              color: Colors.blue,
              child: const Center(child: Text('Animated!')),
            ),
            const Divider(),

            // TextFormField Widget
            const TextSection(title: '10. TextFormField', content: 'Untuk input teks dengan validasi.'),
            TextFormField(
              decoration: InputDecoration(hintText: 'Masukkan teks...'),
            ),
            const Divider(),

            // AlertDialog Widget
            const TextSection(title: '11. AlertDialog', content: 'Dialog untuk konfirmasi atau pesan.'),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Peringatan'),
                      content: const Text('Ini adalah dialog peringatan!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tutup'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Tampilkan Dialog'),
            ),
            const Divider(),

            // Hero Widget
            const TextSection(title: '12. Hero Widget', content: 'Untuk animasi transisi antar halaman.'),
            const Hero(
              tag: 'hero-tag',
              child: CircleAvatar(radius: 50, backgroundColor: Colors.orange, child: Text('Hero')),
            ),
            const Divider(),

            const TextSection(title: '13. Drawer Widget', content: 'Untuk animasi transisi antar halaman.'),
            CupertinoActionSheet(
              title: const Text('Aksi'),
              message: const Text('Pilih salah satu tindakan'),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aksi 1'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Aksi 2'),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String title;
  final String content;

  const TextSection({required this.title, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        '$title\n$content',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}