import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/favorite_provider.dart';

class ApiService {
  Future<Product> addProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return product;
  }
}

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({
    super.key,
    required this.product,
  });

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  late final ApiService _apiService;

  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  void _simulateAddProduct() async {
    setState(() => _isPosting = true);

    try {
      final newProduct = Product(
        id: 0,
        title: '${widget.product.title} - Copy',
        description: widget.product.description,
        price: widget.product.price,
        thumbnail: widget.product.thumbnail,
      );

      final result = await _apiService.addProduct(newProduct);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Produk berhasil ditambah! ID baru: ${result.id}',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text('Gagal: $e'),
          ),
        );
      }
    } finally {
      setState(() => _isPosting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, provider, _) {
              final isFav =
                  provider.isFavorite(widget.product.id);

              return IconButton(
                icon: Icon(
                  isFav
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () =>
                    provider.toggleFavorite(
                      widget.product,
                    ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container gambar produk yang besar di bagian atas (tidak terpotong)
            Container(
              color: Colors.grey[100], // Background abu-abu tipis agar estetik
              width: double.infinity,
              height: 380, // Ukuran tinggi gambar diperbesar agar terlihat jelas
              alignment: Alignment.center,
              child: Hero(
                tag: 'product-image-${widget.product.id}',
                child: Image.network(
                  widget.product.thumbnail,
                  fit: BoxFit.contain, // Gambar utuh tidak terpotong sama sekali
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 100,
                  ),
                ),
              ),
            ),
            
            // Detail informasi produk di bagian bawah gambar dengan tata letak yang dipercantik
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge penanda status stok barang
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Text(
                      'Stok Tersedia',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Judul Produk
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Harga Produk dengan warna tema dan ukuran lebih besar
                  Text(
                    'Rp. ${widget.product.price}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  const Divider(thickness: 1, color: Colors.black12), // Garis pemisah estetik
                  const SizedBox(height: 16),
                  
                  // Judul Deskripsi
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Isi Deskripsi Lengkap dengan spasi paragraf yang nyaman dibaca
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tombol Simulasi POST
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _isPosting ? null : _simulateAddProduct,
                      icon: _isPosting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.add_shopping_cart),
                      label: Text(
                        _isPosting ? 'Mengirim...' : 'Post Product',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}