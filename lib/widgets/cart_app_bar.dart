// lib/widgets/CartAppBar.dart

import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            // Tombol Kembali
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Judul
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "🛒 My Cart",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive', // Contoh penggunaan font custom
                  color: Color(0xFF4C53A5),
                ),
              ),
            ),
            const Spacer(),
            // Popup Menu
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Text("Hapus Semua"),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: Text("Bagikan Keranjang"),
                ),
              ],
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Anda memilih: $value (Visual)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
