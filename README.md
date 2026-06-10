# Tugas Mobile Programming - Pertemuan 8: Katalog Produk & Fitur Favorit

Aplikasi Flutter ini dibuat untuk memenuhi tugas mata kuliah Pemrograman Mobile Pertemuan 8. Aplikasi ini mengimplementasikan katalog produk yang dinamis dengan data dari API, lengkap dengan sistem penyaringan kategori, detail produk yang dipercantik, serta fitur favorit menggunakan manajemen state Provider.

## Fitur Utama

1. **Katalog Produk Dinamis**:
   - Memuat data produk dari API secara real-time.
   - Grid layout yang responsif untuk tampilan layar mobile maupun desktop web.
   - Pilihan filter kategori yang dinamis ("Semua", "Cosmetic", "Furniture", "Food", "Favorite").

2. **Detail Halaman Produk (DetailPage)**:
   - Menampilkan foto produk secara penuh dan tidak terpotong (`BoxFit.contain`).
   - Menyediakan informasi detail: judul, harga, status ketersediaan stok ("Stok Tersedia" badge), dan deskripsi lengkap produk.
   - Tombol toggle untuk menambah/menghapus produk dari daftar favorit langsung di AppBar detail.
   - Pinned Action Button ("Post Product") di bagian paling bawah layar.

3. **Manajemen State Favorit (FavoriteProvider)**:
   - Menggunakan package `provider` untuk sinkronisasi data favorit di seluruh aplikasi secara instan.
   - Menampilkan badge jumlah barang terfavorit pada ikon hati di AppBar HomePage secara real-time.
   - **Quick Favorite**: Tombol hati cepat langsung pada setiap kartu produk di beranda untuk memfavoritkan produk tanpa perlu masuk ke Detail Page.

4. **Halaman Daftar Favorit (FavoritePage)**:
   - Halaman khusus untuk melihat seluruh produk yang telah ditambahkan ke favorit.
   - Dilengkapi tombol hapus cepat (ikon tempat sampah merah) untuk menghapus langsung dari list.
   - Dapat diklik untuk kembali melihat detail produk.
   - Tampilan *empty state* yang informatif jika belum ada produk favorit.

5. **Aesthetics & Transisi**:
   - Transisi **Hero Animation** yang halus pada gambar produk saat berpindah dari beranda ke halaman detail.

## Struktur Direktori Utama

- `lib/models/`: Model data produk (`product.dart`).
- `lib/providers/`: Manajemen state (`product_provider.dart` dan `favorite_provider.dart`).
- `lib/pages/`: Halaman aplikasi (`home_page.dart`, `detail_page.dart`, `favorite_page.dart`).
- `lib/components/`: Komponen UI reusable (`product_card_component.dart`, `favorite_component.dart`, `category_filter_component.dart`).
- `lib/services/`: Logika integrasi API.

## Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terinstal di komputer Anda.
2. Masuk ke direktori project:
   ```bash
   cd "itg_mobile_pertemuan_8\itg_mobile_pertemuan_8"
   ```
3. Jalankan perintah untuk mengunduh package dependencies:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```
