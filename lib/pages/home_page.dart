import 'package:flutter/material.dart';
import 'package:itg_mobile_pertemuan_8/components/category_filter_component.dart';
import 'package:itg_mobile_pertemuan_8/components/favorite_component.dart';
import 'package:itg_mobile_pertemuan_8/components/product_card_component.dart';
import 'package:itg_mobile_pertemuan_8/providers/favorite_provider.dart';
import 'package:itg_mobile_pertemuan_8/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<ProductProvider>().fetchProducts('all');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: const [FavoriteComponent()],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return Column(
            children: [
              const CategoryFilterComponent(),
              Expanded(child: _buildContent(productProvider)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(ProductProvider provider) {
    if (provider.selectedCategory == 'favorite') {
      final favoriteProvider = context.watch<FavoriteProvider>();
      final favorites = favoriteProvider.favorites;

      if (favorites.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                'Belum ada produk favorit',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          int columnCount = 2;

          if (constraints.maxWidth > 1200) {
            columnCount = 6;
          } else if (constraints.maxWidth > 900) {
            columnCount = 5;
          } else if (constraints.maxWidth > 600) {
            columnCount = 4;
          } else if (constraints.maxWidth > 450) {
            columnCount = 3;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return ProductCardComponent(
                product: favorites[index],
              );
            },
          );
        },
      );
    }

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.errorMessage!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  provider.fetchProducts(provider.selectedCategory),
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int columnCount = 2;

        if (constraints.maxWidth > 1200) {
          columnCount = 6;
        } else if (constraints.maxWidth > 900) {
          columnCount = 5;
        } else if (constraints.maxWidth > 600) {
          columnCount = 4;
        } else if (constraints.maxWidth > 450) {
          columnCount = 3;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: provider.products.length,
          itemBuilder: (context, index) {
            return ProductCardComponent(
              product: provider.products[index],
            );
          },
        );
      },
    );
  }
}