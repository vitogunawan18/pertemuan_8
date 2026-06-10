import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'detail_page.dart';

// Halaman untuk menampilkan daftar produk yang ditambahkan ke favorit
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Favorit Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true, // Membuat judul di tengah biar rapi
      ),
      // Menggunakan Consumer untuk memantau perubahan pada FavoriteProvider
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, _) {
          final favorites = favoriteProvider.favorites;

          // Jika data favorit kosong, tampilkan pesan informatif
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 70,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Daftar favorit kamu masih kosong',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          // Menampilkan daftar produk favorit menggunakan ListView
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return Card(
                elevation: 2, // Efek bayangan biar kayak kartu asli
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: ListTile(
                  // Thumbnail produk dengan sudut tumpul
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Rp. ${product.price}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Tombol untuk menghapus langsung dari halaman favorit
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: () {
                      favoriteProvider.toggleFavorite(product);
                      // Tampilkan snackbar setelah dihapus
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} dihapus dari favorit!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  // Klik list untuk lihat detail produk
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
