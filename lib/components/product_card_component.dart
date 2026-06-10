import 'package:flutter/material.dart';
import 'package:itg_mobile_pertemuan_8/models/product.dart';
import 'package:itg_mobile_pertemuan_8/pages/detail_page.dart';
import 'package:itg_mobile_pertemuan_8/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

// Komponen Card untuk menampilkan produk di halaman utama
class ProductCardComponent extends StatelessWidget {
  final Product product;
  const ProductCardComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigasi ke halaman detail produk
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk dengan Hero transition dan tombol favorit cepat di pojok atas
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product-image-${product.id}',
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 48),
                      ),
                    ),
                  ),
                  // Tombol Favorit Cepat (Quick Favorite)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Consumer<FavoriteProvider>(
                      builder: (context, favProvider, _) {
                        final isFav = favProvider.isFavorite(product.id);
                        return GestureDetector(
                          onTap: () {
                            favProvider.toggleFavorite(product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white, // Latar belakang putih solid agar kontras
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey[600],
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp. ${product.price.toString()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}