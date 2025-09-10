import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  // Menggunakan List dari class CartItem yang sudah dibuat.
  // PASTIKAN SINTAKS DI BAWAH INI SUDAH BENAR.
  // Setiap objek CartItem({...}) harus diakhiri dengan koma (,) jika bukan item terakhir.
  final List<CartItem> _cartItems = [
    CartItem(
      name: "Apotek khas . . . ",
      price: 199.99,
      image: "assets/carts/1.jpg",
    ), // <-- Koma ini penting!
    CartItem(
      name: "Wallpaper Keren!",
      price: 179.99,
      image: "assets/carts/2.jpg",
    ), // <-- Koma ini juga penting!
    CartItem(
      name: "Ngaji di IDN",
      price: 40.00000,
      image: "assets/carts/3.jpg",
    ), // <-- Koma ini juga penting!
  ];

  void _updateQuantity(int index, int change) {
    // Jika tidak ada error di atas, baris di bawah ini akan berfungsi karena
    // Dart tahu _cartItems[index] adalah sebuah objek CartItem.
    setState(() {
      final newQuantity = _cartItems[index].quantity + change;
      // Memastikan kuantitas tidak kurang dari 1.
      if (newQuantity >= 1) {
        _cartItems[index].quantity = newQuantity;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      // Menampilkan SnackBar sebagai konfirmasi sebelum item dihapus.
      final removedItem = _cartItems.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${removedItem.name} dihapus dari keranjang."),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: "URUNGKAN",
            textColor: Colors.white,
            onPressed: () {
              setState(() => _cartItems.insert(index, removedItem));
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN 2: Mengambil data tema sekali di awal method build.
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Menampilkan pesan jika keranjang kosong.
    if (_cartItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Text("Keranjang Anda kosong."),
        ),
      );
    }

    // Menggunakan ListView.separated untuk memberikan pemisah antar item.
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cartItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  // Menambahkan error builder jika gambar tidak ditemukan
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Info Produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      // PERBAIKAN 3: Menggunakan style dari tema.
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    // Kontrol Kuantitas
                    _buildQuantityControl(index, item, colorScheme),
                  ],
                ),
              ),
              // Tombol Hapus
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: () => _removeItem(index),
              ),
            ],
          ),
        );
      },
    );
  }

  // PERBAIKAN 4: Mengekstrak widget kontrol kuantitas ke method terpisah.
  // Ini membuat widget build utama lebih rapi.
  Widget _buildQuantityControl(int index, CartItem item, ColorScheme colorScheme) {
    return Container(
      height: 36, // Memberi tinggi yang tetap agar rapi
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            iconSize: 18,
            onPressed: () => _updateQuantity(index, -1),
            splashRadius: 20,
            padding: EdgeInsets.zero,
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 18,
            onPressed: () => _updateQuantity(index, 1),
            splashRadius: 20,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
