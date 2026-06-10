import 'package:flutter/material.dart';
import 'package:itg_mobile_pertemuan_8/pages/favorite_page.dart';
import 'package:itg_mobile_pertemuan_8/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

// Komponen ikon favorit di AppBar yang menampilkan badge jumlah favorit
class FavoriteComponent extends StatelessWidget {
  const FavoriteComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // Memantau status terupdate dari FavoriteProvider
    final favoriteProvider = context.watch<FavoriteProvider>();
    final count = favoriteProvider.favorites.length;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Tombol ikon love di AppBar
        IconButton(
          onPressed: () {
            // Berpindah ke halaman list favorit ketika ikon ditekan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritePage(),
              ),
            );
          },
          icon: const Icon(Icons.favorite),
        ),
        // Menampilkan lingkaran merah penanda jumlah jika ada item favorit
        if (count > 0)
          Positioned(
            right: 4,
            top: 4,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: Colors.red,
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
      ],
    );
  }
}