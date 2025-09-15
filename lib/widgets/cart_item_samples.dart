import 'package:flutter/material.dart';

/// Sebuah kelas model untuk merepresentasikan item di keranjang belanja.
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
  // Mendefinisikan palet warna yang konsisten
  static const Color primaryColor = Color(0xFF4C53A5);
  static const Color secondaryColor = Color(0xFF6B7CDA);

  // Menggunakan List dari class CartItem yang sudah dibuat.
  final List<CartItem> _cartItems = [
    CartItem(
      name: "Apotek khas . . . ",
      price: 199.99,
      image: "assets/carts/1.jpg",
    ),
    CartItem(
      name: "Wallpaper Keren!",
      price: 179.99,
      image: "assets/carts/2.jpg",
    ),
    CartItem(
      name: "Ngaji di IDN",
      price: 40.00000,
      image: "assets/carts/3.jpg",
    ),
  ];

  /// Metode untuk memperbarui kuantitas item.
  void _updateQuantity(int index, int change) {
    setState(() {
      final newQuantity = _cartItems[index].quantity + change;
      if (newQuantity >= 1) {
        _cartItems[index].quantity = newQuantity;
      }
    });
  }

  /// Metode untuk menghapus item dari keranjang dengan SnackBar "Undo".
  void _removeItem(int index) {
    setState(() {
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (_cartItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Text("Keranjang Anda kosong."),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cartItems.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Colors.grey[300],
      ),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Produk
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      item.image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.broken_image, color: Colors.grey[400]),
                        );
                      },
                    ),
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
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: textTheme.bodyLarge?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Kontrol Kuantitas dan Tombol Hapus
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildQuantityControl(index, item),
                          IconButton(
                            icon: Icon(Icons.delete_outline,
                                color: primaryColor.withOpacity(0.7)),
                            onPressed: () => _removeItem(index),
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Metode untuk membangun widget kontrol kuantitas.
  Widget _buildQuantityControl(int index, CartItem item) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, size: 18, color: primaryColor),
            onPressed: () => _updateQuantity(index, -1),
            splashRadius: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              '${item.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, size: 18, color: primaryColor),
            onPressed: () => _updateQuantity(index, 1),
            splashRadius: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36),
          ),
        ],
      ),
    );
  }
}
