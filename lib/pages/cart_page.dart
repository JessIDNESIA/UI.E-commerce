// lib/pages/cart_page.dart

import 'package:flutter/material.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_bottom_nav_bar.dart';
import '../widgets/cart_item_samples.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isCouponVisible = false;
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PERBAIKAN 1: Menggunakan AppBar dari ThemeData untuk konsistensi
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        // Properti seperti backgroundColor, foregroundColor, dan elevation
        // akan otomatis diambil dari tema yang didefinisikan di MaterialApp.
      ),
      body: ListView(
        // PERBAIKAN 2: Padding yang benar untuk menangani BottomNavBar.
        // Menambahkan padding di bawah ListView adalah cara yang lebih baik
        // daripada menggunakan SizedBox di akhir.
        // Nilai 80 diasumsikan sebagai tinggi CartBottomNavBar.
        padding: const EdgeInsets.only(top: 10, bottom: 90),
        children: [
          const CartItemSamples(),
          // PERBAIKAN 3: Mengekstrak bagian kupon ke dalam method terpisah
          // agar widget build utama lebih bersih dan mudah dibaca.
          _buildCouponSection(context),
        ],
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }

  /// Method untuk membangun UI bagian kupon.
  Widget _buildCouponSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Tombol untuk menampilkan/menyembunyikan input kupon
          InkWell(
            onTap: () {
              setState(() {
                _isCouponVisible = !_isCouponVisible;
              });
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.add,
                    color: colorScheme.onPrimary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Tambahkan Kode Kupon",
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),

          // Area input kupon yang bisa muncul dan hilang dengan animasi
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Visibility(
              visible: _isCouponVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _couponController,
                        decoration: InputDecoration(
                          hintText: "Masukkan Kode Kupon",
                          hintStyle: TextStyle(color: theme.hintColor.withOpacity(0.7)),
                          filled: true,
                          fillColor: colorScheme.surfaceVariant.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk menerapkan kupon di sini
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kupon berhasil diterapkan!')),
                        );
                        // Sembunyikan keyboard
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Terapkan"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
